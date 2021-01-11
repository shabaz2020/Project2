class Artist < ApplicationRecord
    has_many :songs
    has_many :subscriptions
    has_many :users, through: :subscriptions

    def self.find_by_query(query_term)
        self.where("name LIKE ?", "%#{query_term}%")
    end

end
