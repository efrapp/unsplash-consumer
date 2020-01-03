# frozen_string_literal: true

module Unsplash
  include HTTParty

  base_uri 'https://api.unsplash.com'
  headers 'Accept-Version' => 'v1',
          'Authorization' => "Bearer #{ENV['UNSPLASH_ACCESS_TOKEN']}"

  def self.photos(query = '')
    return get('/photos') if query.empty?

    get('/search/photos/', query: { query: query })
  end

  def self.create_collection(name = 'favorites')
    post('/collections', body: { title: name })
  end
end