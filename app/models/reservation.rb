class Reservation < ApplicationRecord
  validates :party_size, presence: true

  validate :restaurant_hours
  validate :reservations_party_size
  validate :date_in_the_past


  belongs_to :user
  belongs_to :restaurant



  def restaurant_hours
    if restaurant.open >= self.time || restaurant.close <= self.time
      errors.add(:base, "Restaurant - Not Open")
    end
  end


  def reservations_party_size
   if restaurant.capacity.to_i < self.party_size.to_i  || 1 > self.party_size.to_i
     errors.add(:base, "Party Size - Not available!")
   end
 end

 def date_in_the_past
   if self.date < Time.now
     errors.add(:base, "Invalid Date or Time!")
   end
 end






end
