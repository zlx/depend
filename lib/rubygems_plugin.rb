require 'depend/installer'

Gem.pre_install do |gem_installer|
  puts "inside gem pre install"
  Depend::Installer.install
end
