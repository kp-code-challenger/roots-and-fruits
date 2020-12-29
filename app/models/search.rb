class Search < ApplicationRecord
  validates :query, presence: true
  validates :body, presence: true
end
