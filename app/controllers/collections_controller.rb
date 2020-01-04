# frozen_string_literal: true

require 'services/unsplash'

class CollectionsController < ApplicationController
  def show
    @collection = Unsplash.get_collection '9319453'
    @photos = Unsplash.photos(collection_id: @collection['id']).body
  end
end
