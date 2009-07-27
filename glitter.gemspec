# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{glitter}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["blindgaenger"]
  s.date = %q{2009-07-27}
  s.default_executable = %q{glitter}
  s.email = %q{blindgaenger@gmail.com}
  s.executables = ["glitter"]
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc",
     "glitter.rdoc"
  ]
  s.files = [
    "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "bin/glitter",
     "default.yml",
     "glitter.gemspec",
     "glitter.rdoc",
     "lib/commands/commit.rb",
     "lib/commands/init.rb",
     "lib/commands/log.rb",
     "lib/glitter.rb",
     "lib/twitter_app.rb",
     "test/glitter_test.rb",
     "test/test_helper.rb"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/blindgaenger/glitter}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Git-Like Interface for Twitter}
  s.test_files = [
    "test/test_helper.rb",
     "test/glitter_test.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<gli>, [">= 0.2.3"])
      s.add_runtime_dependency(%q<twitter>, [">= 0.6.13"])
    else
      s.add_dependency(%q<gli>, [">= 0.2.3"])
      s.add_dependency(%q<twitter>, [">= 0.6.13"])
    end
  else
    s.add_dependency(%q<gli>, [">= 0.2.3"])
    s.add_dependency(%q<twitter>, [">= 0.6.13"])
  end
end
