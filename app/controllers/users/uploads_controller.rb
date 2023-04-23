class Users::UploadsController < ApplicationController
  before_action :authenticate_user!, :set_user
  
  def update
    if @user.update(uploads_params)
      redirect_to users_uploads_path
    else
      redirect_to root_path
    end
  end

  def destroy
    # file = current_user.files.find(params[:id])
    # file.purge
    redirect_to root_path
  end

  private

  def set_user
    @user = current_user
  end

  def uploads_params
    params.require(:user).permit({user_files: []})
  end

end