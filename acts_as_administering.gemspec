$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "acts_as_administering/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "acts_as_administering"
  s.version     = ActsAsAdministering::VERSION
  s.authors     = ["Joseph"]
  s.email       = ["villajosephe@gmail.com"]
  s.homepage    = "http://www.bigbeelabs.com"
  s.summary     = "Summary of ActsAsAdministering."
  s.description = "Description of ActsAsAdministering."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails",                   "~> 4.2"
  s.add_dependency "acts-as-taggable-on",     "~> 3.4"
  #s.add_dependency 'acts_as_relating_to',     '~> 0.0.3'

  s.add_development_dependency "pg",          '~> 0.18'
  s.add_development_dependency "rspec-rails", '~> 3.0'

end
