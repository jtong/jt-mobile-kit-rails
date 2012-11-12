require 'generators/jt'

module Jt
  module Generators

    class NewGenerator < Base

      def copy_files
        directory "source", "public/mobile"
      end

    end

  end
end
