class UserUploadPresenter
  attr_reader :file

  def initialize(file)
    @file = file
  end

  FILE_EXTENSIONS_TYPES = {
    picture: %w[jpg jpeg png gif bmp],
    document: %w[doc docx odt txt],
    pdf: %w[pdf],
    spreadsheet: %w[xls xlsx ods],
    presentation: %w[ppt pptx],
    programming: %w[htm html js css scss rb erb]
  }.freeze

  def thumbnail_by_extension
    hash_contained_file_ext = FILE_EXTENSIONS_TYPES.find { |_k, v| v.include? file.file.extension.downcase }
    case hash_contained_file_ext.first
    when :picture
      file.thumb.url.to_s
    else
      "_blank.png"
    end
  end

  def image_by_extension
    hash_contained_file_ext = FILE_EXTENSIONS_TYPES.find { |_k, v| v.include? file.file.extension.downcase }
    case hash_contained_file_ext.first
    when :picture
      file.url.to_s
    else
      "_blank.png"
    end
  end
end
