# Hyperstack-js Starter Kit

### 100% ruby/react | 0% javascript/rails

Boilerplate/Demo to start with Hyperstack WebApp without Rails.

This Starter Kit is a port of the hyperstack [TodoMVC Tutorial Part I](https://docs.hyperstack.org/tutorial/todo) with all Rails stuff removed.

### Features
- **Opal 1.3.2, Hyperstack 1.0.alpha1.8, React v16.14.0, React Router v6.0.2**
  - payload of the whole libs in production : 376,26 Ko
- **no rails**
  - sinatra is used for development but optional: this starter produce pure static site.
- **no webpack, sprockets, npm, yarn, node_modules, etc.**
  - this good old rake is used to generate assets (rake is fast!).
  - js libs are provided via simple cdn. They are automatically downloadeds for local development.
  - sass support via ruby sassc gem
  - compression of js asset with ruby uglifier gem (only in production mode) + gzip.
  - You can of course use your favorite packer if it make sens for you.
- **instant compilation + livereload**
  - via [guard-rake](https://github.com/rubyist/guard-rake), [guard-livereload](https://github.com/guard/guard-livereload), [rack-livereload](https://github.com/johnbintz/rack-livereload)
### How to use
#### Prerequisites
Example from a fresh Ubuntu 20.04 :

1. Install rbenv ([see here](https://github.com/rbenv/rbenv-installer#rbenv-installer))
2. install ruby 2.7.4 :
```shell
sudo apt-get update
sudo apt install git curl libssl-dev libreadline-dev zlib1g-dev autoconf
sudo apt install bison build-essential libyaml-dev libreadline-dev libncurses5-dev libffi-dev libgdbm-dev
rbenv install 2.7.4
rbenv global 2.7.4
gem install bundler:2.2.5
```
3. install nodejs 16.13.0 ([see here](https://github.com/nodesource/distributions/blob/master/README.md#debinstall))


#### Installation
```shell
git clone https://github.com/jugcoding/hyperstack-js-starter
cd ./hyperstack-js-starter
bundle install --path vendor/bundle
```

#### Development
```shell
rake rebuild ## only once
rake server
```

- To test the site : visit [http://localhost:9292/](http://localhost:9292/)
- To test LiveReload : make some change in the app (files under ./app)

#### Production
```shell
rake PROD=true rebuild
rake PROD=true server
```

The generated static site for prod is located in ./dist/prod/

#### Other rake tasks

```shell
rake cdn             # download cdn files
rake cleanup         # remove ./dist folder
rake compile         # compile assets (opal+erb+scss)
rake default         # compile
rake erb             # compile erb assets
rake opal            # compile opal assets
rake sass            # compile scss assets
rake rebuild         # cleanup then setup
rake server          # run the server
rake setup           # download cdn files (in debug mode), create paths, then compile
rake setup_path      # create output paths
```

add PROD=true after rake to run those tasks in production mode

## Directory Structure:

Try to read all the code of ***Rake build system*** and ***Application runtime*** to own the starter as if you wrote it.

If some part seem unclear to you :  [ask here](https://github.com/fazibear/awesome-opal/issues/new?title=question:+).

### Application source code

```shell
├── app
│   ├── application.rb
│   ├── component
│   │   ├── edit_item.rb
│   │   ├── footer.rb
│   │   ├── header.rb
│   │   ├── hyper_component.rb
│   │   ├── index.rb
│   │   └── todo_item.rb
│   ├── component.rb
│   ├── model
│   │   └── todo.rb
│   └── model.rb
```

This is an example todo application in standard ruby code. You can follow the hyperstack [TodoMVC Tutorial Part I](https://docs.hyperstack.org/tutorial/todo) to learn it and to learn hyperstack.

- the entry point is ./app/application.rb
- the whole is compiled by rake into ./dist/(debug|prod)/static/opal/application.js
- you can replace it with you own hyperstack app :-)

### Application assets

```shell
├── assets
│   ├── css
│   │   ├── styles.scss   # compiled by rake into ./dist/(debug|prod)/static/css/styles.css
│   │   └── todo.css      # imported by styles.scss
│   └── html
│       └── index.erb     # compiled by rake into ./dist/(debug|prod)/index.html
```

- put your assets here
- add rake tasks in your Rakefile to add more assets
- see Rake builder below if you need to add new assets type
- if you don't like rake you can use tools like sprockets or webpack, or *[your prefered one here]* to build your assets.

### Application runtime (Opal + Hyperstack)

```shell
├── lib
│   ├── active_record.rb         # fake active_record
│   ├── active_record
│   │   ├── attributes.rb
│   │   ├── mutators.rb
│   │   ├── observers.rb
│   │   └── scope.rb
│   ├── hyperstack.rb            # hyperstack support
│   ├── native                   # this folder containt importeds native javascript libs
│   │   ├── jquery.rb
│   │   ├── native_importer.rb   # utils to import native react component
│   │   └── react_router_v6.rb   # support to react router v6
│   └── runtime.rb               # entry point compiled into ./dist/(debug|prod)/static/opal/runtime.js
```

- the entry point is ./lib/runtime.rb
- the whole is compiled by rake into ./dist/(debug|prod)/static/opal/runtime.js
- you can add your needed ruby libs here.

### Rake build system

```shell
├── Guardfile -> config/Guardfile    # LiveReload + LiveCompilation configuration
├── Rakefile                         # start from here to learn how things are build
├── config
│   └── Guardfile
└── rake                             # required from Rakefile, contains helper for rake
    ├── builder
    │   ├── asset.rb
    │   ├── compiler
    │   │   ├── cdn.rb               # handle cdn assets
    │   │   ├── erb.rb               # handle erb assets
    │   │   ├── opal.rb              # handle opal ruby source code assets
    │   │   └── sass.rb              # handle sass assets
    │   ├── compiler.rb              # base class of all compiler
    │   ├── default_targets.rb       # install some standards targets to rake : read it !!
    │   └── paths.rb                 # helper to handle destinations paths (./dist/(debug|prod), etc ...)
    └── builder.rb                   # some rake helpers
```

If you need new asset type : start from an existing compiler (sass.rb or opal.rb for eg) and write a new one.

You can replace the build system by a more sophisticated one. But this one is small and simple so that you can fix things easily.

### The buildeds sites :

- **./dist/debug** : contains the debug version of the site
- **./dist/prod** : contains the prod version of the site

```shell
├── dist
│   ├── debug
│   │   ├── index.html
│   │   └── static
│   │       ├── cdn
│   │       │   ├── create-react-class.js
│   │       │   ├── create-react-class.min.js
│   │       │   ├── history.development.js
│   │       │   ├── history.production.min.js
│   │       │   ├── jquery.js
│   │       │   ├── jquery.min.js
│   │       │   ├── react-dom.development.js
│   │       │   ├── react-dom.production.min.js
│   │       │   ├── react-router-dom.development.js
│   │       │   ├── react-router-dom.production.min.js
│   │       │   ├── react-router.development.js
│   │       │   ├── react-router.production.min.js
│   │       │   ├── react.development.js
│   │       │   ├── react.production.min.js
│   │       │   └── react_ujs.js
│   │       ├── css
│   │       │   └── styles.css
│   │       └── opal
│   │           ├── application.js
│   │           └── runtime.js
│   └── prod
│       ├── index.html
│       └── static
│           ├── css
│           │   └── styles.css
│           └── opal
│               ├── application.min.js
│               ├── application.min.js.gz
│               ├── runtime.min.js
│               └── runtime.min.js.gz
```

### Sinatra web server

```shell
├── backend
│   └── backend.rb
├── config
│   └── Procfile.dev
├── config.ru
```

A very basic web server to test your app.

### Ruby bundler

```shell
.
├── Gemfile
├── Gemfile.lock
```

Standard Gemfile
