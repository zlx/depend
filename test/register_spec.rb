require 'minitest_helper'

describe Depend::Register do
  let(:register_instance) { Depend::Register.new }

  describe "register" do

    it "missing version" do
      register_instance.send(:register, 'MockPackageProvider', 'mac_os_x')
      assert_equal({ 'mac_os_x' => [[nil, 'MockPackageProvider']] }, register_instance.platforms)
    end

    it "with version" do
      register_instance.send(:register, 'MockPackageProvider', 'mac_os_x', '1.3, 3.4')
      assert_equal({ 'mac_os_x' => [['1.3, 3.4', 'MockPackageProvider']] }, register_instance.platforms)
    end

    it "register more than one" do
      register_instance.send(:register, 'MockPackageProvider', 'mac_os_x', '1.3, 3.4')
      register_instance.send(:register, 'AnotherMockPackageProvider', 'mac_os_x', '1.2')
      assert_equal({
        'mac_os_x' => [['1.3, 3.4', 'MockPackageProvider'], ['1.2', 'AnotherMockPackageProvider']]
      }, register_instance.platforms)
    end

    it "should raise PlatformNotSupportedError" do
      assert_raises Depend::PlatformNotSupportedError do
        register_instance.send(:register, 'MockPackageProvider', 'NotPlatform', '1.3, 3.4')
      end
    end
  end

  describe "package_providers_for" do

    it "missing version" do
      register_instance.send(:register, 'MockPackageProvider', 'mac_os_x')
      assert_equal(['MockPackageProvider'], register_instance.package_providers_for("mac_os_x", "10.10.4"))
    end

    it "version not exist" do
      register_instance.send(:register, 'MockPackageProvider', 'mac_os_x', '1.3, 3.4')
      assert_equal([], register_instance.package_providers_for("mac_os_x", "1.2.1"))
    end

    it "version included" do
      register_instance.send(:register, 'MockPackageProvider', 'mac_os_x', '1.3, 3.4')
      assert_equal(['MockPackageProvider'], register_instance.package_providers_for("mac_os_x", "1.3.1"))
    end

    it "version included more than one" do
      register_instance.send(:register, 'MockPackageProvider', 'mac_os_x', '1.3, 3.4')
      register_instance.send(:register, 'AnotherMockPackageProvider', 'mac_os_x', '1.2')
      assert_equal(['MockPackageProvider', 'AnotherMockPackageProvider'], register_instance.package_providers_for("mac_os_x", "1.3.1"))
    end
  end

end
