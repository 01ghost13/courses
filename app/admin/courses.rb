ActiveAdmin.register Course do
  permit_params :name

  preserve_default_filters!
  filter :groups,
         as: :select,
         collection: proc { Group.all.decorate }
end
