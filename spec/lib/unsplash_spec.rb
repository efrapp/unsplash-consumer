# frozen_string_literal: true

require 'rails_helper'
require 'services/unsplash'

RSpec.describe Unsplash do
  describe '.photos' do
    let(:photos) do
      VCR.use_cassette('unsplash/photos') { Unsplash.photos }
    end
    let(:filtered_photos) do
      VCR.use_cassette('unsplash/filtered_photos') { Unsplash.photos('dogs') }
    end

    context 'without search query' do
      it 'returns status 200' do
        expect(photos.code).to eq(200)
      end
      it 'has photos' do
        expect(photos.body.size).to be > 0
      end
    end
    context 'with search query' do
      it 'returns status 200' do
        expect(filtered_photos.code).to eq(200)
      end
      it 'has photos' do
        expect(filtered_photos.body.size).to be > 0
      end
    end
  end
end
