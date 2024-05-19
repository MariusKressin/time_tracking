class Template < ApplicationRecord
  belongs_to :user
  has_many :template_hours, dependent: :destroy
end
