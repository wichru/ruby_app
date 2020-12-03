# frozen_string_literal: true

require_relative '../spec_helper'

RSpec.describe PrintResults do
  subject { described_class.new(parser) }

  let(:parser) { double(page_views: { '/that_70s_show' => ['111.111.111.111'] }) }
  let(:unique_results) do
    {
      '/about' => 4,
      '/help_page/1' => 2,
      '/contact' => 1
    }
  end
  let(:all_ordered_results) do
    {
      '/about' => 4,
      '/contact' => 3,
      '/help_page/1' => 2
    }
  end

  describe 'attributes accessors' do
    it 'should have views hash' do
      expect(subject.views_hash).to eq({ '/that_70s_show' => ['111.111.111.111'] })
    end
  end

  describe 'sort results module' do
    let(:parser) do
      double(
        page_views: {
          '/help_page/1' => ['126.318.035.038', '646.865.545.408'],
          '/contact' => ['184.123.665.067', '184.123.665.067', '184.123.665.067'],
          '/about' => ['061.945.150.735', '111.111.111.111', '222.222.222.222.', '123.123.123.123']
        }
      )
    end
    context 'when it shows a unique views' do
      it 'sort by unique entrance' do
        expect(subject.sort_unique).to eq(unique_results)
        subject.call
      end
    end

    context 'when most page views shows' do
      it 'sort by all entrance' do
        expect(subject.sort_all).to eq(all_ordered_results)
        subject.call
      end
    end
  end

  describe '#call' do
    before do
      allow_any_instance_of(PrintResults).to receive(:print_results).and_return(expected_print)
    end

    let(:expected_print) do
      "       PAGE         | VIEWS
      ---------------------+----------
      /that_70s_show       | 1"
    end

    it 'print results' do
      expect(subject.call).to eq(expected_print)
    end
  end
end
