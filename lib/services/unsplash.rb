# frozen_string_literal: true

module Unsplash
  include HTTParty

  base_uri 'api.unsplash.com'
  headers 'Accept-Version' => 'v1', 'Authorization' => "Client-ID #{ENV['UNSPLASH_ACCESS_KEY']}"

  def self.photos(query = '')
    return get('/photos') if query.empty?

    get('/search/photos/', query: { query: query })
  end
end
