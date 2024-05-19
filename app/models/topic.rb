class Topic < ApplicationRecord
  belongs_to :user
  has_many :hours, dependent: :destroy
  has_many :template_hours, dependent: :destroy
end
