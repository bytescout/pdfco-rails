require_relative "pdfco/version"
require_relative "pdfco/server"

require_relative 'pdfco/http_service'
require_relative 'pdfco/errors'

# miscellaneous
require_relative 'pdfco/utils'
require_relative 'pdfco/version'

if defined?(Rails)
  require_relative 'pdfco/railtie'
  require_relative 'generators/pdfco/initialize_generator'
end

module Pdfco
  class Error < StandardError; end
  
  class << self
    attr_accessor :api_key

    def root_path
      Gem::Specification.find_by_name("pdfco").gem_dir
    end

    def setup
      yield self
    end
  end

end
