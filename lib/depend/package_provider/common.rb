module Depend
  module PackageProvider
    module Common
      # Install dep for spec
      #
      def install(spec, dep)
        unless installed?(dep)
          print "#{spec} need #{dep} installed, Install it with #{display_name} now? y(y/n)"
          y = STDIN.getc
          exec_install(dep) unless y.downcase == 'n'
        end
        installed?(dep)
      end

      # exec install command
      #
      # command: command for package_provider
      # dep: library need installed
      def exec_install(dep)
        `#{command} install #{dep}`
      end

      # command for package_provider
      #
      def command
        fail NotImplementedError, "Implement #command in subclass"
      end

      # Check package_provider exist in this system
      #
      def exist?
        paths = (
          ENV['PATH'].split(::File::PATH_SEPARATOR) +
          %w(/bin /usr/bin /sbin /usr/sbin /opt/local/bin)
        )

        paths.each do |path|
          possible = File.join(path, command)
          return possible if File.executable?(possible)
        end

        false
      end

      # display_name for package_provider
      #
      def display_name
        self.class.to_s.split("::").last.capitalize
      end

      # check dep installed in this system
      def installed?(dep)
        fail NotImplementedError, "Implement #installed in subclass"
      end
    end
  end
end
