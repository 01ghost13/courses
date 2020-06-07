class GroupDecorator < Draper::Decorator
  delegate_all

  def name
    "##{id} From #{date_start} to #{date_finish}"
  end
end
