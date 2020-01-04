# frozen_string_literal: true

require 'services/unsplash'

class PhotosController < ApplicationController
  def index
    @response = Unsplash.photos(page: params[:page])
    @photos = @response.body
  end

  def add_to_favorites
    response = Unsplash.add_photo_to_favorites(@favorites_collection.collection_id, params['unsplash_id'])

    if response.code == 201
      flash[:success] = 'Photo added successfully'
    else
      flash[:danger] = response.message
    end

    redirect_to photos_path
  end
end
