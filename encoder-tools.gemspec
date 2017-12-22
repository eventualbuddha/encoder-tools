
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "encoder-tools/version"

Gem::Specification.new do |spec|
  spec.name          = "encoder-tools"
  spec.version       = EncoderTools::VERSION
  spec.authors       = ["Brian Donovan"]
  spec.email         = ["me@brian-donovan.com"]

  spec.summary       = %q{Tools for ripping, encoding, and subtitling movies and TV shows}
  spec.description   = %q{Tools for ripping, encoding, and subtitling movies and TV shows}
  spec.homepage      = "https://github.com/eventualbuddha/encoder-tools"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "thor", "~> 0.18.1"
  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
