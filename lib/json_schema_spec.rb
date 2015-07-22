require "json_schema_spec/version"
require "json_schema_spec/parser"
require "json_schema_spec/spec"

module JsonSchemaSpec

  # PPP
  # 1. parse json data
  # 2. compare suite/$schema and schema
  # 3. get a detail result with each test cases
    # 3.1. if all of them are clear, return true
    # 3.2. if some of them failed, return detail error description
  # 4. ok? will just return true/false depending on results


  # this file define the log interface of this module
  # definition of substantial content of methods are written in each classes.
  def self.parse!(file)
    Parser.new(file).parse
  end

  def self.parse_schema!(file)
    Parser.new(file).parse_schema
  end

  def self.result!(schema, suite)
    Spec.new(schema, suite).result
  end

  def self.ok?(schema, suite)
    Spec.new(schema, suite).is_valid
  end
end
