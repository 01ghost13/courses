# == Schema Information
#
# Table name: groups
#
#  id          :bigint           not null, primary key
#  date_finish :date             not null
#  date_start  :date             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  course_id   :bigint           not null
#
# Indexes
#
#  index_groups_on_course_id  (course_id)
#
# Foreign Keys
#
#  fk_rails_...  (course_id => courses.id)
#
FactoryBot.define do
  factory :group do
    date_start { "2020-06-04" }
    date_finish { "2020-06-14" }
    course { build(:course) }
  end
end
