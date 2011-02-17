require File.dirname(__FILE__) + '/../spec_helper'

describe WorkoutDetail do
  it "should be valid" do
    WorkoutDetail.new.should be_valid
  end
end
