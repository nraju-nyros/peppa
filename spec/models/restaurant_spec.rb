require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  
  context 'validations tests' do
  	
    it 'ensures name presence' do
      restaurant = Restaurant.new(phone: 2252252255, email: 'new@gmail.com').save
      expect(restaurant).to eq(false)
    end
    
    it 'ensures phone presence' do
      restaurant = Restaurant.new(name:'yati', email:'siva@gmail.com').save
      expect(restaurant).to eq(false)
    end
    
    it 'ensures email presence' do
      restaurant = Restaurant.new(name:'yati',phone:9787887878).save
      expect(restaurant).to eq(false)
    end
    
    it 'should save successfully' do 
      restaurant = Restaurant.new(name:'yati', email:'siva@gmail.com',phone:9787887878).save
      expect(restaurant).to eq(true)
    end

  end


end
