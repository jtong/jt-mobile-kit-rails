require 'generators/jt'
require 'rails/generators/generated_attribute'

module Jt
  module Generators
    class ScaffoldGenerator < Base
      #desc "This generator test gem generator"
      argument :scaffold_name, :type => :string, :required => true, :banner => 'ModelName'
      argument :args_for_c_m, :type => :array, :default => [], :banner => 'controller_actions and model:attributes'

      def initialize(*args, &block)
        super

        print_usage unless scaffold_name.underscore =~ /^[a-z][a-z0-9_\/]+$/

        @model_attributes = []

        args_for_c_m.each do |arg|
          if arg.include?(':')
            @model_attributes << Rails::Generators::GeneratedAttribute.new(*arg.split(':'))
          end
        end
        puts @model_attributes
      end

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
        @model_attributes.map { |a| content +="\n      = text_input name:\"#{a.name}\"" }

        create_file "public/mobile/_#{scaffold_name}_page.haml", content
      end

      def create_domain_list_page
        content = File.read "#{template_root}/_list_page.haml"
        content = content.gsub "@{scaffold_name}", scaffold_name
        create_file "public/mobile/_#{scaffold_name}_list_page.haml", content
      end

      def define_go_to_page
        insert_into_file "public/mobile/js/pages.js", "__define_go_to_page([\"#{scaffold_name}\", \"#{scaffold_name}_list\"])", {:after => "// pages"}
      end

      #def define_md_class
      #  content = File.read "#{template_root}/md_class.js"
      #  content = content.gsub "@{scaffold_name}", scaffold_name
      #  content = content.gsub "@{restful_url}", "/#{scaffold_name}/:id.json"
      #  create_file "public/mobile/js/#{scaffold_name}.js", content
      #end
      #
      #def define_page_md_class
      #  content = File.read "#{template_root}/md_class.js"
      #  content = content.gsub "@{scaffold_name}", scaffold_name
      #  content = content.gsub "@{restful_url}", "/#{scaffold_name}.json"
      #  create_file "public/mobile/js/#{scaffold_name}.js", content
      #end
    end
  end
end
