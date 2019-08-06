gem "minitest"
require 'minitest/autorun'
require 'tempfile'
require 'rexical'
require 'stringio'
require 'open3'

class TestGenerator < Minitest::Test
  def test_header_is_written_after_module
    rex = Rexical::Generator.new(
      "--independent" => true
    )
    rex.grammar_file = File.join File.dirname(__FILE__), 'assets', 'test.rex'
    rex.read_grammar
    rex.parse

    output = StringIO.new
    rex.write_scanner output

    comments = []
    output.string.split(/[\n]/).each do |line|
      comments << line.chomp if line =~ /^#/
    end

    assert_match 'DO NOT MODIFY', comments.join
    assert_equal '#--', comments.first
    assert_equal '#++', comments.last
  end

  def test_rubocop_security
    rex = Rexical::Generator.new(
      "--independent" => true
    )
    rex.grammar_file = File.join File.dirname(__FILE__), 'assets', 'test.rex'
    rex.read_grammar
    rex.parse

    output = Tempfile.new(["rex_output", ".rb"])
    begin
      rex.write_scanner output
      output.close

      stdin, stdoe, wait_thr = Open3.popen2e "rubocop --only Security #{output.path}"
      if ! wait_thr.value.success?
        fail stdoe.read
      end
    ensure
      output.close
      output.unlink
    end
  end

  def test_read_non_existent_file
    rex = Rexical::Generator.new(nil)
    rex.grammar_file = 'non_existent_file'
    assert_raises Errno::ENOENT do
      rex.read_grammar
    end
  end

  def test_scanner_nests_classes
    source = parse_lexer %q{
module Foo
class Baz::Calculator < Bar
rule
  \d+       { [:NUMBER, text.to_i] }
  \s+       { [:S, text] }
end
end
    }

    assert_match 'Baz::Calculator < Bar', source
  end

  def test_scanner_inherits
    source = parse_lexer %q{
class Calculator < Bar
rule
  \d+       { [:NUMBER, text.to_i] }
  \s+       { [:S, text] }
end
    }

    assert_match 'Calculator < Bar', source
  end

  def test_scanner_inherits_many_levels
    source = parse_lexer %q{
class Calculator < Foo::Bar
rule
  \d+       { [:NUMBER, text.to_i] }
  \s+       { [:S, text] }
end
    }

    assert_match 'Calculator < Foo::Bar', source
  end

  def test_stateful_lexer
    m = build_lexer %q{
class Foo
rule
          \d      { @state = :digit; [:foo, text] }
  :digit  \w      { @state = nil; [:w, text] }
end
    }
    scanner = m::Foo.new
    scanner.scan_setup('1w1')
    assert_tokens [
      [:foo, '1'],
      [:w, 'w'],
      [:foo, '1']], scanner
  end

  def test_simple_scanner
    m = build_lexer %q{
class Calculator
rule
  \d+       { [:NUMBER, text.to_i] }
  \s+       { [:S, text] }
end
    }

    calc = m::Calculator.new
    calc.scan_setup('1 2 10')

    assert_tokens [[:NUMBER, 1],
                  [:S, ' '],
                  [:NUMBER, 2],
                  [:S, ' '],
                  [:NUMBER, 10]], calc
  end

  def test_simple_scanner_with_empty_action
    m = build_lexer %q{
class Calculator
rule
  \d+       { [:NUMBER, text.to_i] }
  \s+       # skips whitespaces
end
    }

    calc = m::Calculator.new
    calc.scan_setup('1 2 10')

    assert_tokens [[:NUMBER, 1],
                  [:NUMBER, 2],
                  [:NUMBER, 10]], calc
  end

  def test_parses_macros_with_escapes
    source = parse_lexer %q{
class Foo
macro
  w  [\ \t]+
rule
  {w}  { [:SPACE, text] }
end
    }

    assert source.index('@ss.scan(/[ \t]+/))')
  end

  def test_simple_scanner_with_macros
    m = build_lexer %q{
class Calculator
macro
  digit     \d+
rule
  {digit}       { [:NUMBER, text.to_i] }
  \s+       { [:S, text] }
end
    }

    calc = m::Calculator.new
    calc.scan_setup('1 2 10')

    assert_tokens [[:NUMBER, 1],
                  [:S, ' '],
                  [:NUMBER, 2],
                  [:S, ' '],
                  [:NUMBER, 10]], calc
  end

  def test_nested_macros
    source = parse_lexer %q{
class Calculator
macro
  nonascii  [^\0-\177]
  string    "{nonascii}*"
rule
  {string}       { [:STRING, text] }
end
    }

    assert_match '"[^\0-\177]*"', source
  end

  def test_more_nested_macros
    source = parse_lexer %q{
class Calculator
macro
  nonascii  [^\0-\177]
  sing      {nonascii}*
  string    "{sing}"
rule
  {string}       { [:STRING, text] }
end
    }

    assert_match '"[^\0-\177]*"', source
  end

  def test_changing_state_during_lexing
    lexer = build_lexer %q{
class Calculator
rule
       a       { self.state = :B  ; [:A, text] }
  :B   b       { self.state = nil ; [:B, text] }
end
    }

    calc1 = lexer::Calculator.new
    calc2 = lexer::Calculator.new
    calc1.scan_setup('aaaaa')
    calc2.scan_setup('ababa')

    # Doesn't lex all 'a's
    assert_raises(lexer::Calculator::ScanError) { tokens(calc1) }

    # Does lex alternating 'a's and 'b's
    calc2.scan_setup('ababa')

    assert_tokens [[:A, 'a'],
                   [:B, 'b'],
                   [:A, 'a'],
                   [:B, 'b'],
                   [:A, 'a']], calc2
  end

  def test_changing_state_is_possible_between_next_token_calls
    lexer = build_lexer %q{
class Calculator
rule
       a       { [:A, text] }
  :B   b       { [:B, text] }
end
    }

    calc = lexer::Calculator.new
    calc.scan_setup('ababa')

    assert_equal [:A, 'a'], calc.next_token
    calc.state = :B
    assert_equal [:B, 'b'], calc.next_token
    calc.state = nil
    assert_equal [:A, 'a'], calc.next_token
    calc.state = :B
    assert_equal [:B, 'b'], calc.next_token
    calc.state = nil
    assert_equal [:A, 'a'], calc.next_token
  end
  def test_match_eos
    lexer = build_lexer %q{
class Calculator
option
matcheos
rule
      a        { [:A, text] }
      $        { [:EOF, ""] }
:B    b        { [:B, text] }
     }
     calc = lexer::Calculator.new
     calc.scan_setup("a")
     assert_equal [:A, 'a'], calc.next_token
     assert_equal [:EOF, ""], calc.next_token
  end

  def parse_lexer(str)
    rex = Rexical::Generator.new("--independent" => true)
    out = StringIO.new

    rex.grammar_lines = StringScanner.new(str)
    rex.parse
    rex.write_scanner(out)

    out.string
  end

  def build_lexer(str)
    mod = Module.new
    mod.module_eval(parse_lexer(str))
    mod
  end

  def tokens(scanner)
    tokens = []
    while token = scanner.next_token
      tokens << token
    end
    tokens
  end

  def assert_tokens(expected, scanner)
    assert_equal expected, tokens(scanner)
  end
end
