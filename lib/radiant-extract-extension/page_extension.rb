module RadiantExtractExtension
  module PageExtension
    def self.included(base)
      base.class_eval do
        def extracted?
          self.class == ExtractPage
        end
      end
    end
  end
end

