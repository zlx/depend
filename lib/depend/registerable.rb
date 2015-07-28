module Depend
  class PlatformNotSupportedError < StandardError; end

  module Registerable
    OPERATION_SYSTEMS = %w{ Ubuntu MacOS }.freeze
    attr_accessor :platforms

    def acceptable_operations_systems
      OPERATION_SYSTEMS
    end

    def register(package_provider, platform, platform_version = nil)
      fail PlatformNotSupportedError unless platform_accepted?(platform)
      @platforms ||= {}
      if @platforms[platform]
        @platforms[platform] << [platform_version, package_provider]
      else
        @platforms[platform] = [[platform_version, package_provider]]
      end
    end

    def package_providers_for(platform, platform_version)
      return [] if @platforms.nil? || @platforms.empty?
      _platform = @platforms[platform]
      _platform.select{|plat| version_include?(plat.shift, platform_version)}.map(&:last)
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
      OPERATION_SYSTEMS.map(&:downcase).include?(platform.downcase)
    end
  end
end
