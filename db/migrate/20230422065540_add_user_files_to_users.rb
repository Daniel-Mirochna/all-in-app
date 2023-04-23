class AddUserFilesToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :user_files, :json
  end
end
