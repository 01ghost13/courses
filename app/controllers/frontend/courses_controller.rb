class Frontend::CoursesController < FrontendController
  def index
    res = CoursesIndex.new
    @q = res.ransack_query(params[:q])
    @groups = res.paged(params[:page])
  end

  def show
    @course = Course.find(params[:id])

    @q = Group.bookable.includes(:students).where(course_id: @course.id).ransack(params[:q])
    @groups = @q.result

    @groups = @groups.page(params[:page]).per(5)
  end
end
