class Frontend::CoursesController < FrontendController
  def index
    @q = Group.bookable.soonish.includes(:course).ransack(params[:q])

    @groups = @q.result

    @groups = @groups.page(params[:page]).per(5)
  end
end
