module Depend
  module PackageProvider
    class Apt
      include Common

      def command
        'apt-get'
      end

      def installed?(dep)
        !!system("dpkg -s #{dep}")
      end
    end
  end
end
