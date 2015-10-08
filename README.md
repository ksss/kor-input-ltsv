kor-input-ltsv
===

[![Build Status](https://travis-ci.org/ksss/kor-input-ltsv.svg?branch=master)](https://travis-ci.org/ksss/kor-input-ltsv)

LTSV(Labeled Tab-Separated Values) input plugin for [kor](https://github.com/ksss/kor)

## Usage

```
$ cat table.ltsv
foo:100    bar:200    baz:300
foo:400    bar:500    baz:600

$ kor ltsv markdown < table.ltsv
| foo | bar | baz |
| --- | --- | --- |
| 100 | 200 | 300 |
| 400 | 500 | 600 |
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'kor-input-ltsv'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install kor-input-ltsv

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ksss/kor-input-ltsv. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Refs

- https://github.com/ksss/kor
- http://ltsv.org/
