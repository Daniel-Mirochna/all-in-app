module UserUploadsHelper
  FILE_EXTENSIONS_TYPES = {
    picture: %w{jpg png jpg gif bmp},
    document: %w{pdf doc txt}
  }

  def file_extensions(type = :picture)
    FILE_EXTENSIONS_TYPES[type]
  end
end