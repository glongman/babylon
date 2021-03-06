# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{babylon}
  s.version = "0.1.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["julien Genestoux"]
  s.date = %q{2009-06-04}
  s.default_executable = %q{babylon}
  s.email = %q{julien.genestoux@gmail.com}
  s.executables = ["babylon"]
  s.extra_rdoc_files = [
    "LICENSE",
    "README.rdoc"
  ]
  s.files = [
    "LICENSE",
    "README.rdoc",
    "Rakefile",
    "bin/babylon",
    "lib/babylon.rb",
    "lib/babylon/base/controller.rb",
    "lib/babylon/base/stanza.rb",
    "lib/babylon/base/view.rb",
    "lib/babylon/client_connection.rb",
    "lib/babylon/component_connection.rb",
    "lib/babylon/generator.rb",
    "lib/babylon/router.rb",
    "lib/babylon/router/dsl.rb",
    "lib/babylon/runner.rb",
    "lib/babylon/xmpp_connection.rb",
    "lib/babylon/xmpp_parser.rb",
    "lib/babylon/xpath_helper.rb",
    "templates/babylon/app/controllers/controller.rb",
    "templates/babylon/app/stanzas/stanza.rb",
    "templates/babylon/app/views/view.rb",
    "templates/babylon/config/boot.rb",
    "templates/babylon/config/config.yaml",
    "templates/babylon/config/dependencies.rb",
    "templates/babylon/config/routes.rb",
    "templates/babylon/log/development.log",
    "templates/babylon/log/production.log",
    "templates/babylon/log/test.log",
    "templates/babylon/script/component",
    "templates/babylon/tmp/pids/README"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/julien51/babylon}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.requirements = ["eventmachine", "yaml", "fileutils", "log4r", "nokogiri", "sax-machine", "templater", "daemons", "optparse", "digest/sha1", "base64", "resolv"]
  s.rubyforge_project = %q{babylon}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Babylon is a framework to create EventMachine based XMPP External Components in Ruby.}
  s.test_files = [
    "spec/bin/babylon_spec.rb",
    "spec/em_mock.rb",
    "spec/lib/babylon/base/controller_spec.rb",
    "spec/lib/babylon/base/stanza_spec.rb",
    "spec/lib/babylon/base/view_spec.rb",
    "spec/lib/babylon/client_connection_spec.rb",
    "spec/lib/babylon/component_connection_spec.rb",
    "spec/lib/babylon/generator_spec.rb",
    "spec/lib/babylon/router/dsl_spec.rb",
    "spec/lib/babylon/router_spec.rb",
    "spec/lib/babylon/runner_spec.rb",
    "spec/lib/babylon/xmpp_connection_spec.rb",
    "spec/lib/babylon/xmpp_parser_spec.rb",
    "spec/lib/babylon/xpath_helper_spec.rb",
    "spec/spec_helper.rb",
    "test/babylon_test.rb",
    "test/test_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<eventmachine>, [">= 0"])
      s.add_runtime_dependency(%q<log4r>, [">= 0"])
      s.add_runtime_dependency(%q<nokogiri>, [">= 1.3.0"])
      s.add_runtime_dependency(%q<eventmachine>, [">= 0"])
      s.add_runtime_dependency(%q<julien51-sax-machine>, [">= 0"])
      s.add_runtime_dependency(%q<templater>, [">= 0"])
      s.add_runtime_dependency(%q<daemons>, [">= 0"])
    else
      s.add_dependency(%q<eventmachine>, [">= 0"])
      s.add_dependency(%q<log4r>, [">= 0"])
      s.add_dependency(%q<nokogiri>, [">= 1.3.0"])
      s.add_dependency(%q<eventmachine>, [">= 0"])
      s.add_dependency(%q<julien51-sax-machine>, [">= 0"])
      s.add_dependency(%q<templater>, [">= 0"])
      s.add_dependency(%q<daemons>, [">= 0"])
    end
  else
    s.add_dependency(%q<eventmachine>, [">= 0"])
    s.add_dependency(%q<log4r>, [">= 0"])
    s.add_dependency(%q<nokogiri>, [">= 1.3.0"])
    s.add_dependency(%q<eventmachine>, [">= 0"])
    s.add_dependency(%q<julien51-sax-machine>, [">= 0"])
    s.add_dependency(%q<templater>, [">= 0"])
    s.add_dependency(%q<daemons>, [">= 0"])
  end
end
