# frozen_string_literal: true

require 'rails_helper'
require 'services/unsplash'

RSpec.describe Unsplash do
  describe '.photos' do
    let(:photos) do
      VCR.use_cassette('unsplash/photos') { Unsplash.photos }
    end
    let(:filtered_photos) do
      VCR.use_cassette('unsplash/filtered_photos') { Unsplash.photos(query: 'dogs') }
    end
    let(:collection_photos) do
      VCR.use_cassette('unsplash/collection_photos') { Unsplash.photos(collection_id: '9319453') }
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

    context 'from collection' do
      it 'returns status 200' do
        expect(collection_photos.code).to eq(200)
      end
      it 'has photos' do
        expect(collection_photos.body.size).to be > 0
      end
    end
  end

  describe '.create_collection' do
    let(:collection) do
      VCR.use_cassette('unsplash/new_collection') { Unsplash.create_collection('test collection') }
    end

    it 'returns status 201' do
      expect(collection.code).to eq(201)
    end

    it 'has an id key' do
      expect(JSON.parse(collection.body)).to have_key('id')
    end
  end

  describe '.get_collection' do
    let(:collection) do
      VCR.use_cassette('unsplash/get_collection') { Unsplash.get_collection('9319453') }
    end

    it 'returns status 200' do
      expect(collection.code).to eq(200)
    end

    it 'has name title favorite' do
      expect(JSON.parse(collection.body)['title']).to eq('favorites')
    end
  end

  describe '.add_photo_to_favorites' do
    let(:photo) do
      VCR.use_cassette('unsplash/add_photo') { Unsplash.add_photo_to_favorites('9319453', 'bL4TJNwtLMw') }
    end

    it 'returns status 201' do
      expect(photo.code).to eq(201)
    end

    it 'has photo key' do
      expect(JSON.parse(photo.body)).to have_key('photo')
    end
  end
end
