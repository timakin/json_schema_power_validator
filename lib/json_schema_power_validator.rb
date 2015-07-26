require "json_schema_power_validator/version"
require "json_schema_power_validator/errors/parse_suite_error"
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
      @raw_results.all? { |result| result == success }
    end

    private

    def validate
      verify_suite_parameters

      @suites["examples"].each do |suite|
        begin
          JSON::Validator.validate!(@schema, suite["values"])
          verify_result_and_expectation(suite, valid, valid_but_unexpected_error)
        rescue JSON::Schema::ValidationError
          verify_result_and_expectation(suite, invalid, $!.message)
        end
      end

      get_result_by_json
    end

    def verify_suite_parameters
      raise ParseSuiteError.new(example_is_undefined_error) unless @suites["examples"]
      
      @suites["examples"].each do |suite|
        suite_params.each do |param|          
          raise ParseSuiteError.new(test_suite_is_undefined_error(param)) unless suite[param]
        end
      end
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

    def verify_result_and_expectation(suite, expectation, error_message)
      suite["expect"] == expectation ? @raw_results.push(success) : @raw_results.push(error_message)
    end

    def test_suite_is_undefined_error(param)
      "#{param} for a test suite is undefined."
    end

    # Constants

    def success
      "Success"
    end

    def suite_params
      ["context", "description", "expect", "values"]
    end

    def valid
      "valid"
    end

    def invalid
      "invalid"
    end
    
    def valid_but_unexpected_error
      "A validation passed, but it opposites the expectation."
    end

    def example_is_undefined_error
      "examples for a test suite is undefined, or format is invalid."
    end
  end
end
