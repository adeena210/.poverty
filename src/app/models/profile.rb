class Profile < ApplicationRecord
    belongs_to :user

    attr_accessor :email 
end
