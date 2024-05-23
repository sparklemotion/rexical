require_relative "lib/rexical/version"

Gem::Specification.new do |s|
  s.name = "rexical"
  s.version = Rexical::VERSION
  s.homepage = "http://github.com/sparklemotion/rexical"

  s.authors = ["Aaron Patterson"]

  s.summary = "Rexical is a lexical scanner generator that is used with Racc to generate Ruby programs"
  s.description = "Rexical is a lexical scanner generator that is used with Racc to generate Ruby programs. Rexical is written in Ruby."

  s.executables = ["rex"]

  s.rdoc_options = ["--main", "README.rdoc"]
  s.extra_rdoc_files = ["CHANGELOG.rdoc", "DOCUMENTATION.en.rdoc", "DOCUMENTATION.ja.rdoc", "README.rdoc"]

  s.files = File.read("Manifest.txt").split("\n")

  s.licenses = ["LGPL-2.1-only"]

  s.add_dependency "getoptlong"
end
