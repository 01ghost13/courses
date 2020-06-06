class Frontend::CoursesController < FrontendController
  def index
    @q = Group
      .includes(:course, :students)
      .bookable
      .from(Group.soonest_with_places, :groups)
      .ransack(params[:q])
    @groups = @q.result

    @groups = @groups.page(params[:page]).per(5)
  end

  def show
    @course = Course.find(params[:id])

    @q = Group.bookable.includes(:students).where(course_id: @course.id).ransack(params[:q])
    @groups = @q.result

    @groups = @groups.page(params[:page]).per(5)
  end
end
