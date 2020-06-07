# == Schema Information
#
# Table name: groups_students
#
#  group_id   :bigint           not null
#  student_id :bigint           not null
#
class GroupsStudent < ApplicationRecord
  belongs_to :group
  belongs_to :student

  validate :group_capacity

  private

    def group_capacity
      max_group = group.max_students
      students_count = GroupsStudent.where(group_id: group.id).count
      errors.add(:student, 'Group is already full') if max_group <= students_count
    end
end
