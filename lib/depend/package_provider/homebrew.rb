module Depend
  module PackageProvider
    class Homebrew
      include Common

      def command
        "brew"
      end

      def installed?(dep)
        !!system("#{command} info #{dep}")
      end
    end
  end
end
