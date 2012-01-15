require File.dirname(__FILE__) + '/../spec_helper'

describe Gym do
  it "should be valid" do
    Gym.new.should be_valid
  end
end
