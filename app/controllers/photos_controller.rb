# frozen_string_literal: true

require 'services/unsplash'

class PhotosController < ApplicationController
  def index
    @response = Unsplash.photos(page: params[:page])
    @photos = @response.body
  end
end
