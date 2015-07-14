module Depend
  class YumInstaller < Base

    def self.install(names)
      system "su -c 'yum install #{names.join(' ')}'"
    end
  end
end
