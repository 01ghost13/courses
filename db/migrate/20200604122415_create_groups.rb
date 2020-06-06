class CreateGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :groups do |t|
      t.date :date_start, null: false
      t.date :date_finish, null: false
      t.belongs_to :course, null: false, foreign_key: true

      t.timestamps
    end
  end
end
