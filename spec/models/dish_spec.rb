require 'rails_helper'

RSpec.describe Dish, type: :model do
  context 'validations locations' do

  	it 'ensures name presence' do
      dish = Dish.new(price: 225, category_id: 2).save
      expect(dish).to eq(false)
    end
    
    it 'ensures price presence' do
      dish = Dish.new(name:'rice', category_id: 2).save
      expect(dish).to eq(false)
    end
    
    it 'ensures category_id presence' do
      dish = Dish.new(name:'rice', price: 225).save
      expect(dish).to eq(false)
    end
    
    it 'should save successfully' do 
      dish = Dish.new(name:'rice', price: 225, category_id: 2).save
      expect(dish).to eq(true)
    end
    
  end

end














