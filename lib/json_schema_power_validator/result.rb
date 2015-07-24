module JsonSchema
  class Result
    attr_accessor :contexts, :errors

    def initialize
      @contexts = []
      @errors   = []
    end
  end
end