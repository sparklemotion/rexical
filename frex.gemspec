Gem::Specification.new do |s|
  s.name = %q{frex}
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Aaron Patterson"]
  s.date = %q{2008-07-23}
  s.default_executable = %q{frex}
  s.description = %q{Frex is a fork of Rex. Rex is a lexical scanner generator. It is written in Ruby itself, and generates Ruby program. It is designed for use with Racc.}
  s.email = ["aaronp@rubyforge.org"]
  s.executables = ["frex"]
  s.extra_rdoc_files = ["Manifest.txt"]
  s.files = ["CHANGELOG.rdoc", "DOCUMENTATION.en.rdoc", "DOCUMENTATION.ja.rdoc", "Manifest.txt", "README.ja", "README.rdoc", "Rakefile", "bin/frex", "lib/frex.rb", "lib/frex/generator.rb", "lib/frex/info.rb", "lib/frex/rexcmd.rb", "sample/a.cmd", "sample/b.cmd", "sample/c.cmd", "sample/calc3.racc", "sample/calc3.rex", "sample/calc3.rex.rb", "sample/calc3.tab.rb", "sample/error1.rex", "sample/error2.rex", "sample/sample.html", "sample/sample.rex", "sample/sample.rex.rb", "sample/sample.xhtml", "sample/sample1.c", "sample/sample1.rex", "sample/sample2.bas", "sample/sample2.rex", "sample/simple.html", "sample/simple.xhtml", "sample/xhtmlparser.racc", "sample/xhtmlparser.rex", "test/rex-20060125.rb", "test/rex-20060511.rb", "vendor/hoe.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/aaronp/frex/tree/master}
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{frex}
  s.rubygems_version = %q{1.2.0}
  s.summary = %q{Frex is a fork of Rex}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if current_version >= 3 then
    else
    end
  else
  end
end
