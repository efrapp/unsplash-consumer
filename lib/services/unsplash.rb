# frozen_string_literal: true

module Unsplash
  include HTTParty

  base_uri 'https://api.unsplash.com'
  headers 'Accept-Version' => 'v1',
          'Authorization' => "Bearer #{ENV['UNSPLASH_ACCESS_TOKEN']}"

  DEFAULT_PAGE = '1'
  DEFAULT_PER_PAGE = '10'

  Response = Struct.new(:body, :code, :message, :headers, keyword_init: true) do
    def page_control(direction = { page: 'next' })
      page_link_str = headers['link']
        .split(',')
        .select { |link_str| link_str.include?(direction[:page]) }[0]

      return nil if page_link_str.nil?

      page_link = URI(URI.extract(page_link_str)[0])
      URI.decode_www_form(page_link.query).assoc('page').last
    end
  end

  def self.photos(options = {})
    pagination = {}
    pagination[:page] = options[:page] || DEFAULT_PAGE
    pagination[:per_page] = options[:per_page] || DEFAULT_PER_PAGE

    res = if options.include?(:query)
            get('/search/photos/', query: { query: options[:query] }.merge(pagination))
          elsif options.include?(:collection_id)
            get("/collections/#{options[:collection_id]}/photos", query: pagination)
          else
            get('/photos', query: pagination)
          end

    Response.new(body: res.parsed_response, code: res.code, message: res.message, headers: res.headers)
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
