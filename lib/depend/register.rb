module Depend
  class PlatformNotSupportedError < StandardError; end

  class Register

    OPERATION_SYSTEMS = %w{ Ubuntu mac_os_x }.freeze
    attr_reader :platforms

    def self.init_with_default_register
      instance = self.new
      instance.register PackageProvider::Apt,      'Ubuntu'
      instance.register PackageProvider::Homebrew, 'mac_os_x'
      instance
    end

    def acceptable_operations_systems
      OPERATION_SYSTEMS
    end

    def package_providers_for(platform, platform_version)
      puts @platforms
      return [] if @platforms.nil? || @platforms.empty?
      _platform = @platforms[platform] || []
      _platform.select{|plat| version_include?(plat.shift, platform_version)}.map(&:last)
    end

    def register(package_provider, platform, platform_version = nil)
      puts "in register"
      fail PlatformNotSupportedError unless platform_accepted?(platform)
      @platforms ||= {}
      if @platforms[platform]
        @platforms[platform] << [platform_version, package_provider]
      else
        @platforms[platform] = [[platform_version, package_provider]]
      end
    end

    private

    def version_include?(version_string, platform_version)
      return true if version_string.nil?
      min_version, max_version = version_string.split(",").map(&:strip)
      return unless min_version
      if max_version
        Gem::Version.new(min_version) <= Gem::Version.new(platform_version) &&
          Gem::Version.new(platform_version) <= Gem::Version.new(max_version)
      else
        Gem::Version.new(platform_version) >= Gem::Version.new(min_version)
      end
    end

    def platform_accepted?(platform)
      acceptable_operations_systems.map(&:downcase).include?(platform.downcase)
    end

  end
end
