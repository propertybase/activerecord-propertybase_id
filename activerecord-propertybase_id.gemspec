# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "activerecord/propertybase_id/version"

Gem::Specification.new do |spec|
  spec.name          = "activerecord-propertybase_id"
  spec.version       = Activerecord::PropertybaseId::VERSION
  spec.authors       = ["Leif Gensert"]
  spec.email         = ["leif@propertybase.com"]

  spec.summary       = %q{Propertybase ID for ActiveRecord}
  spec.description   = %q{Use the propertybase_id as the primary key in all your rails models}
  spec.homepage      = "http://www.propertybase.com"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "propertybase_id", ">= 0.3.2"
  spec.add_dependency "activerecord", ">= 4.2", "< 4.3"

  spec.add_development_dependency "bundler", "< 1.10"
  spec.add_development_dependency "rake", "< 11.0"
  spec.add_development_dependency "rspec", "< 3.3"
  spec.add_development_dependency "factory_girl", "< 4.6"
  spec.add_development_dependency "sqlite3", "< 1.4.0"
  spec.add_development_dependency "pg", "< 0.19"
  spec.add_development_dependency "database_cleaner", "< 1.5.0"
  spec.add_development_dependency "rspec-its", "< 1.3.0"
end
