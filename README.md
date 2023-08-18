# TimestampUuid

A naive UUID V4 compliant timestamp uuid with millisecond precision, for which
also the string representation is correctly sorted by encoded timestamp.
Please don't confuse it with time uuids used by e.g. cassandra where the string
representation is not sortable by timestamp. The timestamp occupies 56 bit,
such that it roughly works for the next 2 million years (from year 2022 on)
with millisecond precision.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add timestamp_uuid

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install timestamp_uuid

## Usage

To generate timestamp uuids:

```ruby
TimestampUuid.generate
# => "00018a07-fb46-4bb0-0001-45c4003779fd"

TimestampUuid.generate(Time.parse("2023-08-12 12:00:00 CEST"))
# => "000189e9-303d-4000-0003-625c21b0936b"
```

To parse and instantiate timestamp uuids:

```ruby
TimestampUuid.new("000189e9-303d-4000-0003-625c21b0936b")
=> #<TimestampUuid:0x00007f06d2f5a020 @sequence_number=3, @timestamp=2023-08-12 12:00:00 +0200, @uuid="000189e9-303d-4000-0003-625c21b0936b", @version=4>
```

That's it!

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`rake spec` to run the tests. You can also run `bin/console` for an interactive
prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release`, which will create a git tag for the version, push
git commits and the created tag, and push the `.gem` file to
[rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/mrkamel/timestamp_uuid. This project is intended to be a
safe, welcoming space for collaboration, and contributors are expected to
adhere to the
[code of conduct](https://github.com/mrkamel/timestamp_uuid/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the
[MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the TimestampUuid project's codebases, issue trackers,
chat rooms and mailing lists is expected to follow the
[code of conduct](https://github.com/mrkamel/timestamp_uuid/blob/main/CODE_OF_CONDUCT.md).
