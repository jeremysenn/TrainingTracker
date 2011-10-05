require File.dirname(__FILE__) + '/../spec_helper'

describe Bodycomp do
  it "should be valid" do
    Bodycomp.new.should be_valid
  end
end
