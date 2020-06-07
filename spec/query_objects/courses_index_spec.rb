require 'rails_helper'

RSpec.describe CoursesIndex do
  before do
    @course = create(:course)
    @groups = 3.times.map do |index|
      start_date = Date.current + index.days
      create(:group, date_start: start_date, date_finish: start_date + 10.days, course_id: @course.id)
    end
  end

  context 'has_places' do

    before do
      @groups_full = create(:group, :full)
      @query = CoursesIndex.new
    end

    it 'should return only free groups' do
      expect(@query.send(:has_places).ids).not_to include(@groups_full.id)
    end
  end

  context 'soonest_with_places' do
    it 'should return by ascending group order' do
      loaded_group = described_class.new.send(:soonest_with_places).where('sub_group.course_id': @course.id).to_a.first
      expect(loaded_group.date_start).to eq(@groups.first.date_start)
    end
  end
end
