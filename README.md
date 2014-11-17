# Omniauth::Ldsconnect

This is a OmniAuth strategy for authenticating to LDS Connect.  To
use it, you'll need to sign up for an OAuth2 Application ID and Secret on the
[LDS Connect Applications Page](https://ldsconnect.org).

## Installation

Add this line to your application's Gemfile:

    gem 'omniauth-ldsconnect'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install omniauth-ldsconnect

## Usage

From inside your app do

```ruby
require 'omniauth'
require 'omniauth-ldsconnect'

provider :ldsconnect, App.settings.ldsconnect['key'], App.settings.ldsconnect['secret']
```

Note, getting the configuration may differ a bit.  If you have issues with SSL cert verification, the easy but incorrect thing to do is test with verification off.  Simply pass this to the omniauth provider:

```ruby
{:client_options => {:ssl => {verify: false}}}
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
