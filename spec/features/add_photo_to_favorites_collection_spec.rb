# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Add Photo To Favorites Collection', type: :feature do
  scenario 'Add 3 photos to favorites collection' do
    VCR.use_cassette('unsplash/photos', record: :new_episodes) { visit photos_path }

    VCR.use_cassette('unsplash/add_to_favorites', record: :new_episodes) do
      3.times do |i|
        all('a', class: 'photo-link')[i].click
      end
    end

    VCR.use_cassette('unsplash/collection_photos', record: :new_episodes) { visit collections_favorite_path }

    expect(page).to have_css('.photo', minimum: 3)
  end
end
