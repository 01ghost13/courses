module ApplicationHelper

  def replace_with_stars(string, from: 3, to: -2)
    string[from..to] = '*' * 4
    string
  end
end
