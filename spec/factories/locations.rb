FactoryBot.define do
  factory :location do
    street {'main road'}
    city {'Kakinda'}
    state {'Ap'}
    pincode {533001}
    country {'India'}
    latitude { "9.99" }
    longitude { "9.99" }
  end
end
