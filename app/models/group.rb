# == Schema Information
#
# Table name: groups
#
#  id           :bigint           not null, primary key
#  date_finish  :date             not null
#  date_start   :date             not null
#  max_students :integer          default(20), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  course_id    :bigint           not null
#
# Indexes
#
#  index_groups_on_course_id  (course_id)
#
# Foreign Keys
#
#  fk_rails_...  (course_id => courses.id)
#
class Group < ApplicationRecord
  belongs_to :course
  has_and_belongs_to_many :students

  # Dirty but needed for using +from+ with different names of tables
  scope :soonish, ->(table_name = 'groups') do
    select("distinct on(\"#{table_name}\".\"course_id\") \"#{table_name}\".*")
      .order("#{table_name}.course_id, #{table_name}.date_start")
  end

  scope :bookable, -> { where('groups.date_start >= :date', date: Date.current) }

  scope :has_places, -> do
    grouped = select('groups.*, count(students.id) as students_count').left_outer_joins(:students).group('groups.id')
    select('not_full.*').from(grouped, :not_full).where('not_full.students_count < not_full.max_students')
  end

  scope :soonest_with_places, -> { soonish('sub_group').from(has_places, :sub_group) }

  validates :date_finish, presence: true
  validates :date_start, presence: true
  validate :date_order

  private

    def date_order
      return if date_finish.blank? || date_start.blank?
      return if date_start < date_finish

      errors.add(:date_start, 'Start date is less than or equal to finish date')
    end
end
