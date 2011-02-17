require File.dirname(__FILE__) + '/../spec_helper'

describe Workout do
  it "should be valid" do
    Workout.new.should be_valid
  end
end
