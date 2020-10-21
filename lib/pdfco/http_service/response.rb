module Pdfco

  module HTTPService

    class Response

      attr_reader :status, :body, :headers

      # Creates a new Response object, which standardizes the response received From Pdf.co.
      def initialize(status, body, headers)
        @status = status
        @body = JSON.parse(body)# rescue ''
        @headers = headers
      end

      # Simple predicate method to check if there is any error
      def error?
        (@body && @body["error"])
      end

    end

  end

end