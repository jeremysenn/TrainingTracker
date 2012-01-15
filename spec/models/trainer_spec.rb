require File.dirname(__FILE__) + '/../spec_helper'

describe Trainer do
  it "should be valid" do
    Trainer.new.should be_valid
  end
end
