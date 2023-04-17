class Users::UploadsController < ApplicationController
  before_action :authenticate_user!

  def new
  end
  
  def create
    current_user.files.attach(params[:file])
    redirect_to root_path
  end

  def destroy
    file = current_user.files.find(params[:id])
    file.purge
    redirect_to root_path
  end
end