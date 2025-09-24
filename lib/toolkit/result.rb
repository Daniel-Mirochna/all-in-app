require "ostruct"

module Toolkit
  module Result
    def Success(data = nil)
      OpenStruct.new(success?: true, failure?: false, data: data, error: nil)
    end

    def Failure(error)
      OpenStruct.new(success?: false, failure?: true, data: nil, error: error)
    end
  end
end
