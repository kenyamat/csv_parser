# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'csv_parser/version'

Gem::Specification.new do |spec|
  spec.name          = "csv_parser"
  spec.version       = CsvParser::VERSION
  spec.authors       = ["Kenya Matsumoto"]
  spec.email         = ["kmatsumoto@mdsol.com"]
  spec.summary       = %q{Parsing CSV with multiline fields and escaped double quotes}
  spec.description   = %q{Parsing CSV with multiline fields and escaped double quotes}
  spec.homepage      = "https://github.com/kenyamat/csv_parser"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
