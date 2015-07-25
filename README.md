# JsonSchema::PowerValidator

Test JSON Schema itself with contexts.
After preparation of schema and test suite, you can test schema response.
It'll display each results with json format.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'json_schema_power_validator'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install json_schema_power_validator

## Usage

Prepare json schema you'd like to test and test suite.
A test suite must be written on the fixed format.
The suite must include parameters:

- examples 			- Array of test cases, and each of them should include following parameters
	- context 		- Title of each test
	- description - Detail of the test
	- expect			- Expectation of a result of test (it must be "valid"/"invalid")
	- values 			- Parameters that'll be used as test values.

The below json is the example of test suite on the above format.

```json
{
	"examples": [
		{
			"context": "Success",
			"description": "Success Case",
			"expect": "valid",
			"values": {
				  "id": 1234,
				  "name": "timakin",
				  ...
			}
		},
		{ ... },
		{ ... }
	]
}
```

With the suite, you can get a detail error message, and check whether the results are all clear or not.

```ruby
require 'json_schema_power_validator'

validated_schema = JsonSchema::PowerValidator.new("schema/sample.json", "schema/suite/sample.json")
validated_schema.get_result
#{
#	"results": [
#		{
#			"context": "Success",
#			"description": "Success Case",
#			"result": "success"
#		},
#		{ ... },
#   {
#			"context": "Fail",
#			"description": "Failed Case",
#			"result": "The property '#/id' did not have a minimum value of 0, inclusively"
#		}
#	]
#}

validated_schema.ok?
# false
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Test

To run test:

```
$ cd /path/to/repository
$ bundle install --path vendor/bundle
$ bundle exec ruby spec/json_schema_power_validator_spec.rb
```

## Contributing

1. Fork it ( https://github.com/timakin/json_schema_power_validator/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
