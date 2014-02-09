# ![](https://raw.github.com/aptible/straptible/master/lib/straptible/rails/templates/public.api/icon-60px.png) Aptible::Auth

[![Gem Version](https://badge.fury.io/rb/aptible-auth.png)](https://rubygems.org/gems/aptible-auth)
[![Build Status](https://travis-ci.org/aptible/aptible-auth-ruby.png?branch=master)](https://travis-ci.org/aptible/aptible-auth-ruby)
[![Dependency Status](https://gemnasium.com/aptible/aptible-auth-ruby.png)](https://gemnasium.com/aptible/aptible-auth-ruby)

Ruby client for [auth.aptible.com](https://auth.aptible.com/). Aptible's authorization server is built on top of [OAuth 2.0](http://tools.ietf.org/html/rfc6749) and [HAL+JSON](http://tools.ietf.org/html/draft-kelly-json-hal-06), and so this client is just a thin layer on top of the [oauth2](https://github.com/intridea/oauth2) and [HyperResource](https://github.com/gamache/hyperresource) gems.

## Installation

Add the following lines to your application's Gemfile.

    gem 'aptible-auth'
    gem 'oauth2', github: 'fancyremarker/oauth2', branch: 'aptible'

The forked version of the OAuth2 gem is necessary until [intridea/oauth2#165](https://github.com/intridea/oauth2/pull/165) and [intridea/oauth2#166](https://github.com/intridea/oauth2/pull/166) are merged.

And then run `bundle install`.

## Usage

First, get a token:

```ruby
token = Aptible::Auth::Token.new(email: 'user0@example.com', password: 'password')
```

Then, initialize a client:
```ruby
auth = Aptible::Auth::Client.new(token: token)
```

From here, you can interact with the Authorization API however you wish:

```ruby
auth.get
auth.clients.count
# => 4
auth.clients.first.name
# => "Client 0"
client = auth.clients.create(name: 'Dogeclient')
client.href
# => "http://localhost:4000/clients/60765b69-ffd8-4762-b9d2-96354ddb16f9"
```

## Configuration

| Parameter | Description | Default |
| --------- | ----------- | --------------- |
| `root_url` | Root URL of the authorization server | `https://auth.aptible.com` |

To point the client at a different authorization server (e.g., during development), add the following to your application's initializers:

```ruby
Aptible::Auth.configure do |config|
  config.root_url = 'http://some.other.url'
end
```

## Contributing

1. Fork the project.
1. Commit your changes, with specs.
1. Ensure that your code passes specs (`rake spec`) and meets Aptible's Ruby style guide (`rake rubocop`).
1. Create a new pull request on GitHub.

## Copyright and License

MIT License, see [LICENSE](LICENSE.md) for details.

Copyright (c) 2013 [Aptible](https://www.aptible.com), Frank Macreery, and contributors.
