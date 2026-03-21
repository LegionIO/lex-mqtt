# frozen_string_literal: true

require 'mqtt'

module Legion
  module Extensions
    module Mqtt
      module Helpers
        module Client
          def self.connection(**opts)
            MQTT::Client.new(
              host: opts[:host]     || 'localhost',
              port: opts[:port]     || 1883,
              username: opts[:username],
              password: opts[:password],
              ssl: opts[:ssl] || false
            )
          end
        end
      end
    end
  end
end
