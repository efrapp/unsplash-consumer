# frozen_string_literal: true

UNSPLASH_FAVORITES_COLLECTION_ID = '9319453'
COLLECTION_ID = '1'

Collection = Struct.new(:id, :collection_id) do
  def initialize(id: COLLECTION_ID, collection_id: UNSPLASH_FAVORITES_COLLECTION_ID)
    super(id, collection_id)
  end
end
