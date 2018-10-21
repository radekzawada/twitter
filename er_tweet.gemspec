lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'er_tweet/version'

Gem::Specification.new do |spec|
  spec.name          = 'er_tweet'
  spec.version       = ERTweet::VERSION
  spec.authors       = ['Radek']
  spec.email         = ['radek_zawada@op.pl']

  spec.summary       = 'twitter hyperlinks filterer'
  spec.description   = 'hyperlinks filterer, great tools!'
  spec.homepage      = 'https://github.com/radekzawada/twitter'

  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'fabrication', '~> 2.20'
  spec.add_development_dependency 'factory_bot', '~> 4.0'
  spec.add_development_dependency 'faker', '~> 1.9.1'
  spec.add_development_dependency 'pry', '~> 0.11.3'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.41.2'

  spec.add_dependency 'terminal-table', '~> 1.8.0'
  spec.add_dependency 'thor', '~> 0.20'
  spec.add_dependency 'twitter', '~> 6.0'
end
