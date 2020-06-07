# == Schema Information
#
# Table name: students
#
#  id         :bigint           not null, primary key
#  email      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Student < ApplicationRecord
  has_many :groups_students, dependent: :destroy, validate: true
  has_many :groups, through: :groups_students

  validates :email, presence: true
end
