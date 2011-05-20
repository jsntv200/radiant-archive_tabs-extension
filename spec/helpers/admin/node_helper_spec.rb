require File.dirname(__FILE__) + "/../../spec_helper"

describe Admin::NodeHelper do
  before :each do
    @archive = mock_model(ArchivePage)
    @archive.stub!(:extracted?).and_return(true)
  end

  it "should not expand the current node" do
    assigns[:current_node] = @archive
    helper.expanded.should be_false
  end

  it "should have a no_children class for the current node" do
    assigns[:current_node] = @archive
    helper.children_class.should == " no_children"
  end

  it "should not render an arrow for the current node" do
    assigns[:current_node] = @archive
    helper.expander(0).should == ""
  end

  it "should return no children if the parent is an ArchivePage" do
    @page = mock_model(Page)
    @page.stub!(:extracted?).and_return(false)
    @page.stub!(:parent).and_return(@archive)
    assigns[:current_node] = @page
    helper.children_for(@page).should == []
  end
end
