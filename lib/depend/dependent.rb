module Depend
  module Dependent

    def dependencies_for(platform, package_provider)
      deps = []
      deps += send("dependencies_for_#{package_provider.display_name.downcase}") if respond_to?("dependencies_for_#{package_provider.display_name.downcase}")
      deps += send("dependencies_for_#{platform.downcase}") if respond_to?("dependencies_for_#{platform.downcase}")
      deps
    end

  end
end
