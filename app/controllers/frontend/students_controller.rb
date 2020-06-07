class Frontend::StudentsController < FrontendController
  def new
    @student = Student.new
  end

  def create
    @student = Student.new(student_params)
    group = Group.find(params[:group_id])

    group.with_lock do
      @student.groups << group

      if @student.save
        flash[:success] = "You have been subscribed!"

        redirect_to courses_path
      else
        flash[:error] = "Something went wrong"

        render :new
      end
    end
  end

  private

    def student_params
      params
        .require(:student)
        .permit(:email)
    end
end
