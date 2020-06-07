module ApplicationHelper

  def replace_with_stars(string, from: 3, to: -2)
    string[from..to] = '*' * 4
    string
  end

  def subscription_btn(group)
    if group.full?
      'Group is full'
    else
      link_to 'Subscribe!',
              new_group_student_path(group.id),
              class: 'btn btn-primary',
              role: 'button'
    end
  end
end
