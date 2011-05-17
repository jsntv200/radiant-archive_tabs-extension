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
          alias_method_chain :index_page_for_model, :extract
       end
      end

      def include_assets
        include_javascript 'admin/extract' if self.model.respond_to?(:parent) && extracted?(self.model.parent)
      end

      def load_models_with_extract
        if params[:page_id]
          self.model = Page.find(params[:page_id])

          if extracted?(self.model)
            self.class.paginate_models :per_page => Radiant.config['admin.pagination.per_page']
          end
        end

        load_models_without_extract
      end

      def index_with_extract
        if extracted?(self.model)
          render :action => 'extract_index'
        else
          index_without_extract
        end
      end

      def index_page_for_model_with_extract
        if model && extracted?(model.parent)
          parts = {:action => "index", :page_id => model.parent_id}

          if i = model.self_and_siblings.index(model)
            p = (i / pagination_parameters[:per_page].to_i) + 1
            parts[:p] = p if p && p > 1
          end

          parts
        else
          index_page_for_model_without_extract
        end
      end
    end
  end
end
