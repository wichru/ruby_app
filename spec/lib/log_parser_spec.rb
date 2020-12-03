# frozen_string_literal: true

require_relative '../spec_helper'

RSpec.describe LogParser do
  subject { described_class.new(path) }
  let(:path) { 'spec/fixtures/sample.log' }

  describe 'attributes accessors' do
    it 'should have file path' do
      subject.file_path = 'test/path.log'
      expect(subject.file_path).to eq('test/path.log')
    end

    it 'should have page views' do
      subject.page_views = { '/help_page/1' => ['126.318.035.038'] }
      expect(subject.page_views).to eq({ '/help_page/1' => ['126.318.035.038'] })
    end
  end

  describe '#parse' do
    context 'when filepath was provided' do
      let(:expected_hash) do
        {
          '/help_page/1' => [
            '126.318.035.038',
            '929.398.951.889',
            '722.247.931.582',
            '646.865.545.408',
            '543.910.244.929'
          ],
          '/contact' => [
            '184.123.665.067',
            '184.123.665.067'
          ],
          '/home' => [
            '184.123.665.067',
            '235.313.352.950'
          ],
          '/about' => ['061.945.150.735']
        }
      end

      it 'return parsed hash' do
        expect(subject.parse).to eq(expected_hash)
      end
    end

    context 'when provided path does not exists' do
      let(:path) { 'some/path/logs.log' }

      it 'raise custom error' do
        expect { subject.parse }.to raise_error(MissingFileError, 'No such file or directory')
      end
    end
  end
end
