Bundler::Source::Path.instance_eval do
  unless instance_methods.include?(:orig_install)
    alias_method :orig_install, :install
    define_method(:install) do |*args|
      Gem.load_plugins
      orig_install(*args)
    end
  end
end
