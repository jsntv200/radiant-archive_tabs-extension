module ArchiveTabs
  module Admin
    module PagesController
      def self.included(base)
        base.class_eval do
          # TODO: duplicated in application_helper
          def archive_page?(page)
            page.class == ArchivePage
          end

          helper_method :archive_page?, :index_page_for_model_with_archive
          alias_method_chain :load_models, :archive
          alias_method_chain :index, :archive
          alias_method_chain :index_page_for_model, :archive
       end
      end

      def load_models_with_archive
        if params[:page_id]
          acts_as_tree_options

          self.model = Page.find(params[:page_id])

          if archive_page?(self.model)
            self.class.paginate_models :per_page => Radiant.config['admin.pagination.per_page']
          end
        end

        load_models_without_archive
      end

      def index_with_archive
        if archive_page?(self.model)
          render :action => 'archive_index'
        else
          index_without_archive
        end
      end

      def index_page_for_model_with_archive
        if model && archive_page?(model.parent)
          acts_as_tree_options
          parts = {:action => "index", :page_id => model.parent_id}

          if i = model.self_and_siblings.index(model)
            p = (i / Radiant.config['admin.pagination.per_page'].to_i) + 1
            parts[:p] = p if p && p > 1
          end

          parts
        else
          index_page_for_model_without_archive
        end
      end

      # TODO: Probably a better way to do this but it works
      def acts_as_tree_options
        Page.acts_as_tree :order => 'virtual ASC, status_id ASC, published_at DESC'
      end
    end
  end
end
