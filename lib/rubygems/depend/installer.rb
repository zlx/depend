require 'rubygems/depend/installer/base_installer'
require 'rubygems/depend/installer/yum_installer'
require 'rubygems/depend/installer/homebrew_installer'
require 'rubygems/depend/installer/apt_installer'

module Depend
  class Installer

    package_installers = {
      'yum' => YumInstaller,
      'homebrew' => HomebrewInstaller,
      'apt' => AptInstaller
    }.freeze

    def self.installer(package_provider)
      package_installers[package_provider]
    end

  end
end
