module Depend
  module Dependent

    def dependencies_for(platform, package_provider)
      if Depend.configuration.send("#{package_provider.display_name.downcase}_dependencies").empty?
        Depend.configuration.default_dependencies
      else
        Depend.configuration.send("#{package_provider.display_name.downcase}_dependencies")
      end
    end

  end
end
