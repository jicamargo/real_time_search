class SearchStory < ApplicationRecord
  validates_uniqueness_of :ip_address, scope: [:user_name, :query]
  validates :query, :ip_address, presence: true
end
