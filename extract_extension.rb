require 'radiant-extract-extension/version'

class ExtractExtension < Radiant::Extension
  version RadiantExtractExtension::VERSION
  description "Provides page types that will extract a pages children into its own paginated tab"
  url "http://github.com/jsntv200/radiant-extract-extension"


  def activate
    ExtractPage
    ExtractArchivePage

    Page.send :include, Extract::PageExt

    # Patches to correctly redirect after a "Save", "Save And Continue" or "Cancel" action
    Admin::ResourceController.send :include, Extract::ResourceControllerExt

    # Index page UI elements
    admin.class_eval { attr_accessor :extracts }
    admin.extracts = load_default_settings_regions

    # Display the Tabs
    set_tab
  end

  def set_tab
    pages = Page.find_all_by_class_name(["ExtractPage", "ExtractArchivePage"], :order => "slug DESC")    

    tab 'Content' do
      pages.each do |page|
        add_item page.title, "/admin/extracts/#{page.id}/children", :before => "Assets"
      end
    end if pages
  end

  def load_default_settings_regions
    returning OpenStruct.new do |settings|
      settings.index = Radiant::AdminUI::RegionSet.new do |index|
        index.top.concat %w{}
        index.sitemap_head.concat %w{title_column_header status_column_header published_on_column_header modify_column_header}
        index.node.concat %w{title_column status_column published_on_column modify_column}
        index.bottom.concat %w{}
      end
    end
  end
end
