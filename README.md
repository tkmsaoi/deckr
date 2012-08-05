# Deckr

Deckr is a utility for [deck.js](http://imakewebthings.com/deck.js/).

- Generate a [Sinatra](http://www.sinatrarb.com/) application for deck.js.
- Easy to write slides.
  - Provide shortcuts for managing Extension, Style and Transition.
  - Write slides with favorite template engine. (default is [slim](http://slim-lang.com/))


## Installation

TODO


## Usage

    $ deckr new presentations
    $ cd presentations
    $ bundle install --path vendor/bundle
    $ bundle exec rackup

Visit http://localhost:9292/ in your web browser. You should see the example slides.
When writing slides, edit presentation files under the "views" directory.


## License

Copyright (c) 2012 Takamasa Aoi. See LICENSE in this directory.
