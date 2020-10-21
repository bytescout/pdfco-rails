module Pdfco

  class PdfcoError < StandardError
    attr_accessor :verbose_message, :status, :error_body, :headers, :body

    # Create a new API Error
    # @return the newly created APIError
    def initialize(response)
      @body = response.body
      @status = response.status
      @headers = response.headers

      unless @body.nil? || @body.empty?
        @verbose_message = @body['message']
      end

      super(@verbose_message)

    end

    # Just to enable user to call this method on response object to know if any error has occured
    # Free user form the Hastle of checking the class of object on every request.
    def error?
      true
    end
  end

  # A standard Error calss for Raising error if input parameters are bad [400]
  class BadInputError < ::Pdfco::PdfcoError; end

  # A standard Error calss for Raising error if user is not allowed to perform this action [401]
  class UnAuthorizedError < ::Pdfco::PdfcoError; end

  # A standard Error calss for Raising error if api user trying to access does not exist [404]
  class MethodNotFoundError < ::Pdfco::PdfcoError; end

end