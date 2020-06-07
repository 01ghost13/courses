# == Schema Information
#
# Table name: students
#
#  id         :bigint           not null, primary key
#  email      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Student, type: :model do
  context 'validations' do
    it 'should check email presence' do
      invalid_record = build(:student, email: nil)
      expect(invalid_record.valid?).to be_falsey
    end
  end

  context 'group capacity' do
    before do
      @student = build(:student)
      @full_group = create(:group, :full)
    end
    it 'should check if group has free places' do
      @student.groups << @full_group
      expect(@student.valid?).to be_falsey
    end
  end
end
