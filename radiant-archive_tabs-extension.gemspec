# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "radiant-archive_tabs-extension"

Gem::Specification.new do |s|
  s.name        = "radiant-archive_tabs-extension"
  s.version     = RadiantArchiveTabsExtension::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = RadiantArchiveTabsExtension::AUTHORS
  s.email       = RadiantArchiveTabsExtension::EMAIL
  s.homepage    = RadiantArchiveTabsExtension::URL
  s.summary     = RadiantArchiveTabsExtension::SUMMARY
  s.description = RadiantArchiveTabsExtension::DESCRIPTION

  ignores = if File.exist?('.gitignore')
    File.read('.gitignore').split("\n").inject([]) {|a,p| a + Dir[p] }
  else
    []
  end

  s.files         = Dir['**/*'] - ignores
  s.test_files    = Dir['test/**/*','spec/**/*','features/**/*'] - ignores
  s.require_paths = ["lib"]
end
