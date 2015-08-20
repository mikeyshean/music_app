class Track < ActiveRecord::Base
  validates :album_id, :name, :lyrics, presence: true
end
