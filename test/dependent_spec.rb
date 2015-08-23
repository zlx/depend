require 'minitest_helper'

describe Depend::Dependent do
  before do
    Depend.configure do |config|
      config.default_dependencies = ['dep1']
      config.homebrew_dependencies = ['dep2']
    end
  end

  after do
    Depend.reset_configuration
  end


  it "should get dependents base on configuration" do
    assert_equal(['dep2'], Depend::Base.new('MacOS').dependencies_for(Depend::PackageProvider::Homebrew.new))
    assert_equal(['dep1'], Depend::Base.new('Ubuntu').dependencies_for(Depend::PackageProvider::Apt.new))
  end

end
