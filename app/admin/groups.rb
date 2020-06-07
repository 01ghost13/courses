ActiveAdmin.register Group do
  permit_params :date_start,
                :date_finish,
                :course_id,
                :max_students

  filter :date_start, as: :date_range
  filter :date_finish, as: :date_range
  filter :max_students, as: :numeric
end
