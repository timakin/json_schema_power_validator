require 'test/unit'
require 'json_schema_power_validator'

class TestJsonSchemaPowerValidator < Test::Unit::TestCase
  def setup
    test_files_dir = File.expand_path(File.dirname(__FILE__))
    @schema_dir = File.join(test_files_dir, 'files', 'schema')
    @suite_dir = File.join(test_files_dir, 'files', 'suite')
  end

  def test_all
    schema_path = File.join(@schema_dir, 'schema.json')
    suite_path = File.join(@suite_dir, 'suite.json')
    expected_result = <<EOS
{
  \"results\": [
    {
      \"context\": \"Success\",
      \"description\": \"Valid JSON\",
      \"result\": \"Success\"
    },
    {
      \"context\": \"Success\",
      \"description\": \"Invalid JSON\",
      \"result\": \"The property '#/age' of type String did not match the following type: integer\"
    },
    {
      \"context\": \"Failure\",
      \"description\": \"Invalid JSON\",
      \"result\": \"Success\"
    },
    {
      \"context\": \"Failure\",
      \"description\": \"Valid JSON\",
      \"result\": \"A validation passed, but it opposites the expectation.\"
    }
  ]
}
EOS
    pv = JsonSchema::PowerValidator.new(schema_path, suite_path)
    assert_equal pv.get_result, expected_result.rstrip
  end
end
