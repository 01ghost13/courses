# == Schema Information
#
# Table name: courses
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Course < ApplicationRecord
  validates :name, presence: true
  validates :name, length: { minimum: 5, maximum: 100 }
end
