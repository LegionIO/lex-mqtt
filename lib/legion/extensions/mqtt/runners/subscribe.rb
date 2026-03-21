# frozen_string_literal: true

module Legion
  module Extensions
    module Mqtt
      module Runners
        module Subscribe
          def subscribe(topic:, timeout: 5, max_messages: 10, **)
            messages = with_client(topic) { |c| collect_messages(c, timeout, max_messages) }
            { messages: messages, count: messages.size, topic: topic }
          end

          def get(topic:, **)
            topic_name, payload = with_client(topic, &:get)
            { topic: topic_name, payload: payload }
          end

          private

          def with_client(topic)
            client = Helpers::Client.connection(**@opts)
            client.connect
            client.subscribe(topic)
            yield(client)
          ensure
            client&.disconnect
          end

          def collect_messages(client, timeout, max_messages)
            messages = []
            deadline = Time.now + timeout
            loop do
              break if messages.size >= max_messages || Time.now > deadline

              topic_name, msg = client.get_packet&.then { |pkt| [pkt.topic, pkt.payload] }
              messages << { topic: topic_name, payload: msg } if topic_name
            rescue MQTT::Exception
              break
            end
            messages
          end
        end
      end
    end
  end
end
