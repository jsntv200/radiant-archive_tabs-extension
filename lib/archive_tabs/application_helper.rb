module ArchiveTabs
  module ApplicationHelper
    def self.included(base)
      base.class_eval do
        # TODO: duplicated in pages_controller
        def archive_page?(page)
          page.class == ArchivePage
        end

        alias_method_chain :current_url?, :archive
      end
    end

    def current_url_with_archive?(options)
      if respond_to?(:current_object) && current_object.respond_to?(:parent) && archive_page?(current_object.parent)
        # get the index url without pagination variables
        parent_url = index_page_for_model_with_archive
        parent_url.delete(:p)

        url = case options
        when Hash
          url_for options
        else
          options.to_s
        end

        clean(url_for parent_url) == clean(url)
      else
        current_url_without_archive?(options)
      end
    end
  end
end
