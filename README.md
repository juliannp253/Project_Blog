# Codespaces Rails 8 Template

Welcome to your brand new codespace template with Rails 8 loaded. 

## How to use this template

* When you create a new Codespaces let the image build (it will take around 5 to 10 minutes).
* Confirm installation running ```ruby -v```, ```rails -v```, and ```yarn -v```, these commands should not generate errors
* If they do run the following commands in order:

```shell
sudo apt-get update
sudo apt-get install npm -y
sudo npm install -g yarn -y
bundle config set without 'production'
bundle install
yarn install --check-files
```
* Go to Ports and change the visibility of the port to `Public`

Done you are ready to use the template!

## Gems to note

This template comes pre-loaded with all the gems we will use in the semester:

* cucumber_rails
* capybara
* rspec_rails
* factory_bot_rails
* pg
* sqlite3

You can add more gems with ```bundle add GEM_NAME```

## Rails quality of life

* Rails 8 is great you can build a quick authentication system with the following command

```shell
bin/rails generate authentication
```

This generator creates necessary models, controllers, mailers, and views, streamlining the process of implementing secure, session-based authentication. 

***NOTE: Registration is our job to define.***

* Rails has a bunch of generators for `scaffold`, `rspec:model`, `rspec:controller`, etc. Those are some key words, you can look the generators online. NOTE: If you do this is when you should make branches to avoid breaking the main copy of your template.

## Running tests

* You can run tests as always

```shell
cucumber
rspec
```

* Or you can use `rake` to run all tests at once. ***WARNING: Delete any tests in the `test/` folder if the generators create them, they do not work, remove them (expect the factories)***.

## Deploying

* The app should deploy in the browser (this does not work currently 😅, but leaving it here in case you want to solve that issue)
* Instead open the app in a separate tab in your browser.
* If the app is not running use `rails server` in the terminal.
