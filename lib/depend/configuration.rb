module Depend
  class Configuration
    attr_accessor :default_dependencies, :homebrew_dependencies, :apt_dependencies

    def initialize
      @default_dependencies = []
      @homebrew_dependencies = []
      @apt_dependencies = []
    end

    def dependencies_for_default=(deps = [])
      @default_dependencies = deps
    end

    def dependencies_for_homebrew=(deps = [])
      @homebrew_dependencies = deps
    end

    def dependencies_for_apt=(deps = [])
      @apt_dependencies = deps
    end
  end
end
