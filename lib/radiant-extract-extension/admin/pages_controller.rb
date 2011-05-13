module RadiantExtractExtension
  module Admin
    module PagesController
      def self.included(base)
        base.class_eval do
          alias_method_chain :load_models, :extract
          alias_method_chain :index, :extract
        end
      end

      def load_models_with_extract
        if params[:page_id]
          self.model = Page.find(params[:page_id])

          if self.model.extracted?
            class << self
              paginate_models :per_page => Radiant.config['admin.extract.per_page']
            end
          end

          load_models_without_extract
        end
      end

      def index_with_extract
        if self.model.extracted?
          render :action => 'extract_index'
        else
          index_without_extract
        end
      end
    end
  end
end

