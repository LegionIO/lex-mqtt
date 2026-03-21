# frozen_string_literal: true

module Legion
  module Extensions
    module Mqtt
      module Runners
        module Publish
          def publish(topic:, payload:, retain: false, qos: 0, **)
            client = Helpers::Client.connection(**@opts)
            client.connect
            client.publish(topic, payload, retain, qos)
            { published: true, topic: topic, retain: retain, qos: qos }
          ensure
            client&.disconnect
          end
        end
      end
    end
  end
end
