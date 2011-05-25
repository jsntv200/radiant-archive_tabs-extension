module RadiantArchiveTabsExtension
  module Admin
    module NodeHelper
      def self.included(base)
        base.class_eval do
          alias_method_chain :expanded, :archive
          alias_method_chain :expander, :archive
          alias_method_chain :children_class, :archive
          alias_method_chain :children_for, :archive
        end
      end

      # Never render the children on admin/pages
      def expanded_with_archive
        archive_page?(@current_node) ? false : expanded_without_archive
      end

      # Don't display the expander arrow on admin/pages
      def expander_with_archive(level)
        archive_page?(@current_node) ? '' : expander_without_archive(level)
      end

      # Force the no_children class to diable the SiteMapBehavior js on admin/pages
      def children_class_with_archive
        archive_page?(@current_node) ? ' no_children' : children_class_without_archive
      end

      # Disable adding children on the index page, admin/pages/:page_id/children
      def children_for_with_archive(page)
        page.respond_to?(:parent) && archive_page?(page.parent) ? [] : children_for_without_archive(page)
      end
    end
  end
end
