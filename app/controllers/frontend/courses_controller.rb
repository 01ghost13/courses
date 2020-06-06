class Frontend::CoursesController < FrontendController
  def index
    @q = Group.bookable.soonish.includes(:course).ransack(params[:q])

    @groups = @q.result

    @groups = @groups.page(params[:page]).per(5)
  end

  def show
    @course = Course.find(params[:id])

    @q = Group.bookable.where(course_id: @course.id).ransack(params[:q])
    @groups = @q.result

    @groups = @groups.page(params[:page]).per(5)
  end
end
