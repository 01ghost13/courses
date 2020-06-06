ActiveAdmin.register Group do
  permit_params :date_start,
                :date_finish,
                :course_id,
                :max_students

  preserve_default_filters!
  filter :date_start, as: :date_range
end
