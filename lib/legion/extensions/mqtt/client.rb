# frozen_string_literal: true

require_relative 'helpers/client'
require_relative 'runners/publish'
require_relative 'runners/subscribe'

module Legion
  module Extensions
    module Mqtt
      class Client
        include Runners::Publish
        include Runners::Subscribe

        attr_reader :opts

        def initialize(host: 'localhost', port: 1883, username: nil, password: nil, ssl: false)
          @opts = { host: host, port: port, username: username, password: password, ssl: ssl }
        end

        def settings
          { options: @opts }
        end
      end
    end
  end
end
