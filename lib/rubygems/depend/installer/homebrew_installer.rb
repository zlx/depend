module Depend
  class HomebrewInstaller < BaseInstaller

    def self.install(names)
      system "su -c 'brew install #{names.join(' ')}'"
    end
  end
end
