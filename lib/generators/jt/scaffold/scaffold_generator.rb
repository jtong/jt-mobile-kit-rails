require 'generators/jt'

module Jt
  module Generators
    class ScaffoldGenerator < Base
      #desc "This generator test gem generator"
      argument :scaffold_name, :type => :string, :required => true, :banner => 'ModelName'
      def template_root
        @_template_root ||= File.expand_path('../templates', __FILE__)
      end

      def link_page
        insert_into_file "public/mobile/_pages.haml", "\n=render '#{scaffold_name}_page'", {:after => "// pages"}
        insert_into_file "public/mobile/_pages.haml", "\n=render '#{scaffold_name}_list_page'", {:after => "// pages"}
      end

      def create_domain_page
        content = File.read "#{template_root}/_page.haml"
        content = content.gsub "@{scaffold_name}", scaffold_name
        create_file "public/mobile/_#{scaffold_name}_page.haml", content
      end

      def create_domain_list_page
        content = File.read "#{template_root}/_list_page.haml"
        content = content.gsub "@{scaffold_name}", scaffold_name
        create_file "public/mobile/_#{scaffold_name}_list_page.haml", content
      end

    end
  end
end
