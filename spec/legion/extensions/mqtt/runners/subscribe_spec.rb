# frozen_string_literal: true

RSpec.describe Legion::Extensions::Mqtt::Runners::Subscribe do
  let(:mock_client) { instance_double(MQTT::Client) }
  let(:client)      { Legion::Extensions::Mqtt::Client.new }

  before do
    allow(Legion::Extensions::Mqtt::Helpers::Client).to receive(:connection).and_return(mock_client)
    allow(mock_client).to receive(:connect)
    allow(mock_client).to receive(:disconnect)
    allow(mock_client).to receive(:subscribe)
  end

  describe '#subscribe' do
    let(:mock_packet) do
      instance_double(MQTT::Packet::Publish, topic: 'sensors/temp', payload: '22.5')
    end

    it 'returns empty messages when nothing available' do
      allow(mock_client).to receive(:get_packet).and_return(nil)
      result = client.subscribe(topic: 'sensors/#', timeout: 1)
      expect(result[:messages]).to be_empty
      expect(result[:count]).to eq(0)
    end

    it 'collects messages up to max_messages' do
      call_count = 0
      allow(mock_client).to receive(:get_packet) do
        call_count += 1
        call_count <= 2 ? mock_packet : nil
      end
      result = client.subscribe(topic: 'sensors/#', timeout: 10, max_messages: 2)
      expect(result[:count]).to eq(2)
      expect(result[:messages].first[:topic]).to eq('sensors/temp')
      expect(result[:messages].first[:payload]).to eq('22.5')
    end

    it 'includes the subscribed topic in result' do
      allow(mock_client).to receive(:get_packet).and_return(nil)
      result = client.subscribe(topic: 'home/lights', timeout: 1)
      expect(result[:topic]).to eq('home/lights')
    end

    it 'calls connect before subscribing' do
      allow(mock_client).to receive(:get_packet).and_return(nil)
      client.subscribe(topic: 'test', timeout: 1)
      expect(mock_client).to have_received(:connect)
    end

    it 'calls disconnect after subscribing' do
      allow(mock_client).to receive(:get_packet).and_return(nil)
      client.subscribe(topic: 'test', timeout: 1)
      expect(mock_client).to have_received(:disconnect)
    end
  end

  describe '#get' do
    it 'returns a single message from topic' do
      allow(mock_client).to receive(:get).and_return(['sensors/temp', '19.0'])
      result = client.get(topic: 'sensors/temp')
      expect(result[:topic]).to eq('sensors/temp')
      expect(result[:payload]).to eq('19.0')
    end

    it 'calls connect before getting' do
      allow(mock_client).to receive(:get).and_return(%w[test val])
      client.get(topic: 'test')
      expect(mock_client).to have_received(:connect)
    end

    it 'calls disconnect after getting' do
      allow(mock_client).to receive(:get).and_return(%w[test val])
      client.get(topic: 'test')
      expect(mock_client).to have_received(:disconnect)
    end
  end
end
