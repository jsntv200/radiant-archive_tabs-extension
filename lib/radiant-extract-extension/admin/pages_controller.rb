module RadiantExtractExtension
  module Admin
    module PagesController
      def self.included(base)
        base.class_eval do
          before_filter :include_assets

          # TODO: duplicated in node_helper
          def extracted?(page)
            page.class == ExtractPage
          end

          alias_method_chain :load_models, :extract
          alias_method_chain :index, :extract
       end
      end

      def include_assets
        include_javascript 'admin/extract' if self.model.respond_to?(:parent) && extracted?(self.model.parent)
      end

      def load_models_with_extract
        if params[:page_id]
          self.model = Page.find(params[:page_id])

          if extracted?(self.model)
            self.class.paginate_models :per_page => Radiant.config['admin.extract.per_page']
          end

          load_models_without_extract
        end
      end

      def index_with_extract
        if extracted?(self.model)
          render :action => 'extract_index'
        else
          index_without_extract
        end
      end
    end
  end
end
