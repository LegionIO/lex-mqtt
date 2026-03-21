# frozen_string_literal: true

require 'legion/extensions/mqtt/version'
require 'legion/extensions/mqtt/helpers/client'
require 'legion/extensions/mqtt/runners/publish'
require 'legion/extensions/mqtt/runners/subscribe'
require 'legion/extensions/mqtt/client'

module Legion
  module Extensions
    module Mqtt
      extend Legion::Extensions::Core if Legion::Extensions.const_defined? :Core

      def self.lex_settings
        { mqtt: { host: 'localhost', port: 1883, ssl: false } }
      end
    end
  end
end
