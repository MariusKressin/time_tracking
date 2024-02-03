class Topic < ApplicationRecord
  has_many :hours, dependent: :destroy
end
