class Frontend::StudentsController < FrontendController
  def new
    @student = Student.new
  end

  def create
    @student = Student.new(student_params)
    @student.groups << Group.find(params[:group_id])

    if @student.save
      flash[:success] = "You have been subscribed!"

      redirect_to courses_path
    else
      flash[:error] = "Something went wrong"

      render :new
    end
  end

  private

    def student_params
      params
        .require(:student)
        .permit(:email)
    end
end
