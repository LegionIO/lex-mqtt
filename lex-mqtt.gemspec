# frozen_string_literal: true

require_relative 'lib/legion/extensions/mqtt/version'

Gem::Specification.new do |spec|
  spec.name          = 'lex-mqtt'
  spec.version       = Legion::Extensions::Mqtt::VERSION
  spec.authors       = ['Esity']
  spec.email         = ['matthewdiverson@gmail.com']

  spec.summary       = 'LEX::Mqtt'
  spec.description   = 'Connects Legion to MQTT brokers'
  spec.homepage      = 'https://github.com/LegionIO/lex-mqtt'
  spec.license       = 'MIT'
  spec.required_ruby_version = '>= 3.4'

  spec.metadata['homepage_uri']          = spec.homepage
  spec.metadata['source_code_uri']       = 'https://github.com/LegionIO/lex-mqtt'
  spec.metadata['documentation_uri']     = 'https://github.com/LegionIO/lex-mqtt'
  spec.metadata['changelog_uri']         = 'https://github.com/LegionIO/lex-mqtt'
  spec.metadata['bug_tracker_uri']       = 'https://github.com/LegionIO/lex-mqtt/issues'
  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'mqtt', '~> 0.6'
end
