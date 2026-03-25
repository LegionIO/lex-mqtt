# lex-mqtt: MQTT Integration for LegionIO

**Repository Level 3 Documentation**
- **Parent**: `/Users/miverso2/rubymine/legion/extensions-other/CLAUDE.md`
- **Grandparent**: `/Users/miverso2/rubymine/legion/CLAUDE.md`

## Purpose

Legion Extension that connects LegionIO to MQTT brokers. Provides runners for publishing messages to topics and subscribing to receive messages.

**GitHub**: https://github.com/LegionIO/lex-mqtt
**License**: MIT
**Version**: 0.1.0

## Architecture

```
Legion::Extensions::Mqtt
├── Runners/
│   ├── Publish    # publish (single message, configurable retain/QoS)
│   └── Subscribe  # subscribe (collect messages up to timeout/max_messages), get (single message)
├── Helpers/
│   └── Client     # MQTT::Client connection factory (host, port, SSL, credentials)
└── Client         # Standalone client class (includes all runners)
```

## Key Files

| Path | Purpose |
|------|---------|
| `lib/legion/extensions/mqtt.rb` | Entry point, extension registration, default settings |
| `lib/legion/extensions/mqtt/runners/publish.rb` | publish runner |
| `lib/legion/extensions/mqtt/runners/subscribe.rb` | subscribe and get runners |
| `lib/legion/extensions/mqtt/helpers/client.rb` | MQTT::Client connection factory |
| `lib/legion/extensions/mqtt/client.rb` | Standalone Client class |

## Settings

```json
{
  "lex-mqtt": {
    "host": "localhost",
    "port": 1883,
    "ssl": false
  }
}
```

Optional: `username:`, `password:`, `client_id:`.

## Dependencies

| Gem | Purpose |
|-----|---------|
| `mqtt` (~> 0.6) | MQTT client library (pure Ruby) |

## Development

25 specs total.

```bash
bundle install
bundle exec rspec
bundle exec rubocop
```

---

**Maintained By**: Matthew Iverson (@Esity)
