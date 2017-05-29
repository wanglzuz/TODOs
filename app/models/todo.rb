class Todo < ApplicationRecord
  belongs_to :user
  # Tady bych ti mohl pretect rails/db tim, ze bych ti sem poslal fakt dlouhej text :)
  validates :text, presence: true, length: {maximum: 1000}
  validates :user, presence: true

end
