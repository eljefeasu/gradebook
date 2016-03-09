class GradesController < ApplicationController
  before_action :authenticate
  before_action :authenticate_teacher, only: [:new]
  before_action :set_grade, only: [:show, :edit, :update, :destroy]

  # GET /grades
  # GET /grades.json
  def index
    if session[:user_type] == "Student"
      @grades = Grade.where(student_id: session[:user_id])
    elsif session[:user_type] == "Teacher"
      @grades = Grade.where(student_id: params[:student_id])
    elsif session[:user_type] == "Parent"
      parent = Parent.find(session[:user_id])
      @grades = Grade.where(student_id: parent.student_id)
    end
  end

  # GET /grades/1
  # GET /grades/1.json
  def show
  end

  # GET /grades/new
  def new
    @grade = Grade.new
    @student_id = params[:student_id]
  end

  # GET /grades/1/edit
  def edit
  end

  # POST /grades
  # POST /grades.json
  def create
    @grade = Grade.new(grade_params)

    respond_to do |format|
      if @grade.save
        blow up
        format.html { redirect_to grades_path, notice: 'Grade was successfully created.' }
        format.json { render :show, status: :created, location: @grade }
      else
        format.html { render :new }
        format.json { render json: @grade.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /grades/1
  # PATCH/PUT /grades/1.json
  def update
    respond_to do |format|
      if @grade.update(grade_params)
        format.html { redirect_to @grade, notice: 'Grade was successfully updated.' }
        format.json { render :show, status: :ok, location: @grade }
      else
        format.html { render :edit }
        format.json { render json: @grade.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /grades/1
  # DELETE /grades/1.json
  def destroy
    @grade.destroy
    respond_to do |format|
      format.html { redirect_to grades_url, notice: 'Grade was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_grade
      @grade = Grade.find(params[:id])
      unless @grade.student.teacher_id == session[:user_id] && session[:user_type] == "Teacher"
        begin
          redirect_to :back, notice: "You do not have permission to access that page." unless session[:user_type] == "Teacher"
        rescue ActionController::RedirectBackError
          redirect_to root_path, notice: "You do not have permission to access that page." unless session[:user_type] == "Teacher"
        end
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def grade_params
      params.require(:grade).permit(:grade, :assignment_name, :date_due, :student_id)
    end
end
