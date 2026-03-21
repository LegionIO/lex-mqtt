# Changelog

## [0.1.0] - 2026-03-21

### Added
- `Helpers::Client` module with `.connection` factory method wrapping `MQTT::Client`
- `Runners::Publish` with `publish` (topic, payload, retain, qos)
- `Runners::Subscribe` with `subscribe` (topic, timeout, max_messages) and `get` (single message)
- Standalone `Client` class including all runner modules
- Framework `lex_settings` declaring default host, port, and ssl settings
