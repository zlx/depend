module Depend
  module PackageProvider
    class Homebrew
      include Common

      def command
        "brew"
      end

      def installed?(dep)
        puts "Run: #{command} info #{dep}"
        !!system("#{command} info #{dep}")
      end
    end
  end
end
