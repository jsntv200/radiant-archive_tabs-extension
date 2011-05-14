require File.dirname(__FILE__) + '/../../spec_helper'

describe Admin::PagesController do
  dataset :users, :extract_pages

  before :each do
    login_as :existing
  end

  describe "viewing the admin index" do
    integrate_views

    before :each do
      get :index
    end

    it "should have a secondary navigation" do
      response.should be_success
      response.should have_tag('ul#secondary_navigation')
    end

    it "should have a Pages link" do
      response.should be_success
      response.should have_tag('a', :text => 'Pages')
    end

    it "should have a News link" do
      response.should be_success
      response.should have_tag('a', :text => 'News')
    end
  end

  describe "viewing the admin extract index" do
    before :each do
      Radiant::Config['admin.extract.per_page'] = 23
      get :index, :page_id => ExtractPage.first.id
    end

    it "should be an ExtractPage" do
      response.should be_success
      assigns(:page).should be_kind_of(ExtractPage)
    end

    it "should render the index_extract template" do
      response.should be_success
      response.should render_template('extract_index')
    end

    it "should be paginated" do
      response.should be_success
      controller.paginated?.should be_true 
    end

    it "should override defaults with extract pagination settings from config" do
      response.should be_success
      controller.pagination_parameters.should == {:page => 1, :per_page => 23}
    end
  end
end
