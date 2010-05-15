# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rfetion}
  s.version = "0.5.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Richard Huang"]
  s.date = %q{2010-05-15}
  s.description = %q{rfetion is a ruby gem for China Mobile fetion service that you can send SMS free.}
  s.email = %q{flyerhzm@gmail.com}
  s.executables = ["rfetion", "rfetion"]
  s.extra_rdoc_files = [
    "README.textile"
  ]
  s.files = [
    "README.textile",
     "Rakefile",
     "VERSION",
     "bin/rfetion",
     "lib/rfetion.rb",
     "lib/rfetion/buddy_list.rb",
     "lib/rfetion/command.rb",
     "lib/rfetion/contact.rb",
     "lib/rfetion/fetion.rb",
     "lib/rfetion/message.rb",
     "lib/rfetion/sipc_message.rb",
     "rfetion.gemspec",
     "spec/rfetion/fetion_spec.rb",
     "spec/rfetion/sipc_message_spec.rb",
     "spec/spec.opts",
     "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://github.com/flyerhzm/rfetion}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{rfetion is a ruby gem for China Mobile fetion service that you can send SMS free.}
  s.test_files = [
    "spec/rfetion/fetion_spec.rb",
     "spec/rfetion/sipc_message_spec.rb",
     "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<guid>, [">= 0.1.1"])
      s.add_runtime_dependency(%q<nokogiri>, [">= 0"])
    else
      s.add_dependency(%q<guid>, [">= 0.1.1"])
      s.add_dependency(%q<nokogiri>, [">= 0"])
    end
  else
    s.add_dependency(%q<guid>, [">= 0.1.1"])
    s.add_dependency(%q<nokogiri>, [">= 0"])
  end
end

