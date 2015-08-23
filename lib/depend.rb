require "depend/version"

module Depend
  autoload :Register,                  "depend/register"
  autoload :Dependent,                 "depend/dependent"
  autoload :Configuration,             "depend/configuration"

  module PackageProvider
    autoload :Common,    "depend/package_provider/common"
    autoload :Apt,       "depend/package_provider/apt"
    autoload :Homebrew,  "depend/package_provider/homebrew"
  end

  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.reset_configuration
    @configuration = Configuration.new
  end

  def self.configure
    puts "in configure"
    yield(configuration)
  end

  def self.register
    @register_instance ||= Register.init_with_default_register
  end

  class Base
    extend Dependent

    def initialize(platform, platform_version = nil)
      @platform = platform
      @platform_version = platform_version
    end

    def package_providers
      Depend.register.package_providers_for(@platform, @platform_version)
    end

    def dependencies_for(package_provider)
      self.class.dependencies_for(@platform, package_provider)
    end

  end

end
