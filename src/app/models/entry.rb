class Entry < ApplicationRecord
  belongs_to :directory
  belongs_to :user

  validates :name, presence: true
  validates :address_1, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zipcode, presence: true
  validates :phone_number, presence: true


  geocoded_by :address 
  before_validation :geocode
  after_validation :found_address?

  def found_address?
    if latitude.blank? || longitude.blank?
      puts address()
      errors.add(address(), "We couldn't find the address")
    end
  end

  def address
    if address_2.nil?
      [address_1, city,state,zipcode,"USA"].compact.join(', ')
    else
      [address_1, address_2, city,state,zipcode,"USA"].compact.join(', ')
    end
  end

end
