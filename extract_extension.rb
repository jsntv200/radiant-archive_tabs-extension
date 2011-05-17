require 'radiant-extract-extension/version'
require 'radiant-extract-extension/admin/node_helper'
require 'radiant-extract-extension/admin/pages_controller'

class ExtractExtension < Radiant::Extension
  version RadiantExtractExtension::VERSION
  description "Extract archive pages into their own paginated tab within the admin"
  url "http://github.com/jsntv200/radiant-extract-extension"

  def activate
    Admin::NodeHelper.send :include, RadiantExtractExtension::Admin::NodeHelper
    Admin::PagesController.send :include, RadiantExtractExtension::Admin::PagesController
    content_tab if Page.table_exists?
  end

  def content_tab
    if pages = Page.find(:all, :order => "slug DESC", :conditions => ["class_name = ?", "ArchivePage"])
      tab 'Content' do
        pages.each do |page|
          add_item page.title, "/admin/pages/#{page.id}/children"
        end
      end
    end
  end
end
