module UserUploadsHelper
  def print_filename(file)
    file.file.basename.gsub(/__.*/, "")
  end

  def storage_space_used_percentage
    "#{(current_user.check_total_uploads_size.round(2) * 100).to_i}%"
  end

  def storage_space_left_megabytes
    "#{(1000 - (current_user.check_total_uploads_size.round(4) * 1000)).to_i} MB"
  end
end
