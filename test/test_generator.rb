require 'test/unit'
require 'tempfile'
require 'rexical'
require 'stringio'

class TestGenerator < Test::Unit::TestCase
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

  def test_read_non_existent_file
    rex = Rexical::Generator.new(nil)
    rex.grammar_file = 'non_existent_file'
    assert_raises Errno::ENOENT do
      rex.read_grammar
    end
  end

  def test_scanner_inherits
    rex = Rexical::Generator.new(
      "--independent" => true
    )
    rex.grammar_lines = StringScanner.new %q{
class Calculator < Bar
rule
  \d+       { [:NUMBER, text.to_i] }
  \s+       { [:S, text] }
end
    }

    rex.parse

    output = StringIO.new
    rex.write_scanner output
    assert_match 'Calculator < Bar', output.string
  end

  def test_scanner_inherits_many_levels
    rex = Rexical::Generator.new(
      "--independent" => true
    )
    rex.grammar_lines = StringScanner.new %q{
class Calculator < Foo::Bar
rule
  \d+       { [:NUMBER, text.to_i] }
  \s+       { [:S, text] }
end
    }

    rex.parse

    output = StringIO.new
    rex.write_scanner output
    assert_match 'Calculator < Foo::Bar', output.string
  end

  def test_simple_scanner
    rex = Rexical::Generator.new(
      "--independent" => true
    )
    rex.grammar_lines = StringScanner.new %q{
class Calculator
rule
  \d+       { [:NUMBER, text.to_i] }
  \s+       { [:S, text] }
end
    }

    rex.parse

    output = StringIO.new
    rex.write_scanner output

    m = Module.new
    m.module_eval output.string
    calc = m::Calculator.new
    calc.scan_evaluate('1 2 10')

    assert_tokens [[:NUMBER, 1],
                  [:S, ' '],
                  [:NUMBER, 2],
                  [:S, ' '],
                  [:NUMBER, 10]], calc
  end

  def test_simple_scanner_with_macros
    rex = Rexical::Generator.new(
      "--independent" => true
    )
    rex.grammar_lines = StringScanner.new %q{
class Calculator
macro
  digit     \d+
rule
  {digit}       { [:NUMBER, text.to_i] }
  \s+       { [:S, text] }
end
    }

    rex.parse

    output = StringIO.new
    rex.write_scanner output

    m = Module.new
    m.module_eval output.string
    calc = m::Calculator.new
    calc.scan_evaluate('1 2 10')

    assert_tokens [[:NUMBER, 1],
                  [:S, ' '],
                  [:NUMBER, 2],
                  [:S, ' '],
                  [:NUMBER, 10]], calc
  end

  def test_nested_macros
    rex = Rexical::Generator.new(
      "--independent" => true
    )
    rex.grammar_lines = StringScanner.new %q{
class Calculator
macro
  nonascii  [^\0-\177]
  string    "{nonascii}*"
rule
  {string}       { [:STRING, text] }
end
    }

    rex.parse

    output = StringIO.new
    rex.write_scanner output
    assert_match '"[^\0-\177]*"', output.string
  end

  def test_more_nested_macros
    rex = Rexical::Generator.new(
      "--independent" => true
    )
    rex.grammar_lines = StringScanner.new %q{
class Calculator
macro
  nonascii  [^\0-\177]
  sing      {nonascii}*
  string    "{sing}"
rule
  {string}       { [:STRING, text] }
end
    }

    rex.parse

    output = StringIO.new
    rex.write_scanner output
    assert_match '"[^\0-\177]*"', output.string
  end

  def test_changing_state_during_lexing
    lexer = build_lexer <<-END
class Calculator
rule
       a       { state = :B  ; [:A, text] }
  :B   b       { state = nil ; [:B, text] }
end
END

    calc = lexer::Calculator.new
    # Doesn't lex all 'a's
    assert_raise(lexer::Calculator::ScanError) { calc.scan_evaluate('aaaaa') }
    # Does lex alternating 'a's and 'b's
    calc.scan_evaluate('ababa')

    assert_tokens [[:A, 'a'],
                   [:B, 'b'],
                   [:A, 'a'],
                   [:B, 'b'],
                   [:A, 'a']], calc
  end

  def build_lexer(str)
    rex = Rexical::Generator.new("--independent" => true)
    out = StringIO.new
    mod = Module.new

    rex.grammar_lines = StringScanner.new(str)
    rex.parse
    rex.write_scanner(out)

    mod.module_eval(out.string)
    mod
  end

  def assert_tokens expected, scanner
    tokens = []
    while token = scanner.next_token
      tokens << token
    end
    assert_equal expected, tokens
  end
end
