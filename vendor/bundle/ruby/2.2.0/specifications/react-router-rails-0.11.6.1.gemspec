# -*- encoding: utf-8 -*-
# stub: react-router-rails 0.11.6.1 ruby lib

Gem::Specification.new do |s|
  s.name = "react-router-rails"
  s.version = "0.11.6.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Mario Peixoto"]
  s.date = "2015-01-23"
  s.description = "React-Router for Rails Asset Pipeline"
  s.email = ["mario.peixoto@gmail.com"]
  s.homepage = "https://github.com/mariopeixoto/react-router-rails"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.6"
  s.summary = "A gem for distribution of the react-router using the asset pipeline"

  s.installed_by_version = "2.4.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>, ["~> 1.7"])
      s.add_development_dependency(%q<rake>, ["~> 10.0"])
      s.add_runtime_dependency(%q<railties>, [">= 3.1"])
    else
      s.add_dependency(%q<bundler>, ["~> 1.7"])
      s.add_dependency(%q<rake>, ["~> 10.0"])
      s.add_dependency(%q<railties>, [">= 3.1"])
    end
  else
    s.add_dependency(%q<bundler>, ["~> 1.7"])
    s.add_dependency(%q<rake>, ["~> 10.0"])
    s.add_dependency(%q<railties>, [">= 3.1"])
  end
end
