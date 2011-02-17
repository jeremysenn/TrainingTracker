require File.dirname(__FILE__) + '/../spec_helper'

describe ExerciseSession do
  it "should be valid" do
    ExerciseSession.new.should be_valid
  end
end
