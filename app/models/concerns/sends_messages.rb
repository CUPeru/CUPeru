module SendsMessages
  extend ActiveSupport::Concern

  class_methods do
    def messages
      all.map(&:messages)
    end
  end
end
