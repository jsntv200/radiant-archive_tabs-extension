# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "radiant-extract-extension/version"

Gem::Specification.new do |s|
  s.name        = "radiant-extract-extension"
  s.version     = RadiantExtractExtension::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Jason Taylor"]
  s.email       = ["jsntv200@gmail.com"]
  s.homepage    = "http://github.com/jsntv200/radiant-extract-extension"
  s.summary     = %q{Extract extension for Radiant CMS}
  s.description = %q{Provides page types that will extract the pages children into a paginated tab}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.post_install_message = %{
  Add this to your radiant project with:
    config.gem 'radiant-extract-extension', :version => '#{RadiantExtractExtension::VERSION}'
  }
end
