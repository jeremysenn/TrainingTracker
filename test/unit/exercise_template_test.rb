require File.dirname(__FILE__) + '/../spec_helper'

describe ExerciseTemplate do
  it "should be valid" do
    ExerciseTemplate.new.should be_valid
  end
end
