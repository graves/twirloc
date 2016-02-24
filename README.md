# Twirloc

Twirloc is a command line interface to the twitter.com REST API.

It contains a set of tools for investigating users past or present locations through user, tweet, media, and connections' metadata.

## Usage
```
❯❯❯ bin/twirloc
Commands:
  twirloc geo USERNAME                    # checks if profile is geo enabled for USERNAME
  twirloc geocenter_user_tweets USERNAME  # calculates geographic centerpoint of any lat/lon coordinates from tweets by USERNAME
  twirloc help [COMMAND]                  # Describe available commands or one specific command
  twirloc locate USERNAME                 # takes best guess at users location
  twirloc total USERNAME                  # get total number of tweets for USERNAME
```
## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
