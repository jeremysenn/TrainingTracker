require File.dirname(__FILE__) + '/../spec_helper'

describe WorkoutSession do
  it "should be valid" do
    WorkoutSession.new.should be_valid
  end
end
