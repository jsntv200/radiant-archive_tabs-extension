# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "radiant-archive_tabs-extension/version"

Gem::Specification.new do |s|
  s.name        = "radiant-archive_tabs-extension"
  s.version     = RadiantArchiveTabsExtension::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Jason Taylor"]
  s.email       = ["jsntv200@gmail.com"]
  s.homepage    = "http://github.com/jsntv200/radiant-archive_tabs-extension"
  s.summary     = %q{Archive tabs extension for Radiant CMS}
  s.description = %q{Display Archive pages in their own paginated tab}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.post_install_message = %{
  Edit your Radiant environment.rb file and add the following :

  1. Ensure Archive Tabs is loaded last

    config.extensions = [ :all, :archive_tabs ]

  2. Load Archive Tabs by adding the gem

    config.gem 'radiant-archive_tabs-extension', :version => '#{RadiantArchiveTabsExtension::VERSION}'
  }
end
