require 'radiant-archive_tabs-extension/version'
require 'radiant-archive_tabs-extension/admin/node_helper'
require 'radiant-archive_tabs-extension/admin/pages_controller'

class ArchiveTabsExtension < Radiant::Extension
  version RadiantArchiveTabsExtension::VERSION
  description "Display Archive pages in their own paginated tab"
  url "http://github.com/jsntv200/radiant-archive_tabs-extension"

  def activate
    Admin::NodeHelper.send :include, RadiantArchiveTabsExtension::Admin::NodeHelper
    Admin::PagesController.send :include, RadiantArchiveTabsExtension::Admin::PagesController

    admin.page.edit.add :main, 'redirect_cancel', :after => 'form_bottom'

    if Page.table_exists?
      tab 'Content' do
        ArchivePage.all(:order => 'slug ASC').each do |page|
          add_item page.title, "/admin/pages/#{page.id}/children"
        end
      end
    end
  end
end
