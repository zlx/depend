require 'os_platform'

module Depend
  class InstallError < ::Gem::InstallError; end

  class Installer

    def self.install(spec)
      install_platform_dependencies(spec)
    end

    def self.install_platform_dependencies(spec)
      puts "install dependency for gem"
      os_platform = OSPlatform.local
      depend_instance = Depend::Base.new(os_platform.platform, os_platform.platform_version)
      package_providers = depend_instance.package_providers
      unless package_providers.empty?
        package_provider = decide(package_providers)
        deps = depend_instance.dependencies_for(package_provider)

        unless deps.empty?
          puts "Trying to install native dependencies for Gem '#{spec.name}': #{deps.join ' '}"
          deps.each do |dep|
            unless package_provider.install(spec.name, dep)
              fail Depend::InstallError, "Failed to install native dependencies for '#{spec.name}'."
            end
          end
        end
      end
    end

    private

    def self.decide(package_providers)
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
