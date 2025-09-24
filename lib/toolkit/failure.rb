module Toolkit
  class Failure
    attr_reader :status_code, :message, :errors

    def initialize(status_code:, message:, errors: {})
      @status_code = status_code
      @message = message
      @errors = errors
    end

    def self.from_result(result)
      new(
        status_code: result.error[:status_code],
        message: result.error[:message],
        errors: result.error[:errors] || {}
      )
    end

    def to_result
      Toolkit::Result::Failure(
        status_code: status_code,
        message: message,
        errors: errors
      )
    end

    def to_s
      "#{status_code}: #{message}"
    end

    def inspect
      "#<Toolkit::Failure status_code=#{status_code} message=\"#{message}\" errors=#{errors}>"
    end
  end
end
