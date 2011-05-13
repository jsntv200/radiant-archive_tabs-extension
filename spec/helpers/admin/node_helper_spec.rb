require File.dirname(__FILE__) + "/../../spec_helper"

describe Admin::NodeHelper do
  before :each do
    assigns[:current_node] = mock_model(ExtractPage)
  end

  it "should not expand the current node" do
    helper.expanded.should be_false
  end

  it "should have a no_children class for the current node" do
    helper.children_class.should == " no_children"
  end

  it "should not render an arrow for the current node" do
    helper.expander(0).should == ""
  end
end
