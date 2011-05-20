require File.dirname(__FILE__) + '/../../spec_helper'

describe Admin::PagesController do
  dataset :users, :archive_pages

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
      get :index, :page_id => ArchivePage.first.id
    end

    it "should be an ArchivePage" do
      response.should be_success
      assigns(:page).should be_kind_of(ArchivePage)
    end

    it "should render the archive_index template" do
      response.should be_success
      response.should render_template('archive_index')
    end

    it "should be paginated" do
      response.should be_success
      controller.paginated?.should be_true
    end
  end

  describe "#new" do
    it "should redirect to the archive parent" do
      get :new, :page_id => page_id(:news)
      response.should be_success
      controller.index_page_for_model_with_extract.should == {:action => 'index', :page_id => page_id(:news)}
    end
  end

  describe "#edit" do
    it "should redirect to paginated archive parent" do
      Admin::PagesController.send :paginate_models, {:per_page => 2}
      get :edit, :id => pages(:news).children.first.id
      response.should be_success
      controller.index_page_for_model_with_extract.should == {:action => 'index', :page_id => page_id(:news), :p => 2}
    end
  end
end
