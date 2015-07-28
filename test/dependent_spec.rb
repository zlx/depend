require 'minitest_helper'

describe Depend::Dependent do
  class AnonymousClass
    extend Depend::Dependent
  end

  it "should get dependents from package_provider" do
    class AnonymousClass
      class << self
      def dependencies_for_apt
        ['lib1']
      end

      def dependencies_for_homebrew
        ['lib2']
      end

      def dependencies_for_macos
        ['lib3']
      end

      def dependencies_for_ubuntu
        ['lib4']
      end
      end
    end

    assert_equal(['lib2', 'lib3'], AnonymousClass.dependencies_for('MacOS', Depend::PackageProvider::Homebrew.new))
    assert_equal(['lib1', 'lib4'], AnonymousClass.dependencies_for('Ubuntu', Depend::PackageProvider::Apt.new))
    assert_equal(['lib1'], AnonymousClass.dependencies_for('Debian', Depend::PackageProvider::Apt.new))
  end

end
