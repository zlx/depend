module Gem
  pre_install do |gem_installer|
    puts "install some gem append depend module"
    unless gem_installer.spec.extensions.empty?
      gem_installer.extend Gem::Installer::Depend
    end
  end


  class Installer
    module Depend
      require 'rubygems/user_interaction'
      require 'rubygems/depend/host_detection'
      require 'rubygems/depend/installer'

      include Gem::UserInteraction

      def build_extensions
        super
        puts "in build extension"
      rescue ExtensionBuildError => e
        # Install platform dependencies and try the build again.
        if install_platform_dependencies
          super
        else
          raise
        end
      end

      def install_platform_dependencies
        puts "install dependency for gem"
        platform = Depend::HostDetection.new.platform
        package_provider = Depend::HostDetection.new.package_provider
        if installer = Depend::Installer.installer_for(package_provider)
          missing_deps = Depend::Dependency.dependencies_for(platform, spec.name)

          unless missing_deps.empty?
            say "Trying to install native dependencies for Gem '#{spec.name}': #{missing_deps.join ' '}"
            unless installer.install(spec.name, missing_deps)
              raise Gem::InstallError, "Failed to install native dependencies for '#{spec.name}'."
            end
          end
          return true
        end
      end
    end
  end
end
