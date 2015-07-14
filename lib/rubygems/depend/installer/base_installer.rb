module Depend
  class BaseInstaller

    def self.install(names)
      fail NotImplementedError
    end
  end
end
