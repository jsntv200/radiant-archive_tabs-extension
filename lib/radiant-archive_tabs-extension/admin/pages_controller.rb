module RadiantArchiveTabsExtension
  module Admin
    module PagesController
      def self.included(base)
        base.class_eval do
          # TODO: duplicated in node_helper
          def extracted?(page)
            page.class == ArchivePage
          end

          helper_method :extracted?, :index_page_for_model_with_extract
          alias_method_chain :load_models, :extract
          alias_method_chain :index, :extract
          alias_method_chain :index_page_for_model, :extract
       end
      end

      def load_models_with_extract
        if params[:page_id]
          self.model = Page.find(params[:page_id])

          if extracted?(self.model)
            acts_as_tree_options
            self.class.paginate_models :per_page => Radiant.config['admin.pagination.per_page']
          end
        end

        load_models_without_extract
      end

      def index_with_extract
        if extracted?(self.model)
          render :action => 'archive_index'
        else
          index_without_extract
        end
      end

      def index_page_for_model_with_extract
        if model && extracted?(model.parent)
          acts_as_tree_options
          parts = {:action => "index", :page_id => model.parent_id}

          if i = model.self_and_siblings.index(model)
            p = (i / Radiant.config['admin.pagination.per_page'].to_i) + 1
            parts[:p] = p if p && p > 1
          end

          parts
        else
          index_page_for_model_without_extract
        end
      end

      # TODO: Probably a better way to do this but it works
      def acts_as_tree_options
        Page.acts_as_tree :order => 'virtual ASC, published_at DESC'
      end
    end
  end
end
