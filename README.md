# deps-edn-examples
A collection of useful configuration and aliases for deps.edn based projects.  Take a look at [seancorfield/dot-clojure](https://github.com/seancorfield/dot-clojure) for more examples


# Aliases
Here is a summary of the aliases included so far.

Please read the [deps.edn](deps.edn) file to see the specific configuration for each alias.

## Creating projects from templates
Create and update projects from deps, leiningen and boot templates with [clj-new](https://github.com/seancorfield/clj-new)

* `:new`

Create a new project: `clojure -A:new template-name domain/namespace`

Run project: `clojure -m myname.myapp`

Run tests (deps projects): `clojure -A:test:runner`


## repl experience
* `rebel` - run a repl with syntax highlighting, built in docs and a proper quit mechanism

`clojure -A:rebel` to start and `:repl/help` for details.


## Test runners
Run unit tests for your project from the command line

* `:test-runner` (part of clj-new app template)
* `:eftest-runner` - nice and fast test runner for Clojure, with nice output
* `:kaocha` - comprehensive test runner (not quite as fast as eftest)


  ;; Testing frameworks
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  ;; Clojure.test
  ;; Nothing required - available via Clojure

  ;; Clojure spec
  :spec
  {:extra-deps org.clojure/spec.alpha {:mvn/version "0.2.176"}}


  ;; Clojure spec 2 - under active development
  :spec2
  {:extra-deps {org.clojure/spec-alpha2
                {:git/url "https://github.com/clojure/spec-alpha2"
                 :sha     "495e5ac3238be002b4de72d1c48479f6bec06bb3"}}}


  ;; Expectations test framework
  ;; - see https://github.com/clojure-expectations/expectations
  ;; - and https://github.com/clojure-expectations/clojure-test
  ;; clj -A:test:expect:test-runner (cognitect test runner)
  :expect
  {:extra-deps {expectations              {:mvn/version "RELEASE"}
                expectations/clojure-test {:mvn/version "RELEASE"}}}


## Test runners
Tools to run unit tests in projects defined under `test` path.

Run clojure with the specific test runner alias: `clojure -A:test-runner-alias`

* [:test-runner](https://github.com/cognitect-labs/test-runner) - Cognitect test-runner
* [:midje-runner](https://github.com/miorimmax/midje-runner)
* [:eftest](https://github.com/weavejester/eftest) - fast and pretty test runner
* [:kaocha](https://github.com/lambdaisland/kaocha) - comprehensive test runner for Clojure/Script


## Linting/ static analysis

* [:clj-kondo](https://github.com/borkdude/clj-kondo/) - comprehensive and fast linter
* :eastwood
* :kibit


## Dependency version management
Manage versions for maven and git dependencies

* [:outdated](https://github.com/Olical/depot) - report newer dependencies
* [:outdated-update](https://github.com/Olical/depot) - update all dependencies
* [ancient](https://github.com/slipset/deps-ancient) - check for newer dependencies

## Deployment

* [:depstar](https://github.com/seancorfield/depstar) - build jars, uberjars
```
clojure -A:depstar -m hf.depstar.jar MyLib.jar
clojure -A:depstar -m hf.depstar.uberjar MyProject.jar
```

* [:uberdeps](https://github.com/tonsky/uberdeps) - uberjar builder


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
