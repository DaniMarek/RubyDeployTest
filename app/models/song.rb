class Song < ActiveRecord::Base
	validates :title, :artist, presence: true

	has_many :joins
	has_many :users, through: :joins
end
