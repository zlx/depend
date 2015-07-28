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
      require 'os_platform'
      require 'depend'

      include Gem::UserInteraction

      alias_method :orig_build_extensions, :build_extensions

      def build_extensions
        puts "in build extension"
        install_platform_dependencies
        orig_build_extensions
      end

      def install_platform_dependencies
        puts "install dependency for gem"
        os_platform = OSPlatform.local
        platform, platform_version = os_platform.platform, os_platform.platform_version
        depend_instance = Depend::Base.new(platform, platform_version)
        package_providers = depend_instance.package_providers
        unless package_providers.empty?
          package_provider = decide(package_providers)
          deps = depend_instance.dependencies_for(package_provider)

          unless deps.empty?
            say "Trying to install native dependencies for Gem '#{spec.name}': #{deps.join ' '}"
            deps.each do |dep|
              unless package_provider.new.install(spec.name, dep)
                raise Gem::InstallError, "Failed to install native dependencies for '#{spec.name}'."
              end
            end
          end
        end
      end

      private

      def decide(package_providers)
        if package_providers.size > 1
          puts "You have installed many package_providers, which do your want to install dependency for #{spec.name}"
          puts package_providers.map.each_with_index do |p, i|
            "#{i+1}: #{p.display_name}\n"
          end.join
          index = STDIN.getc
          (package_providers[index] || package_providers.shift).new
        else
          package_providers.shift.new
        end
      end
    end
  end
end
