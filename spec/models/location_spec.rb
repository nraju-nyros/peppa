require 'rails_helper'

RSpec.describe Location, type: :model do 
  context 'validations locations' do

  	it 'ensures street presence' do
      location = Location.new(city:'kakinada', pincode:533101, state:'Andhra pradesh',country:'india').save
      expect(location).to eq(false)
    end
    
    it 'ensures city presence' do
      location = Location.new(street:'mainroad',pincode:533101, state:'Andhra pradesh',country:'india').save
      expect(location).to eq(false)
    end
    
    it 'ensures pincode presence' do
      location = Location.new(street:'mainroad', city:'kakinada', state:'Andhra pradesh',country:'india').save
      expect(location).to eq(false)
    end

    it 'ensures state presence' do
      location = Location.new(street:'mainroad', city:'kakinada',pincode:533101, country:'india').save
      expect(location).to eq(false)
    end

    it 'ensures country presence' do
      location = Location.new(street:'mainroad', city:'kakinada',pincode:533101,state:'Andhra pradesh',).save
      expect(location).to eq(false)
    end
    
    it 'should save successfully' do 
      location = Location.new(street:'mainroad', city:'kakinada', pincode:533101, state:'Andhra pradesh',country:'india', latitude:16.9891, longitude:82.2475).save
      expect(location).to eq(true)
    end

  end
end
