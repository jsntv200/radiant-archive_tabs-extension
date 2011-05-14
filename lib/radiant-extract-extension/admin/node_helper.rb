module RadiantExtractExtension
  module Admin
    module NodeHelper
      def self.included(base)
        base.class_eval do
          # TODO: duplicated in pages_controller
          def extracted?(page)
            page.class == ExtractPage
          end

          alias_method_chain :expanded, :extract
          alias_method_chain :expander, :extract
          alias_method_chain :children_class, :extract
          alias_method_chain :children_for, :extract
        end
      end

      # Never render the children
      def expanded_with_extract
        extracted?(@current_node) ? false : expanded_without_extract
      end

      # Don't display the expander arrow
      def expander_with_extract(level)
        extracted?(@current_node) ? '' : expander_without_extract(level)
      end

      # Force the no_children class so the SiteMapBehavior js will ignore an extract row
      def children_class_with_extract
        extracted?(@current_node) ? ' no_children' : children_class_without_extract
      end

      # Disable adding children on a extracted pages children index
      def children_for_with_extract(page)
        page.respond_to?(:parent) && extracted?(page.parent) ? [] : children_for_without_extract(page)
      end
    end
  end
end
