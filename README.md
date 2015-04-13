# ActiveRecord::PropertybaseId

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/activerecord/propertybase_id`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem "activerecord-propertybase_id"
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install activerecord-propertybase_id

## Usage

This ActiveRecord extension lets you use the [Propertybase ID](https://github.com/propertybase/propertybase_id) as a primary key in Rails.

### Migration

The Propertybase ID is stored via the `char(8)` data type (currently only tested on SQLite and PostgreSQL). You can also use the cusom migration type `propertybase_id`.

Note: As Rails doesn't really support changing the type of the primary key in the migration. You need to work around a little bit. You need to disable the ID for a sepcific table and then add it as

```ruby
class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams, id: false do |t|
      t.propertybase_id :id, primary_key: true

      t.string :name
      t.timestamps null: false
    end
  end
end
```

You are now all set to use the Propertybase ID as the primary key of your table.

### ActiveRecord Models

To make sure the ID is generated, you need to include the `ActiveRecord::PropertybaseId` module:

```ruby
class Team < ActiveRecord::Base
  include ActiveRecord::PropertybaseId
end
```

The PropertybaseId need the object type as input. By default the object type will be inferred by the model name (currently only Team and User working), but you override it by specifying `propertybase_object`

```ruby
class CustomizedUser < ActiveRecord::Base
  include ActiveRecord::PropertybaseId

  propertybase_object :user
end
```

## Caveats

Currently this gem only has been tested on PostgreSQL and SQLite and Rails version 4.2

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Atribution

Heavily inspired by [activeuuid](https://github.com/jashmenn/activeuuid).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/activerecord-propertybase_id/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
