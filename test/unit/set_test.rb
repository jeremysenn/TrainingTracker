require File.dirname(__FILE__) + '/../spec_helper'

describe Set do
  it "should be valid" do
    Set.new.should be_valid
  end
end
