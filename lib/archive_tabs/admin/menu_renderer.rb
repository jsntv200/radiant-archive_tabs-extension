module ArchiveTabs
  module Admin
    module MenuRenderer
      # Shouldn't need to alias_method_chain the MenuRenderer. Something to fix in the future.
      def self.included(base)
        base.class_eval do
          alias_method_chain :add_child_disabled?, :archive
        end
      end

      def add_child_disabled_with_archive?
        if respond_to?(:parent) && parent.class == ArchivePage
          true
        else
          add_child_disabled_without_archive?
        end
      end
    end
  end
end
