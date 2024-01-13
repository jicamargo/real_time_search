class SearchStory < ApplicationRecord
  validates_uniqueness_of :ip_address, scope: [:user, :query]
end
