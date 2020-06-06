class AddColumnMaxStudentsToGroups < ActiveRecord::Migration[6.0]
  def change
    add_column :groups, :max_students, :integer, null: false, default: 20
  end
end
