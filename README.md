# JsonSchemaSpec

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/json_schema_spec`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'json_schema_spec'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install json_schema_spec

## Usage

```json
{
	"id": "https://github.com/timakin/json_schema_spec/schema/sample.json",
	"$schema": "http://json-schema.org/draft-04/schema#",
	"description": "Test schema for example",
	"definitions": {
		"positiveInt": {
			"type": "integer",
			"minimum": 0
		},
		"name": {
			"type": "string",
			"minimumLength": 4,
			"maximumLength": 12
		}
	},
	"type": "object",
	"properties": {
		"id": {
			"$ref": "#/definitions/positiveInt"
		},
		"username": {
			"$ref": "#/definitions/name"
		}
	}
}
```

```json
{
	"id": "https://github.com/timakin/json_schema_spec/schema/suite/sample.json",
	"$schema": {
		"$ref": "https://github.com/timakin/json_schema_spec/schema/sample.json"
	},
	"description": "Schema Spec for example.json",
	"examples": [
		{
			"context": "Success",
			"description": "Success Case",
			"expect": "valid",
			"values": {
				"id": 1,
				"username": "timakin"
			}
		},
		{
			"context": "Invalid",
			"description": "Invalid id",
			"expect": "invalid",
			"values": {
				"id": -1,
				"username": "timakin"
			}
		},
		{
			"context": "Invalid",
			"description": "Invalid username",
			"expect": "invalid",
			"values": {
				"id": 1,
				"username": "tim"
			}
		},
		{
			"context": "Fail",
			"description": "fail",
			"expect": "valid",
			"values": {
				"id": -100,
				"username": "tim"
			}
		}
	]
}
```

```ruby
require 'json'
require 'json_schema_spec'

schema = JSON.parse(File.read("schema/sample.json"))
suite = JSON.parse(File.read("schema/suite/sample.json"))

schemaSpec = JsonSchemaSpec.new(schema, suite)
result = schemaSpec.get_result

p schemaSpec.ok?
# false
p result
#{
#	"results": [
#		{
#			"context": "Success",
#			"description": "Success Case",
#			"result": "success"
#		},
#		{
#			"context": "Invalid",
#			"description": "Invalid id",
#			"result": "success"
#		}
#			"context": "Invalid",
#			"description": "Invalid username",
#			"result": "success"
#		},
#		{
#			"context": "Fail",
#			"description": "fail"
#			"result": "fail",
#			"reason": "Invalid parameter: id should satisfy the condition minimumLength"
#		}
#	]
#}
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/json_schema_spec/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
