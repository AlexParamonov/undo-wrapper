Undo
==========
[![Build Status](https://travis-ci.org/AlexParamonov/undo-wrapper.png?branch=master)](https://travis-ci.org/AlexParamonov/undo-wrapper)
[![Coverage Status](https://coveralls.io/repos/AlexParamonov/undo-wrapper/badge.png?branch=master)](https://coveralls.io/r/AlexParamonov/undo-wrapper?branch=master)
[![Code Climate](https://codeclimate.com/github/AlexParamonov/undo-wrapper.png)](https://codeclimate.com/github/AlexParamonov/undo-wrapper)
[![Gemnasium Build Status](https://gemnasium.com/AlexParamonov/undo-wrapper.png)](http://gemnasium.com/AlexParamonov/undo-wrapper)
[![Gem Version](https://badge.fury.io/rb/undo-wrapper.png)](http://badge.fury.io/rb/undo-wrapper)

Wrapper for [Undo gem](https://github.com/AlexParamonov/undo).
Observe changes and stores object state before the change.

Contents
---------
1. Installation
1. Usage
1. Requirements
1. Contacts
1. Compatibility
1. Contributing
1. Copyright

Installation
------------

Add this line to your application's Gemfile:

    gem 'undo-wrapper'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install undo-wrapper


Usage
-----

`Undo::wrapper` allows to wrap object in decorator:

    decorated_object = Undo.wrap object
    decorated_object.destroy
    Undo.restore decorated_object.uuid

decorated_object is a pure decorator, so it quacks like original
object. The Undo will store object state on each hit to mutation
methods such as `update`, `delete`, `destroy`. Those methods can be
changed either in place or using global configuration.

`store_on` defines a list of methods which may mutate object state.
For each hit to such methods `Undo.store` will be called.

By default `store_on` are `update`, `delete`, `destroy`. To
append custom `store_on` use:

    Undo::Wrapper.configure do |config|
      config.store_on += [:put, :push, :pop]
    end

    Undo.wrap object, store_on: [:delete, :destroy]

Or in place:

    Undo.wrap object, store_on: :save

Any option, that is not recognized by the Undo as configuration
option, will be bypass to the serializer and storage adapter:

    Undo.wrap post, include: :comments, expires_in: 1.hour


Requirements
------------
1. Ruby 1.9 or above
1. Undo gem

Contacts
--------
Have questions or recommendations? Contact me via `alexander.n.paramonov@gmail.com`  
Found a bug or have enhancement request? You are welcome at [Github bugtracker](https://github.com/AlexParamonov/undo-wrapper/issues)


Compatibility
-------------
tested with Ruby

* 2.1
* 2.0
* 1.9.3
* ruby-head
* rbx
* jruby-19mode
* jruby-head

See [build history](http://travis-ci.org/#!/AlexParamonov/undo-wrapper/builds)


## Contributing

1. [Fork repository](http://github.com/AlexParamonov/undo-wrapper/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

Copyright
---------
Copyright © 2014 Alexander Paramonov.
Released under the MIT License. See the LICENSE file for further details.
