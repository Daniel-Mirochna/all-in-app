class User < ApplicationRecord
  mount_uploaders :user_files, UserFilesUploader
  validate :validate_total_size
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable

  def check_total_uploads_size
    total_size = user_files.map(&:size).sum
    max_size = 1_073_741_824 # 1 GB
    total_size.to_f / max_size
  end

  private

  def validate_total_size
    errors.add(:base, "Total size of all files cannot exceed 1 GB") if check_total_uploads_size >= 1
  end
end
