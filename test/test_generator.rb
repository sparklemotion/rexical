require 'test/unit'
require 'tempfile'
require 'rex'
require 'stringio'

class TestGenerator < Test::Unit::TestCase
  def test_header_is_written_after_module
    rex = Rex::Generator.new(
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
    rex = Rex::Generator.new(nil)
    rex.grammar_file = 'non_existent_file'
    assert_raises Errno::ENOENT do
      rex.read_grammar
    end
  end

  def test_scanner_inherits
    rex = Rex::Generator.new(
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

  def test_simple_scanner
    rex = Rex::Generator.new(
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

  def assert_tokens expected, scanner
    tokens = []
    while token = scanner.next_token
      tokens << token
    end
    assert_equal expected, tokens
  end
end
