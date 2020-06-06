class CreateStudents < ActiveRecord::Migration[6.0]
  def change
    create_table :students do |t|
      t.string :email, null: false

      t.timestamps
    end

    create_join_table :students, :groups
  end
end
