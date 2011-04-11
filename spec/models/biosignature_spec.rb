require File.dirname(__FILE__) + '/../spec_helper'

describe Biosignature do
  it "should be valid" do
    Biosignature.new.should be_valid
  end
end
