module RadiantExtractExtension
  module Admin
    module NodeHelper
      def self.included(base)
        base.class_eval do
          alias_method_chain :expander, :extract
          alias_method_chain :expanded, :extract
          alias_method_chain :children_class, :extract
          alias_method_chain :child_link_for, :extract
          alias_method_chain :child_menu_for, :extract
        end
      end

      # Never render the children
      def expanded_with_extract
        @current_node.extracted? ? false : expanded_without_extract
      end

      # Don't display the expander arrow
      def expander_with_extract(level)
        @current_node.extracted? ? nil : expander_without_extract(level)
      end

      # Force the no_children class so the SiteMapBehavior js will ignore an extract row
      def children_class_with_extract
        @current_node.extracted? ? ' no_children' : children_class_without_extract
      end

      # Remove ability to add children
      def child_link_for_with_extract(page)
        @current_node.parent.extracted? ? nil : child_link_for_without_extract(page)
      end

      # Remove ability to add children menu
      def child_menu_for_with_extract(page)
        @current_node.parent.extracted? ? nil : child_menu_for_without_extract(page)
      end
    end
  end
end
