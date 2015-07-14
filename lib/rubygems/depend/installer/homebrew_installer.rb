module Depend
  class HomebrewInstaller < Base

    def self.install(names)
      system "su -c 'brew install #{names.join(' ')}'"
    end
  end
end
