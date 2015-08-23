require 'minitest_helper'
require 'rubygems_plugin'

describe "installer" do
  let(:spec) { stub(name: "awesome-gem") }

  describe "mac_os_x" do
    before do
      current_platform = stub(platform: "mac_os_x", platform_version: "10.10")
      OSPlatform.expects(:local).returns(current_platform)
    end

    it "should install dependency" do
      Depend.configure do |config|
        config.default_dependencies = ['dep1']
      end

      Depend::Installer.install(spec)
    end
  end

  describe "ubuntu" do
    before do
      current_platform = stub(platform: "Ubuntu", platform_version: "14.4")
      OSPlatform.expects(:local).returns(current_platform)
    end

    it "should install dependency" do
      Depend.configure do |config|
        config.default_dependencies = ['dep1']
      end

      Depend::Installer.install(spec)
    end
  end

end

