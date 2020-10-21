require 'faraday'
require_relative 'http_service/response'

module Pdfco
  module HTTPService

    API_SERVER = 'api.pdf.co/v1'

    class << self


      # The address of the appropriate PDF.co server.
      #
      # @option options :use_ssl force https, even if not needed
      #
      # @return a complete server address with protocol
      def server(options = {})
        "https://#{API_SERVER}"
      end


      # Makes a request directly to Pdf.co.
      #
      # @param path the server path for this request
      # @param args
      # @param verb the HTTP method to use.
      # @param options same options passed to server method.
      #
      # @return [Pdfco::HTTPService::Response] on success. A response object representing the results from Pdf.co
      def make_request(path, args, verb, options = {})
        args = common_parameters.merge(args)
        # figure out our options for this request
        request_options = {:params => (verb == :get ? args : {})}
        # set up our Faraday connection
        conn = Faraday.new(server(options), request_options) do |f|
          f.request :multipart
          f.request :url_encoded
          f.adapter :net_http
        end
        response = conn.send(verb, server + path, (verb == :post ? args : {}))

        # Log URL and params information
        Pdfco::Utils.debug "\nPdfco [#{verb.upcase}] - #{server(options) + path} params: #{args.inspect} : #{response.status}\n"
        Pdfco::Utils.debug "\nPdfco response:#{response.inspect}\n"

        response = Pdfco::HTTPService::Response.new(response.status.to_i, response.body, response.headers)

        if response.error?
          case response.status
          when 401
            Pdfco::UnAuthorizedError.new(response)
          when 400
            Pdfco::BadInputError.new(response)
          when 404
            Pdfco::MethodNotFoundError.new(response)
          else
            Pdfco::PdfcoError.new(response)
          end
        else
          response.body
        end
      end


      # Common Parameters required for every Call to Pdf.co Server.
      # @return [Hash] of all common parameters.
      def common_parameters
        { :'x-api-key' => Pdfco.api_key }
      end

    end

  end
end