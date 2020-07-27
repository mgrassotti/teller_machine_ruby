# Ruby scripting test - Teller Machine
This repository was made to reply to the "teller machine test". For the full requirements, you can check [this](https://github.com/mgrassotti/teller_machine_ruby/blob/master/docs/requirements.html) page.

## Requirements
In order to use the repository, you need `ruby` to be installed on your machine. Please check out the installation instructions here https://www.ruby-lang.org/en/documentation/installation/.

For the exact ruby version, please check the `.ruby-version` file.

OPTIONAL: you can install the `simplecov` gem to produce a code coverage report while running the test suite.

## Use the code
After downloading the repository to your machine, you can run `irb` and `require 'checkout'` from the project directory.

Then you can test the teller providing some test data, such as:
```
    promotional_rules = [
      { on: 'total', amount: 60, discount_percentage: 0.1 },
      { on: 'quantity', units: 2, price: 8.5, product_code: '001' }
    ]
    co = Checkout.new(promotional_rules)
    co.scan('001')
    co.scan('002')
    price = co.total
```

## Customise the products list
You can change the products list located [here](https://github.com/mgrassotti/teller_machine_ruby/blob/master/data/products.yml), or provide a custom file path to the `Checkout` class: `Checkout.new(promotional_rules, <custom_file_path>)`

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
