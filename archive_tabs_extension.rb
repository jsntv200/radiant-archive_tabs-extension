require 'radiant-archive_tabs-extension'

class ArchiveTabsExtension < Radiant::Extension
  version     RadiantArchiveTabsExtension::VERSION
  description RadiantArchiveTabsExtension::DESCRIPTION
  url         RadiantArchiveTabsExtension::URL

  def activate
    ApplicationHelper.send :include, ArchiveTabs::ApplicationHelper
    Admin::NodeHelper.send :include, ArchiveTabs::Admin::NodeHelper
    Admin::PagesController.send :include, ArchiveTabs::Admin::PagesController

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
