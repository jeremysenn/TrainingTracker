require File.dirname(__FILE__) + '/../spec_helper'

describe Plan do
  it "should be valid" do
    Plan.new.should be_valid
  end
end
