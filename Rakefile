# -*- ruby -*-

require 'rubygems'
require 'hoe'

$LOAD_PATH << File.join(File.dirname(__FILE__), 'lib')
require 'frex'

HOE = Hoe.new('frex', Frex::VERSION) do |p|
  p.readme_file  = 'README.rdoc'
  p.history_file = 'CHANGELOG.rdoc'
  p.developer('Aaron Patterson', 'aaronp@rubyforge.org')
  p.extra_rdoc_files = FileList['*.rdoc']
end

namespace :gem do
  namespace :spec do
    task :dev do
      File.open("#{HOE.name}.gemspec", 'w') do |f|
        HOE.spec.version = "#{HOE.version}.#{Time.now.strftime("%Y%m%d%H%M%S")}"
        f.write(HOE.spec.to_ruby)
      end
    end
  end
end

# vim: syntax=Ruby
