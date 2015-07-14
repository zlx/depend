module Depend
  class AptInstaller < Base

    def self.install(names)
      system "su -c 'apt-get install #{names.join(' ')}'"
    end
  end
end
