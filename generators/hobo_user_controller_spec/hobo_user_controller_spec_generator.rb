# Another piece that I'm not even sure I need, so we'll comment it out for now
# require 'rails_generator/generators/components/controller/controller_generator'

class HoboUserControllerGenerator < Rails::Generator::NamedBase

  def initialize(args, options)
    args[0] = args[0].pluralize
    super(args, options)
  end

  def manifest
    record do |m|
      # Check for class naming collisions.
      m.class_collisions class_path, "#{class_name}Controller", "#{class_name}ControllerTest", "#{class_name}Helper"

      # Controller, helper, views, and test directories.
      m.directory File.join('app/controllers', class_path)
      m.directory File.join('app/helpers', class_path)
      m.directory File.join('app/views', class_path, file_name)
      m.directory File.join('spec/controllers', class_path)
      m.directory File.join('spec/helpers', class_path)
      m.directory File.join('spec/views', class_path, file_name)
      
      if Rails::VERSION::STRING < "2.0.0"
        @default_file_extension = "rhtml"
      else
        @default_file_extension = "html.erb"
      end

      # Controller spec, class, and helper.
      m.template 'controller_spec.rb',
        File.join('spec/controllers', class_path, "#{file_name}_controller_spec.rb")

      m.template 'helper_spec.rb',
        File.join('spec/helpers', class_path, "#{file_name}_helper_spec.rb")

      m.template 'controller:controller.rb',
        File.join('app/controllers', class_path, "#{file_name}_controller.rb")

      m.template 'controller:helper.rb',
        File.join('app/helpers', class_path, "#{file_name}_helper.rb")

      # Spec and view template for each action.
      actions.each do |action|
        m.template 'view_spec.rb',
          File.join('spec/views', class_path, file_name, "#{action}.#{@default_file_extension}_spec.rb"),
          :assigns => { :action => action, :model => file_name }
        path = File.join('app/views', class_path, file_name, "#{action}.#{@default_file_extension}")
        m.template "controller:view.#{@default_file_extension}",
          path,
          :assigns => { :action => action, :path => path }
      end
    end
  end
end
