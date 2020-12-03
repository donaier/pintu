class RolesController < ApplicationController
  before_action :authenticate_user!

  def index
    @roles = Role.all
  end

  def destroy
    Role.find(params[:id]).destroy
    redirect_to roles_path
  end
end
