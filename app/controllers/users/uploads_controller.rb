class Users::UploadsController < ApplicationController
  before_action :authenticate_user!, :set_user
  
  def index
  end

  def update
    if @user.update(uploads_params)
      render partial: "update"
    else
      flash[:error] = "Failed uploading picture"
      redirect_back_or_to users_uploads_path
    end
  end

  def destroy 
    remove_file_at_index(params[:id].to_i)
    flash[:error] = "Failed deleting picture" unless @user.save
    redirect_back_or_to users_uploads_path
  end

  private

  def set_user
    @user = current_user
  end

  def remove_file_at_index(index)
    remain_user_files = @user.user_files
    if index == 0 && @user.user_files.size == 1
      @user.remove_user_files!
    else
      deleted_file = remain_user_files.delete_at(index) 
      deleted_file.try(:remove!)
    end
  end

  def uploads_params
    params.require(:user).permit({user_files: []})
  end

end