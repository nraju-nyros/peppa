class Dish < ApplicationRecord
    delegate :restaurant, to: :category
    has_and_belongs_to_many :restaurants, :dependent => :destroy
    belongs_to :category

    has_many :likes, dependent: :destroy


    has_many :pictures, as: :imageble, :dependent => :destroy
    accepts_nested_attributes_for :pictures
    has_many :ratings

    scope :by_price, ->(price){order(price)}
    scope :by_rating,->{joins(:ratings).group('dishes.id').order(Arel.sql('avg(ratings.rating) desc'))}
    
    scope :sort_ratings,->(rating){joins(:ratings).group('dishes.id').having('avg(ratings.rating)>= ?',rating).order('avg(ratings.rating) asc')}
    scope :by_category, ->(category){where(category_id: category)}
    scope :by_dietary, ->(dietary){where(category_id: dietary)}


    validates_presence_of :name,message:"can't be empty"
    validates :price,:presence => true,:numericality => true
    validates :category_id, presence:true, :numericality => true  

    def self.get_previous_dish(current_dish)
        Dish.where("dishes.id < ? ", current_dish.id).order('created_at asc').last
    end


    def self.get_next_dish(current_dish)
        Dish.where("dishes.id > ? ", current_dish.id).order('created_at asc').first
    end  


   

end
