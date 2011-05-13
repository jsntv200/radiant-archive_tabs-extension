module RadiantExtractExtension
  module Admin
    module NodeHelper
      def self.included(base)
        base.class_eval do
          alias_method_chain :children_class, :extract
          alias_method_chain :expander, :extract
          alias_method_chain :expanded, :extract
        end
      end

      # Force the no_children class so the SiteMapBehavior js will ignore an extract row
      def children_class_with_extract
        @current_node.extracted? ? " no_children" : children_class_without_extract
      end

      # Don't display the expander arrow
      def expander_with_extract(level)
        @current_node.extracted? ? "" : expander_without_extract(level)
      end

      # Never render the children
      def expanded_with_extract
        @current_node.extracted? ? false : expanded_without_extract
      end
    end
  end
end
