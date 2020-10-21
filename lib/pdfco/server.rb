require 'faraday'
require 'base64'

module Pdfco

  class Server

    def self.method_missing(method, *args, &block)
      endpoint = "/"
      endpoint << method.to_s.gsub('_', '/')

      hyphenated_url = args.first.delete(:hyphenated_url) if args.first.is_a?(Hash)
      endpoint << "/#{hyphenated_url}" if hyphenated_url

      self.request(endpoint, *args, &block)
    end

    private

    def self.request(endpoint_url= nil, params= {}, method_verb= :post)
      if endpoint_url == "/file/upload" && params[:file]
        params = { file: Faraday::UploadIO.new(params[:file], '*/*') }
      elsif endpoint_url == "/file/upload/base64" && params[:file]
        base64_bytes = Base64.encode64(File.read(params[:file]))
        params = { file: "data:*/*;base64," + base64_bytes }
      end

      services(endpoint_url, params, method_verb)
    end


    def self.services(path, args, method=:post)
      HTTPService.make_request(path, args, method)
    end
  end

end