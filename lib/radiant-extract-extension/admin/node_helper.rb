module RadiantExtractExtension
  module Admin
    module NodeHelper
      def self.included(base)
        base.class_eval do
          alias_method_chain :expanded, :extract
          alias_method_chain :expander, :extract
          alias_method_chain :children_class, :extract
          alias_method_chain :children_for, :extract
        end
      end

      # Never render the children
      def expanded_with_extract
        @current_node.extracted? ? false : expanded_without_extract
      end

      # Don't display the expander arrow
      def expander_with_extract(level)
        @current_node.extracted? ? '' : expander_without_extract(level)
      end

      # Force the no_children class so the SiteMapBehavior js will ignore an extract row
      def children_class_with_extract
        @current_node.extracted? ? ' no_children' : children_class_without_extract
      end

      # Disable adding children on a extracted pages children index
      def children_for_with_extract(page)
        page.parent.respond_to?(:extracted?) && page.parent.extracted? ? [] : children_for_without_extract(page)
      end
    end
  end
end
