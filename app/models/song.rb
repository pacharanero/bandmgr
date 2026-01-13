class Song < ApplicationRecord
  belongs_to :account

  has_many :taggings, as: :taggable, dependent: :destroy
  has_many :tags, through: :taggings

  has_many :setlist_songs, dependent: :destroy
  has_many :setlists, through: :setlist_songs

  attr_accessor :tag_list

  validates :title, presence: true
end
