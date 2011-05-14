require File.dirname(__FILE__) + "/../../spec_helper"

describe Admin::NodeHelper do
  before :each do
    @extract = mock_model(ExtractPage)
    @extract.stub!(:extracted?).and_return(true)
  end

  it "should not expand the current node" do
    assigns[:current_node] = @extract
    helper.expanded.should be_false
  end

  it "should have a no_children class for the current node" do
    assigns[:current_node] = @extract
    helper.children_class.should == " no_children"
  end

  it "should not render an arrow for the current node" do
    assigns[:current_node] = @extract
    helper.expander(0).should == ""
  end

  it "should return no children if the parent is an ExtractPage" do
    @page = mock_model(Page)
    @page.stub!(:parent).and_return(@extract)
    assigns[:current_node] = @page
    helper.children_for(@page).should == []
  end
end
