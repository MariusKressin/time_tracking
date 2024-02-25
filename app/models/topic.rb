class Topic < ApplicationRecord
  has_many :hours, dependent: :destroy
  has_many :template_hours, dependent: :destroy
end
