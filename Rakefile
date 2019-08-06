# -*- ruby -*-

require 'rubygems'
require 'hoe'

Hoe.plugin :debugging
Hoe.plugin :git
Hoe.plugins.delete :rubyforge

Hoe.spec 'rexical' do
  self.readme_file  = 'README.rdoc'
  self.history_file = 'CHANGELOG.rdoc'
  developer('Aaron Patterson', 'aaronp@rubyforge.org')
  self.extra_rdoc_files = FileList['*.rdoc']
  self.extra_dev_deps += [
    ["rubocop", "~> 0.74.0"]
  ]
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
