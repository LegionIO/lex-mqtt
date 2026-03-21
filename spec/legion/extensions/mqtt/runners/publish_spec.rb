# frozen_string_literal: true

RSpec.describe Legion::Extensions::Mqtt::Runners::Publish do
  let(:mock_client) { instance_double(MQTT::Client) }
  let(:client)      { Legion::Extensions::Mqtt::Client.new }

  before do
    allow(Legion::Extensions::Mqtt::Helpers::Client).to receive(:connection).and_return(mock_client)
    allow(mock_client).to receive(:connect)
    allow(mock_client).to receive(:disconnect)
  end

  describe '#publish' do
    before do
      allow(mock_client).to receive(:publish)
    end

    it 'publishes a message and returns success' do
      result = client.publish(topic: 'sensors/temp', payload: '22.5')
      expect(result[:published]).to be true
      expect(result[:topic]).to eq('sensors/temp')
    end

    it 'defaults retain to false' do
      result = client.publish(topic: 'test', payload: 'msg')
      expect(result[:retain]).to be false
    end

    it 'defaults qos to 0' do
      result = client.publish(topic: 'test', payload: 'msg')
      expect(result[:qos]).to eq(0)
    end

    it 'passes retain flag when specified' do
      allow(mock_client).to receive(:publish).with('test', 'msg', true, 0)
      result = client.publish(topic: 'test', payload: 'msg', retain: true)
      expect(result[:retain]).to be true
    end

    it 'passes qos level when specified' do
      allow(mock_client).to receive(:publish).with('test', 'msg', false, 1)
      result = client.publish(topic: 'test', payload: 'msg', qos: 1)
      expect(result[:qos]).to eq(1)
    end

    it 'calls connect before publishing' do
      client.publish(topic: 'test', payload: 'msg')
      expect(mock_client).to have_received(:connect)
    end

    it 'calls disconnect after publishing' do
      client.publish(topic: 'test', payload: 'msg')
      expect(mock_client).to have_received(:disconnect)
    end
  end
end
