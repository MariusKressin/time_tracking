class Template < ApplicationRecord
  has_many :template_hours, dependent: :destroy
end
