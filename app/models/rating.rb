class Rating < ApplicationRecord
	belongs_to :dish
	belongs_to :user
    validates_presence_of :rating,message:"select rating"
	validates_presence_of :comments,message:"can't be empty"
end
