# == Schema Information
#
# Table name: students
#
#  id         :bigint           not null, primary key
#  email      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :student do
    email { "MyString" }
  end
end
