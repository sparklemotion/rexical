require 'test/unit'
require 'tempfile'
require 'frex' 

class TestGenerator < Test::Unit::TestCase
  def test_header_is_written_after_module
    file = File.join(Dir::tmpdir, 'out.rb')
    rex = Frex::Generator.new(
      "--independent" => true,
      "--output-file" => file
    )
    rex.grammar_file = (File.join(File.dirname(__FILE__), 'assets', 'test.rex'))
    rex.read_grammar
    rex.parse
    rex.write_scanner

    comments = []
    File.open(file, 'rb') { |f|
      f.each_line do |line|
        comments << line.chomp if line =~ /^#/
      end
    }
    assert_match 'DO NOT MODIFY', comments.join
    assert_equal '#++', comments.first
    assert_equal '#--', comments.last
  end
end
