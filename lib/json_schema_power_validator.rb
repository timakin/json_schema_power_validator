require "json_schema_power_validator/version"
require "json-schema"

module JsonSchema
  class PowerValidator
    def initialize(schema, suite)
      @schema = JSON.parse(File.read(schema))
      @suites = JSON.parse(File.read(suite))
      @raw_results ||= []
      @result_json ||= []
      @results = validate
    end

    def get_result
      JSON.pretty_generate(@results)
    end

    def ok?
      @raw_results.all? { |result| result == "Success" }
    end

    private

    def validate
      @suites["examples"].each do |suite|
        begin
          JSON::Validator.validate!(@schema, suite["values"])
          suite["expect"] == "valid" ? @raw_results.push("Success") : @raw_results.push("A validation passed, but it opposites the expectation.")
        rescue JSON::Schema::ValidationError
          suite["expect"] == "invalid" ? @raw_results.push("Success") : @raw_results.push($!.message)
        end
      end
      get_result_by_json
    end

    def get_result_by_json
      @raw_results.each_with_index { |result, index| 
        @result_json << {
          context:     @suites["examples"][index]["context"],
          description: @suites["examples"][index]["description"],
          result:      result
        }
      }
      {results: @result_json}
    end
  end
end
