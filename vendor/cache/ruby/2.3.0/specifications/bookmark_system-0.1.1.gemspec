# -*- encoding: utf-8 -*-
# stub: bookmark_system 0.1.1 ruby lib

Gem::Specification.new do |s|
  s.name = "bookmark_system".freeze
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Pablo Martin Viva".freeze]
  s.date = "2018-04-11"
  s.description = "An active record bookmark system developed using ruby on rails 5 applying domain driven design and test driven development principles.".freeze
  s.email = ["pmviva@gmail.com".freeze]
  s.homepage = "http://github.com/pmviva/bookmark_system".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.0.0".freeze)
  s.rubygems_version = "3.0.6".freeze
  s.summary = "An active record bookmark system.".freeze

  s.installed_by_version = "3.0.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rails>.freeze, [">= 5.0", "< 6.0"])
      s.add_development_dependency(%q<appraisal>.freeze, ["~> 2.2"])
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.14"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 12.0"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 3.6"])
      s.add_development_dependency(%q<shoulda-matchers>.freeze, ["~> 3.1"])
      s.add_development_dependency(%q<sqlite3>.freeze, ["~> 1.3"])
      s.add_development_dependency(%q<yard>.freeze, ["~> 0.9"])
    else
      s.add_dependency(%q<rails>.freeze, [">= 5.0", "< 6.0"])
      s.add_dependency(%q<appraisal>.freeze, ["~> 2.2"])
      s.add_dependency(%q<bundler>.freeze, ["~> 1.14"])
      s.add_dependency(%q<rake>.freeze, ["~> 12.0"])
      s.add_dependency(%q<rspec>.freeze, ["~> 3.6"])
      s.add_dependency(%q<shoulda-matchers>.freeze, ["~> 3.1"])
      s.add_dependency(%q<sqlite3>.freeze, ["~> 1.3"])
      s.add_dependency(%q<yard>.freeze, ["~> 0.9"])
    end
  else
    s.add_dependency(%q<rails>.freeze, [">= 5.0", "< 6.0"])
    s.add_dependency(%q<appraisal>.freeze, ["~> 2.2"])
    s.add_dependency(%q<bundler>.freeze, ["~> 1.14"])
    s.add_dependency(%q<rake>.freeze, ["~> 12.0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.6"])
    s.add_dependency(%q<shoulda-matchers>.freeze, ["~> 3.1"])
    s.add_dependency(%q<sqlite3>.freeze, ["~> 1.3"])
    s.add_dependency(%q<yard>.freeze, ["~> 0.9"])
  end
end
