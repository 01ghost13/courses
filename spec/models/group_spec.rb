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
require 'rails_helper'

RSpec.describe Group, type: :model do
  context 'validations' do
    it 'should check date start presence' do
      invalid_record = build(:group, date_start: nil)
      expect(invalid_record.valid?).to be_falsey
    end

    it 'should check date finish presence' do
      invalid_record = build(:group, date_finish: nil)
      expect(invalid_record.valid?).to be_falsey
    end

    it 'should check date order' do
      invalid_record = build(:group, date_start: Date.current + 10.days, date_finish: Date.current)
      expect(invalid_record.valid?).to be_falsey
    end

    it 'should have not equal dates' do
      invalid_record = build(:group, date_start: Date.current, date_finish: Date.current)
      expect(invalid_record.valid?).to be_falsey
    end

    it 'should have course' do
      invalid_record = build(:group, course: nil)
      expect(invalid_record.valid?).to be_falsey
    end
  end

  context 'scopes' do
    context 'soonish' do
      before do
        @course = create(:course)
        @groups = 3.times.map do |index|
          start_date = Date.current + index.days
          create(:group, date_start: start_date, date_finish: start_date + 10.days, course_id: @course.id)
        end
      end

      it 'should return by ascending group order' do
        loaded_group = described_class.soonish.where(course_id: @course.id).to_a.first
        expect(loaded_group.min_date).to eq(@groups.first.date_start)
      end

      it 'should return groups from today' do
        create(:group, date_start: Date.current - 1.day, course_id: @course.id, date_finish: Date.current + 10.days)

        loaded_groups = described_class.bookable.where(course_id: @course.id).first
        expect(loaded_groups.date_start).to be >= Date.current
      end
    end
  end
end
