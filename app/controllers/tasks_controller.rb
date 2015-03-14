class TasksController < ApplicationController
  before_action :set_project
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = @project.tasks

    if params[:complete]
      @tasks = @project.tasks.where(complete: params[:complete])
      @active_page = "Incomplete Tasks"
    else
      @active_page = "All Tasks"
    end

    if params[:order_description] == "true"
      @tasks = @project.tasks.all.order(:description)
    end

    if params[:complete] && params[:order_by_description] == "true"
      @tasks = @project.tasks.where(complete: params[:complete]).order(:description)
    end

    if params[:order_by_due_date] == "true"
      @tasks = @project.tasks.all.order(:due_date)
    end

    if params[:complete] && params[:order_by_due_date] == "true"
      @tasks = @project.tasks.where(complete: params[:complete]).order(:due_date)
    end

    respond_to do |format|
      format.html
      format.csv do
        headers['Content-Disposition'] = "attachment; filename=\"tasks-list\""
        headers['Content-Type'] ||= 'text/csv'
      end
    end

  end

  def show
  end

  def new
    @task = @project.tasks.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = @project.tasks.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to project_task_path(@project), notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to project_task_path(@project, @task), notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to project_tasks_path(@project), notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def incomplete
    @tasks = Task.all.where(complete: false)
    render :index
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = @project.tasks.find(params[:id])
    end

    def set_project
      @project = Project.find(params[:project_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:description, :complete, :due_date, :project_id)
    end
end
