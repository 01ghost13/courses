class Frontend::CoursesController < FrontendController
  def index
    courses = Course.all
    @ransack_search = courses.ransack(params[:q])
    result = @ransack_search.result

    @courses = result.page(params[:page]).per(5)
  end
end
