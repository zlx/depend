require 'minitest_helper'

describe "configuration" do
  before do
    Depend.configure do |config|
      config.default_dependencies = ['dep1', 'dep2']
      config.homebrew_dependencies = ['dep3', 'dep4']
      config.apt_dependencies = ['dep5', 'dep6']
    end
  end

  after do
    Depend.reset_configuration
  end

  it "should set configuration" do
    assert_equal(['dep1', 'dep2'], Depend.configuration.default_dependencies)
    assert_equal(['dep3', 'dep4'], Depend.configuration.homebrew_dependencies)
    assert_equal(['dep5', 'dep6'], Depend.configuration.apt_dependencies)
  end

  it "should override configuration" do
    Depend.configure do |config|
      config.default_dependencies = ['dep3']
      config.homebrew_dependencies = ['dep1']
      config.apt_dependencies = ['dep2']
    end
    
    assert_equal(['dep3'], Depend.configuration.default_dependencies)
    assert_equal(['dep1'], Depend.configuration.homebrew_dependencies)
    assert_equal(['dep2'], Depend.configuration.apt_dependencies)
  end
end
