# Ruby scripting test
This repository was made to reply to the "Teller machine" ruby test, that can be found [here](https://github.com/mgrassotti/teller_machine_ruby/blob/master/docs/requirements.html).

## Requirements
In order to launch the script, you need `ruby` to be installed on your machine. Please check out the installation instructions here https://www.ruby-lang.org/en/documentation/installation/.

For the exact ruby version, please check the `.ruby-version` file.

OPTIONAL: you can install the `simplecov` gem to produce a code coverage report while running the test suite.

## Launch the script
After downloading the repository to your machine, you can run `irb` and `require 'checkout'` from the project directory.

Then you can test the teller, e.g.:
```
    promotional_rules = {}
    co = Checkout.new(promotional_rules)
    item = {}
    co.scan(item)
    item = {}
    co.scan(item)
    price = co.total
```

## Running tests
In order to run the test suite, you need to install `rspec`.

If you didn't installed it before:
```
$ gem install rspec
```
Then you can run it, inside the project folder:
```
$ rspec
```

## Feedbacks
Please open a new Github issue for any comment.
