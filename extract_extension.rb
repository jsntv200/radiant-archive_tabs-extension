require 'radiant-extract-extension/version'
require 'radiant-extract-extension/admin/node_helper'
require 'radiant-extract-extension/admin/pages_controller'

class ExtractExtension < Radiant::Extension
  version RadiantExtractExtension::VERSION
  description "Provides page types that will extract the pages children into a paginated tab"
  url "http://github.com/jsntv200/radiant-extract-extension"

  def activate
    Admin::NodeHelper.send :include, RadiantExtractExtension::Admin::NodeHelper
    Admin::PagesController.send :include, RadiantExtractExtension::Admin::PagesController
    admin.page.edit.add :form, 'extract_form'
    content_tab if Page.table_exists?
  end

  def content_tab
    class_names = ["ExtractPage"]
    pages = Page.find(:all, :order => "slug DESC", :conditions => ["class_name IN (?)", class_names])

    tab 'Content' do
      pages.each do |page|
        add_item page.title, "/admin/pages/#{page.id}/children"
      end
    end if pages
  end
end
