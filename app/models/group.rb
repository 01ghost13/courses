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
class Group < ApplicationRecord
  belongs_to :course

  scope :soonish, -> { select("course_id, min(groups.date_start) as min_date").group(:course_id) }
  scope :bookable, -> { where('groups.date_start >= :date', date: Date.current) }
  # Ransack custom sort
  scope :sort_by_min_date_asc, -> { order(min_date: :asc) }
  scope :sort_by_min_date_desc, -> { order(min_date: :desc) }

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
