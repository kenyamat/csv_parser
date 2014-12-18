# csv_parser

Parse CSV with multiline fields and escaped double quotes.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'csv_parser'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install csv_parser

## Usage

### csv with multiline fields
|aa<br>bb|cc|dd
|-|-|-|
|ee|&nbsp;|&nbsp;|

```
require 'csv_parser'

parser = CsvParser::Parser.new
csv = "\"aa\nbb\",cc,dd\nee"
result = parser.parse(csv)
p result.length #=> 2
p result[0] #=> ["aa\nbb", "cc", "dd"]
p result[1] #=> ["ee"]
```

### csv with escaped double quotes
|aa|bb|cc|dd
|-|-|-|-|
|ff|gg|hh|&nbsp;|
|ii,jj|kk|&nbsp;|&nbsp;|

```
require 'csv_parser'

parser = CsvParser::Parser.new
csv = "aa,bb,cc,dd\nff,gg,hh\n\"ii,jj\",kk"
result = parser.parse(csv)
p result.length #=> 3
p result[0] #=> ["aa", "bb", "cc", "dd"]
p result[1] #=> ["ff", "gg", "hh"]
p result[2] #=> ["ii,jj", "kk"]
```
