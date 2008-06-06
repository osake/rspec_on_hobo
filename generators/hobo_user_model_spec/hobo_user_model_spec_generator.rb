class HoboUserModelGenerator < Rails::Generator::NamedBase

  def manifest
    record do |m|
      # Check for class naming collisions.
      m.class_collisions class_path, class_name, "#{class_name}Test"

      # Model, test, and fixture directories.
      m.directory File.join('app/models', class_path)
      m.directory File.join('spec/models', class_path)
      m.directory File.join('spec/fixtures', class_path)

      # Model class, unit test, and fixtures.
      m.template 'model.rb',      File.join('app/models', class_path, "#{file_name}.rb")
      m.template 'model:fixtures.yml',  File.join('spec/fixtures', class_path, "#{table_name}.yml")
      m.template 'model_spec.rb',       File.join('spec/models', class_path, "#{file_name}_spec.rb")
    end
  end

  protected
    def banner
      "Usage: #{$0} #{spec.name} ModelName"
    end

end
