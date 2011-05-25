module RadiantArchiveTabsExtension
  module ApplicationHelper
    def self.included(base)
      base.class_eval do
        def extracted?(page)
          page.class == ArchivePage
        end

        alias_method_chain :current_url?, :archive
      end
    end

    def current_url_with_archive?(options)
      if extracted?(current_object.parent)
        parent_url = url_for index_page_for_model_with_extract

        url = case options
        when Hash
          url_for options
        else
          options.to_s
        end

        parent_url == clean(url)
      else
        current_url_without_archive?(options)
      end
    end
  end
end

