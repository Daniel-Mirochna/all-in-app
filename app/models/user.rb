class User < ApplicationRecord
  mount_uploaders :user_files, UserFilesUploader
  validate :check_total_size
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable

  private
  def check_total_size
    total_size = self.user_files.map(&:size).sum
    max_size = 1073741824 # 1 GB
    errors.add(:base, "Total size of all files cannot exceed 1 GB") if total_size > max_size
  end
end
