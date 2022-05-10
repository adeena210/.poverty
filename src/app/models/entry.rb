#Project name: ./poverty/resources
#Description: This website contains directories containing non-profit organizations, projects, and food banks that help those suffering from period poverty. 
#One can create an account and create entries for these directories. Additionally, if you require help or would simply like to donate products, 
#you can go to a directory, and search for locations closest to you
#Filename: entry.rb
#Description: The entry model page includes the associations it has with user and directory. It also includes the validation of the presence of certain fields. 
#It also includes methods for address that are used by Geocoder as well as other components as well. 
#Last modified on: 4/20/2022

class Entry < ApplicationRecord
  belongs_to :directory
  belongs_to :user

  validates :name, presence: true
  validates :address_1, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zipcode, presence: true


  geocoded_by :address_search 
  before_validation :geocode
  after_validation :found_address?

  def found_address?
    if latitude.blank? || longitude.blank?
      puts address()
      errors.add(address(), "We couldn't find the address")
    end
  end

  def address
    if address_2.blank?
      [address_1, city,state,zipcode,"USA"].compact.join(', ')
    else
      [address_1, address_2, city,state,zipcode,"USA"].compact.join(', ')
    end
  end

  def address_search
      return [address_1, state, zipcode, "USA"].compact.join(', ')
  end

end
