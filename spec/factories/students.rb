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
    email { Faker::Internet.email }
    groups { build_list(:group, 2) }
  end
end
