# Status

[![Build Status](https://travis-ci.org/nylar/status.svg?branch=master)](https://travis-ci.org/nylar/status)

Enumeration of HTTP status codes.

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  status:
    github: nylar/status
```

## Usage

```crystal
require "status"

Status.new(200) # => Status::Code::Ok
```

See specs and generated docs for more examples.

## Contributing

1. Fork it ( https://github.com/nylar/status/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [Scott Raine](https://github.com/nylar) - creator, maintainer
