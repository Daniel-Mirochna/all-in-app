module Toolkit
  module Performable
    def perform(*args, **kwargs)
      new(*args, **kwargs).perform
    end
  end
end
