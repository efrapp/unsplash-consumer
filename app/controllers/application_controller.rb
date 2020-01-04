# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :favorites_collection

  private

  def favorites_collection
    # without parameters it will create and object with the id
    # of a predefined collection in the Unplash platform
    @favorites_collection = Collection.new
  end
end
