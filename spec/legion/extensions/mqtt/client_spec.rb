# frozen_string_literal: true

RSpec.describe Legion::Extensions::Mqtt::Client do
  describe '#initialize' do
    it 'stores default host' do
      client = described_class.new
      expect(client.opts[:host]).to eq('localhost')
    end

    it 'stores default port' do
      client = described_class.new
      expect(client.opts[:port]).to eq(1883)
    end

    it 'accepts custom host' do
      client = described_class.new(host: 'broker.example.com')
      expect(client.opts[:host]).to eq('broker.example.com')
    end

    it 'accepts custom port' do
      client = described_class.new(port: 8883)
      expect(client.opts[:port]).to eq(8883)
    end

    it 'accepts username and password' do
      client = described_class.new(username: 'user', password: 'secret')
      expect(client.opts[:username]).to eq('user')
      expect(client.opts[:password]).to eq('secret')
    end

    it 'accepts ssl flag' do
      client = described_class.new(ssl: true)
      expect(client.opts[:ssl]).to be true
    end

    it 'defaults ssl to false' do
      client = described_class.new
      expect(client.opts[:ssl]).to be false
    end
  end

  describe '#settings' do
    it 'returns options hash' do
      client = described_class.new(host: 'mqtt.local', port: 1883)
      expect(client.settings).to eq({ options: { host: 'mqtt.local', port: 1883, username: nil, password: nil,
                                                 ssl: false } })
    end
  end

  describe 'runner inclusion' do
    it 'includes Publish runner' do
      expect(described_class.ancestors).to include(Legion::Extensions::Mqtt::Runners::Publish)
    end

    it 'includes Subscribe runner' do
      expect(described_class.ancestors).to include(Legion::Extensions::Mqtt::Runners::Subscribe)
    end
  end
end
