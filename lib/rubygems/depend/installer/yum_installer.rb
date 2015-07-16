module Depend
  class YumInstaller < BaseInstaller

    def self.install(names)
      system "su -c 'yum install #{names.join(' ')}'"
    end
  end
end
