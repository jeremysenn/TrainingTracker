require File.dirname(__FILE__) + '/../spec_helper'

describe Subscription do
  it "should be valid" do
    Subscription.new.should be_valid
  end
end
