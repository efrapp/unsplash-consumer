# frozen_string_literal: true

module Unsplash
  include HTTParty

  base_uri 'https://api.unsplash.com'
  headers 'Accept-Version' => 'v1',
          'Authorization' => "Bearer #{ENV['UNSPLASH_ACCESS_TOKEN']}"

  def self.photos(options = {})
    return get('/search/photos/', query: { query: options[:query] }) if options.include?(:query)

    get('/photos')
  end

  def self.create_collection(name = 'favorites')
    post('/collections', body: { title: name })
  end

  def self.get_collection(id)
    get("/collections/#{id}")
  end

  def self.add_photo_to_favorites(collection_id, photo_id)
    post("/collections/#{collection_id}/add", body: { photo_id: photo_id })
  end
end
