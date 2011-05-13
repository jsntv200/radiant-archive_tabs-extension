require 'radiant-extract-extension/version'
require 'radiant-extract-extension/admin/node_helper'

class ExtractExtension < Radiant::Extension
  version RadiantExtractExtension::VERSION
  description "Provides page types that will extract the pages children into a paginated tab"
  url "http://github.com/jsntv200/radiant-extract-extension"

  def activate
    Admin::NodeHelper.send :include, RadiantExtractExtension::Admin::NodeHelper

    Admin::PagesController.class_eval do
      paginate_models :per_page => 1

      def index_with_extract
        if request.path.match('/admin/pages/\d+/children/?(.html)?(\?p(age)?=\d+)?$').nil? == false
          self.model = Page.find(params[:page_id])
          render :action => 'extract_index'
        else
          params[:pp] = 'all'
          index_without_extract
        end
      end
      alias_method_chain :index, :extract
    end

    set_tab if Page.table_exists?
  end

  def set_tab
    pages = Page.find(:all, :order => "slug DESC", :conditions => ["class_name = ? OR class_name = ?", "ExtractPage", "ExtractArchivePage"])

    tab 'Content' do
      pages.each do |page|
        add_item page.title, "/admin/pages/#{page.id}/children"
      end
    end if pages
  end
end
