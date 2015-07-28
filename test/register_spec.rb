require 'minitest_helper'

describe Depend::Registerable do
  class AnonymousClass
    extend Depend::Registerable
  end

  after do
    AnonymousClass.platforms = nil
  end

  describe "register" do

    it "missing version" do
      AnonymousClass.register 'MockPackageProvider', 'MacOS'
      assert_equal({ 'MacOS' => [[nil, 'MockPackageProvider']] }, AnonymousClass.platforms)
    end

    it "with version" do
      AnonymousClass.register 'MockPackageProvider', 'MacOS', '1.3, 3.4'
      assert_equal({ 'MacOS' => [['1.3, 3.4', 'MockPackageProvider']] }, AnonymousClass.platforms)
    end

    it "register more than one" do
      AnonymousClass.register 'MockPackageProvider', 'MacOS', '1.3, 3.4'
      AnonymousClass.register 'AnotherMockPackageProvider', 'MacOS', '1.2'
      assert_equal({
        'MacOS' => [['1.3, 3.4', 'MockPackageProvider'], ['1.2', 'AnotherMockPackageProvider']]
      }, AnonymousClass.platforms)
    end

    it "should raise PlatformNotSupportedError" do
      assert_raises Depend::PlatformNotSupportedError do
        AnonymousClass.register 'MockPackageProvider', 'NotPlatform', '1.3, 3.4'
      end
    end
  end

  describe "package_providers_for" do

    it "missing version" do
      AnonymousClass.register 'MockPackageProvider', 'MacOS'
      assert_equal(['MockPackageProvider'], AnonymousClass.package_providers_for("MacOS", "10.10.4"))
    end

    it "version not exist" do
      AnonymousClass.register 'MockPackageProvider', 'MacOS', '1.3, 3.4'
      assert_equal([], AnonymousClass.package_providers_for("MacOS", "1.2.1"))
    end

    it "version included" do
      AnonymousClass.register 'MockPackageProvider', 'MacOS', '1.3, 3.4'
      assert_equal(['MockPackageProvider'], AnonymousClass.package_providers_for("MacOS", "1.3.1"))
    end

    it "version included more than one" do
      AnonymousClass.register 'MockPackageProvider', 'MacOS', '1.3, 3.4'
      AnonymousClass.register 'AnotherMockPackageProvider', 'MacOS', '1.2'
      assert_equal(['MockPackageProvider', 'AnotherMockPackageProvider'], AnonymousClass.package_providers_for("MacOS", "1.3.1"))
    end
  end

end
