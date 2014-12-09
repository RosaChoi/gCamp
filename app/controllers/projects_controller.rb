class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.create(project_params)
    redirect_to @project, notice: 'Project was successfully created'
  end

  def show
  end

  def update
    @project.update(project_params)
    redirect_to @project, notice: 'Project was successfully updated'
  end

  def destroy
    @project.destroy
    redirect_to projects_url, notice: 'Project was successfully deleted'
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name)
  end

end
