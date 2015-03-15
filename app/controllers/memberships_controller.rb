class MembershipsController < ApplicationController
  before_action :set_project

  def index
    #members on project
    @memberships = @project.memberships
    #members not on project
    @membership = @project.memberships.new
  end

  def create
    @membership = @project.memberships.new(membership_params)
    if @membership.save
      redirect_to project_memberships_path(@project), notice: "#{@membership.user.full_name} was added successfully"
    else
      redirect_to project_memberships_path(@project), alert: membership.errors.full_messages
    end
  end

  def update
    @membership = @project.memberships.find(params[:id])
    if @membership.update(membership_params)
      redirect_to project_memberships_path(@project), notice: "#{@membership.user.full_name} was successfully updated"
    else
      render :edit
    end
  end

  def destroy
    @membership = @project.memberships.find(params[:id])
    @membership.destroy
    redirect_to project_memberships_path(@project), notice: "#{@membership.user.full_name} was successfully deleted"
  end

  private
    def set_project
      @project = Project.find(params[:project_id])
    end

    def membership_params
      params.require(:membership).permit(
      :project_id,
      :user_id,
      :role,
      )
    end
end
