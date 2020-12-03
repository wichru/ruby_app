# frozen_string_literal: true

require_relative '../spec_helper'

shared_examples_for 'sort attributes' do
  subject { described_class.new(parser) }

  context 'when it shows a unique views' do
    let(:unique_results) do
      {
        '/about' => 4,
        '/help_page/1' => 2,
        '/contact' => 1
      }
    end

    it 'sort by unique entrance' do
      expect { subject.sort_unique }.to eq(unique_results)
    end
  end

  context 'when most page views shows' do
    let(:all_ordered_results) do
      {
        '/about' => 4,
        '/contact' => 3,
        '/help_page/1' => 2
      }
    end

    it 'sort by all entrance' do
      expect { subject.sort_all }.to eq(all_ordered_results)
    end
  end
end
