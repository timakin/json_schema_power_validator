module JsonSchemaSpec
  class Parser
    def initialize(file)
      @file = file
    end

    def parse
      JSON.parse(File.read(@file))
    end

    def parse_schema
      schema_data = JSON.parse(File.read(@file))
      schema      = JsonSchema.parse!(schema_data)
    end
  end
end