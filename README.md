# Bc::RequireGoogleAuth

This gem is a Rack middleware that requires users to authenticate
through google in order to access the protected portions of the
application.

Currently, access is controlled with a hardcoded list of google account
email addresses in the middlware initializer.

## Installation

Add this line to your application's Gemfile:

    gem 'bc-require-google-auth'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bc-require-google-auth

## Usage

```ruby
require 'bc/require_google_auth'

use Bc::RequireGoogleAuth, allowed_paths: [ "/" ], authorized_emails: [
  "stephen@brandedcrate.com",
  "otherallowedemail@gmail.com"
]
```

## Contributing

1. Fork it ( http://github.com/brandedcrate/bc-require-google-auth/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
