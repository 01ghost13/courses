# == Schema Information
#
# Table name: courses
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Course, type: :model do
  context 'validations' do
    it 'should check name presence' do
      invalid_record = build(:course, name: '')
      expect(invalid_record.valid?).to be_falsey
    end

    it 'should check name size' do
      invalid_record = build(:course, name: 'a' * 4)
      expect(invalid_record.valid?).to be_falsey
    end
  end
end
