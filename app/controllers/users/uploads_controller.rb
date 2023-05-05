module Users
  class UploadsController < ApplicationController
    before_action :authenticate_user!, :set_user

    def index; end

    def show
      @file = @user.user_files[params[:id].to_i]
      @file_id = params[:id].to_i
    end

    def update
      if @user.update(uploads_params)
        render partial: "update"
      else
        flash[:error] = @user.errors.full_messages.first
        redirect_back_or_to users_uploads_path
      end
    end

    def destroy
      remove_file_at_index(params[:id].to_i)
      if @user.save
        render partial: "destroy"
      else
        flash[:error] = "Failed deleting picture"
        redirect_back_or_to users_uploads_path
      end
    end

    private

    def set_user
      @user = current_user
    end

    def remove_file_at_index(index)
      remain_user_files = @user.user_files
      if index.zero? && @user.user_files.size == 1
        @user.remove_user_files!
      else
        deleted_file = remain_user_files.delete_at(index)
        deleted_file.try(:remove!)
      end
    end

    def uploads_params
      params.require(:user).permit({ user_files: [] })
    end
  end
end
