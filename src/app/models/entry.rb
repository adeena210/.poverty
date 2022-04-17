class Entry < ApplicationRecord
  belongs_to :directory
  belongs_to :user
end
