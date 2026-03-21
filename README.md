# lex-mqtt

LegionIO extension for MQTT broker integration. Publish and subscribe to MQTT topics via the `mqtt` gem.

## Usage

### Standalone Client

```ruby
require 'lex-mqtt'

client = Legion::Extensions::Mqtt::Client.new(
  host:     'broker.example.com',
  port:     1883,
  username: 'user',
  password: 'secret',
  ssl:      false
)

# Publish a message
client.publish(topic: 'sensors/temperature', payload: '22.5')
client.publish(topic: 'sensors/temperature', payload: '22.5', retain: true, qos: 1)

# Get a single message
result = client.get(topic: 'sensors/temperature')
# => { topic: 'sensors/temperature', payload: '22.5' }

# Subscribe and collect messages
result = client.subscribe(topic: 'sensors/#', timeout: 5, max_messages: 10)
# => { messages: [...], count: 3, topic: 'sensors/#' }
```

## Configuration

Default `lex_settings`:

| Key | Default |
|-----|---------|
| `mqtt.host` | `'localhost'` |
| `mqtt.port` | `1883` |
| `mqtt.ssl` | `false` |

## Dependencies

- `mqtt` (~> 0.6)
- Ruby >= 3.4
