# An Event

## The Things We Must Have

1. [rbenv](https://github.com/rbenv/rbenv)
2. [nvm](https://github.com/nvm-sh/nvm)
3. [docker](https://www.docker.com/products/docker-desktop)
4. [bundler](https://bundler.io/) (2.0.2)

## The Things We Must Do

1. `rbenv install` (will use our `.ruby-version` to install the necessary ruby)
2. `nvm use` (we must actually do this pretty much every time we open a new terminal)
3. `bundle install` (install gems.  see notes below if bad things happen)
4. `bin/yarn` (installs javascript dependencies.  does rails really still ship with `yarn` instead of `npm`?  anyway.)
5. `docker-compose up -d` (brings up the database)
6. `touch config/master.key` (adds master key file. next you must populate it with the MASTER KEY, which can be obtained from Truman)
7. `bin/rails db:prepare` (sets up database, runs migrations)
8. `bin/rails db:seed:replant` (adds some test data, found in `db/seeds.rb`)

## When Things Explode

### YARN

```
warning Integrity check: System parameters don't match
error Integrity check failed
error Found 1 errors.


========================================
  Your Yarn packages are out of date!
  Please run `yarn install --check-files` to update.
========================================


To disable this check, please change `check_yarn_integrity`
to `false` in your webpacker config file (config/webpacker.yml).


yarn check v1.13.0
info Visit https://yarnpkg.com/en/docs/cli/check for documentation about this command.


Exiting
```

This means that we either haven't run `bin/yarn`, or, more likely, we're not using the correct version of node.

**TO FIX**:  Run `nvm use` in the terminal where you're trying to run `bin/rails whatever`.

### PUMA

`Gem::Ext::BuildError: ERROR: Failed to build gem native extension`

This is probably because Mac OS is doing whatever it is that it wants [and is breaking the c compiler](https://stackoverflow.com/a/63201544).

**TO FIX**: `bundle config build.puma --with-cflags="-Wno-error=implicit-function-declaration"` and then go about your `bundle install` or whatever.
