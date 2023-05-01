module UserUploadsHelper
  FILE_EXTENSIONS_TYPES = {
    picture: %w[jpg jpeg png gif bmp],
    document: %w[doc docx odt txt],
    pdf: %w[pdf],
    spreadsheet: %w[xls xlsx ods],
    presentation: %w[ppt pptx],
    programming: %w[htm html js css scss rb erb]
  }.freeze

  def file_extensions(type = :picture)
    FILE_EXTENSIONS_TYPES[type]
  end
end
