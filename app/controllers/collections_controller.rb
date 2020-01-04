# frozen_string_literal: true

require 'services/unsplash'

class CollectionsController < ApplicationController
  def favorite
    @collection = Unsplash.get_collection @favorites_collection.collection_id
    @photos = Unsplash.photos(collection_id: @collection['id']).body
  end
end
