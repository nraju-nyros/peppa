class Picture < ApplicationRecord
	belongs_to :imageble, :polymorphic => true
	mount_uploader :image, ImageUploader # used for carrierwave gem
	validates_presence_of :image,message:"can't be empty"
end
