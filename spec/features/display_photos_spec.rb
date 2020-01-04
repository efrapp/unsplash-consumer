# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Display photos', type: :feature do
  scenario 'photos without search query' do
    VCR.use_cassette('unsplash/photos', record: :new_episodes) { visit photos_path }

    expect(current_path).to eq photos_path

    expect(page).to have_css('.photo', count: 10)
  end
end
