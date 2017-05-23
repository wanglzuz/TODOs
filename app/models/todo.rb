class Todo < ApplicationRecord
  belongs_to :user
  validates :text, presence: true
  validates :user, presence: true
end
