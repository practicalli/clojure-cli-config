# Practicalli deps.edn configuration
A feature rich `deps.edn` file with a collection of aliases for Clojure projects.  Inspiration taken from [seancorfield/dot-clojure](https://github.com/seancorfield/dot-clojure).

Copy the `deps.edn` file to `~/.clojure/deps.edn` and the configuration and aliases will be included in any `deps.edn` project.  Any directory can be a viable `deps.edn` project by including a `deps.edn` file containing an empty map, `{}` or a map with any additional configuration.



# Aliases
Here is a summary of the aliases included so far.

Please read the [deps.edn](deps.edn) file to see the specific configuration for each alias.


## Creating projects from templates
Create and update projects from deps, leiningen and boot templates with [clj-new](https://github.com/seancorfield/clj-new)

* `:new`

Create a new project: `clojure -A:new template-name domain/namespace`

Run project: `clojure -m myname.myapp`


## repl experience
[Rebel readline](https://github.com/bhauman/rebel-readline) provides a feature rich REPL experience, far beyond the basic `clojure` and `clj` commands.

* `rebel` - run a Clojure REPL
* `rebel-cljs` - run the default ClojureScript REPL, eg. Nashorn

`:repl/help` in the REPL for help and available commands.  `:repl/quit` to close the REPL.


## Java source
[Look up Java Class and method definitions, eg. `cider-find-var` in Emacs](https://practicalli.github.io/spacemacs/navigating-code/java-definitions.html)
Requires: Java sources installed locally, examples from Ubuntu package install locations

* `:java-8-source`
* `:java-11-source`


## Testing frameworks
Unti test libraries, contracts and generative testing

* `clojure-test` requires no alias as it is a part of the Clojure jar file.
* `:spec` - define contracts for function definitions and data structures
* `:spec2` - under active development
* [`:expectations`](https://github.com/clojure-expectations/expectations) - test framework

Run expectations with cognitect test runner: `clojure -A:expectations:test-runner-cognitect`


## Test runners
Tools to run unit tests in a project which are defined under `test` path.

Run clojure with the specific test runner alias: `clojure -A:test-runner-alias`

* [`:test-runner-cognitect`](https://github.com/cognitect-labs/test-runner) - Cognitect test-runner
* [`:test-runner-midje`	](https://github.com/miorimmax/midje-runner)
* [`:test-runner-eftest`](https://github.com/weavejester/eftest) - fast and pretty test runner
* [`:test-runner-kaocha`](https://github.com/lambdaisland/kaocha) - comprehensive test runner for Clojure/Script

## Linting/ static analysis

* [:clj-kondo](https://github.com/borkdude/clj-kondo/) - comprehensive and fast linter
* [`:eastwood`](https://github.com/jonase/eastwood) - classic linter for Clojure
* [`:kibit`](https://github.com/jonase/kibit) - checking for idiomatic Clojure code


## Dependency version management
Manage versions for maven and git dependencies

* [:outdated](https://github.com/Olical/depot) - report newer dependencies
* [:outdated-update](https://github.com/Olical/depot) - update all dependencies
* [ancient](https://github.com/slipset/deps-ancient) - check for newer dependencies


## Hot loading dependencies (alpha)

* :deps-alpha
Add jar dependencies into a running REPL.  In the REPL, required the add-lib function

```
(require '[clojure.tools.deps.alpha.repl :refer [add-lib]])
  (add-lib 'domain/library {:mvn/version "RELEASE"})
```

To include dependencies from Git
```
(require '[clojure.tools.gitlibs :as gitlibs])
(defn load-master [lib]
  (let [git (str "https://github.com/" lib ".git")]
    (add-lib lib {:git/url git :sha (gitlibs/resolve git "master")})))
(load-master 'clojure/tools.trace)
```


## Deployment

* [:depstar](https://github.com/seancorfield/depstar) - build jars, uberjars
```
clojure -A:depstar -m hf.depstar.jar MyLib.jar
clojure -A:depstar -m hf.depstar.uberjar MyProject.jar
```

* [:uberdeps](https://github.com/tonsky/uberdeps) - uberjar builder


## Performance testing

* [:bench](https://github.com/hugoduncan/criterium/)
Adhoc performance testing the the REPL

```
clojure -A:rebel:bench

(require '[criterium.core :refer [bench quick-bench]])
(bench (adhoc-expression))
```

Performance test a project in the REPL
```
clojure -A:rebel:bench

(require '[practicalli/namespace-name]) ; require project code
(in-ns 'practicalli/namespace-name)
(quick-bench (project-function args))
```


*  [:measure](https://github.com/clojure-goes-fast/clj-memory-meter) - memory usage
In the REPL:
```
  (require '[clj-memory-meter.core :as mm])
   (mm/measure (your-expression))
```
