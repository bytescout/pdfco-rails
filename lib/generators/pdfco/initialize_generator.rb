require 'rails/generators'

module Pdfco
  class InitializeGenerator < Rails::Generators::Base

    source_root File.expand_path("../../templates", __FILE__)

    def copy_initializer_file
      copy_file "pdfco.template", "config/initializers/pdfco.rb"
    end

  end
end