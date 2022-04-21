#Project name: ./poverty/resources
#Description: This website contains directories containing non-profit organizations, projects, and food banks that help those suffering from period poverty. 
#One can create an account and create entries for these directories. Additionally, if you require help or would simply like to donate products, 
#you can go to a directory, and search for locations closest to you
#Filename: directory.rb
#Description: The directory model page simply includes the associations it has with entries.
#Last modified on: 4/20/2022
class Directory < ApplicationRecord
    has_many :entries, dependent: :delete_all
    validates :location, presence: true

end
