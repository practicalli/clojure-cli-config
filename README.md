# deps-edn-examples
A collection of useful configuration and aliases for deps.edn based projects.  Take a look at [seancorfield/dot-clojure](https://github.com/seancorfield/dot-clojure) for more examples


# Aliases
Here is a summary of the aliases included so far.

Please read the [deps.edn](deps.edn) file to see the specific configuration for each alias.

## repl experience
* `rebel` - run a repl with syntax highlighting, built in docs and a proper quit mechanism 

## Test runners
* `:test-runner` (part of clj-new app template)
* `:eftest` - nice and fast test runner for Clojure, with nice output
* `:kaocha` - comprehensive test runner (not quite as fast as eftest)

## Manage dependencies
* `ancient` checks clojars for newer versions of mvn dependencies (is there something for newer commits in git based dependencies?)

## Deployment
* depstar

> There are several other approaches to include...

