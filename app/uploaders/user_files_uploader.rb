class UserFilesUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url(*args)
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process scale: [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  version :thumb, if: :image? do
    process resize_to_fill: [150, 150]
  end

  # Add an allowlist of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_allowlist
    %w(jpg jpeg gif png bmp htm html js css scss rb erb txt doc docx odt ods pdf xls xlsx ppt pptx)
  end

  # Validate the size of a single file
  def size_range
    1.byte..10.megabytes
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

  def filename
    "#{file.basename}__#{secure_token}.#{file.extension}" if original_filename.present?
  end

  private

  def image?(new_file)
    new_file.content_type.start_with?('image/')
  end

  def secure_token
    media_original_filenames_var = :"@#{mounted_as}_original_filenames"

    model.instance_variable_set(media_original_filenames_var, {}) unless model.instance_variable_get(media_original_filenames_var)

    unless model.instance_variable_get(media_original_filenames_var).map { |k, _v| k }.include? original_filename.to_sym
      new_value = model.instance_variable_get(media_original_filenames_var).merge({ "#{original_filename}": SecureRandom.uuid })
      model.instance_variable_set(media_original_filenames_var, new_value)
    end

    model.instance_variable_get(media_original_filenames_var)[original_filename.to_sym]
  end
end
