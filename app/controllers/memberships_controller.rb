class MembershipsController < ApplicationController
  before_action :set_project

  def index
    #members on project
    @memberships = @project.memberships
    #members not on project
    @membership = @project.memberships.new
  end



  private
    def set_project
      @project = Project.find(params[:project_id])
    end

    def membership_params
      params.require(:membership).permit(
      :project_id,
      :user_id,
      :role
      )
    end
end
