require "json_schema_power_validator/version"
require "json_schema_power_validator/result"

module JsonSchema

  # PPP
  # 1. parse json data
  # 2. compare suite/$schema and schema
  # 3. get a detail result with each test cases
    # 3.1. if all of them are clear, return true
    # 3.2. if some of them failed, return detail error description
  # 4. ok? will just return true/false depending on results

  class PowerValidator
    def initialize(schema_file)
      @schema = JsonSchema.parse!(JSON.parse(File.read(schema_file)))
    end

    def set_suite(suite_file)
      @suite = JSON.parse(File.read(suite_file))
    end

    def get_result
      @results = Result.new
      @suites["examples"].each do |suite|
        validation_response = @schema.validate!(suite["values"])
        @results.contexts.push(validation_response)
        if validation_response == "error" # TODO
          if suite["expect"] == "invalid"
            @results.contexts.push(validation_response)
          else
            @results.errors.push(validation_response)
          end
        end
      end

      self.trim_result_json(@results)
      @results.errors.empty? ? "Success" : compared_results.errors # TODO: return error json
    end

    def ok?
      @results.errors.empty? ? true : false
      # return true/false depending on the test result
    end

    private

    def trim_result_json(results)
      # trim result data to pretty json
    end
  end
end
