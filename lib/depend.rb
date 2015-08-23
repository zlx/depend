require "depend/version"

module Depend
  autoload :Registerable,              "depend/registerable"
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

  class Base
    extend Registerable
    extend Dependent

    self.register PackageProvider::Apt,      'Ubuntu'
    self.register PackageProvider::Homebrew, 'MacOS'

    OPERATION_SYSTEMS = %w{ Ubuntu MacOS }.freeze

    def initialize(platform, platform_version = nil)
      @platform = platform
      @platform_version = platform_version
    end

    def package_providers
      self.class.package_providers_for(@platform, @platform_version)
    end

    def dependencies_for(package_provider)
      self.class.dependencies_for(@platform, package_provider)
    end

  end

end
