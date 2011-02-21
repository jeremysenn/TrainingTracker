require File.dirname(__FILE__) + '/../spec_helper'

describe WeightSet do
  it "should be valid" do
    WeightSet.new.should be_valid
  end
end
