$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "obfuscatable/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "obfuscatable"
  s.version     = Obfuscatable::VERSION
  s.authors     = ["Daisuke Taniwaki"]
  s.email       = ["daisuketaniwaki@gmail.com"]
  s.summary     = "Mask ActiveRecord IDs"
  s.description = "Make your ActiveRecord IDs non-obvious"
  s.homepage    = "https://github.com/dtaniwaki/obfuscatable"
  s.licenses    = ['MIT']

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "scatter_swap",    "~> 0.0.3"
  s.add_dependency "rails",           ">= 3.2"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails", "~> 2.11.4"
  s.add_development_dependency "capybara",    "~> 1.1.2"
  s.add_development_dependency "guard-rspec"
  s.add_development_dependency "guard-spork"
  s.add_development_dependency "rb-inotify"
  s.add_development_dependency "test-unit"
end
