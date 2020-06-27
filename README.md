# Practicalli deps.edn configuration
A feature rich `deps.edn` file with a collection of aliases for Clojure projects.  Include aliases with common options for convienience and to minimise the amount of cognitive load required to remember how to use aliases.  Inspiration taken from [seancorfield/dot-clojure](https://github.com/seancorfield/dot-clojure).

![Practicalli Clojure deps - logos](practicalli-clojure-deps.png)

## Using this repository
[Fork this repository](https://github.com/practicalli/clojure-deps-edn/fork) and clone your fork to the `~/.clojure` directory in the root of your home directory for the operating system in use.

```shell
git clone your-fork-url ~/.clojure
```

Alternately, manually copy the `deps.edn` file or specific sections of that file to `~/.clojure/deps.edn`, creating that file if it does not exist.

The configuration and aliases will be included in any `deps.edn` project.  Any directory containing a `deps.edn` project is considered a Clojure project.  Project specific `deps.edn` files containing an empty map, `{}` or a map with any additional configuration.  Either way, all the configuration from `~/.clojure/deps.edn` will be available (unless over-ridden by project specific settings).

## Updating
The collection of aliases is regularly reviewed and expanded upon and suggestions are most welcome.

The versions of libraries are manually updated at least once per month using the `:outdated` alias and a new version of the `deps.edn` file pushed to this repository.
```shell
cd ~/.clojure/
clojure -A:outdated
```

To automatically update library versions for aliases, then use the `:outdated-update` alias.  It is prudent to review what has been updated before using the results.
```shell
cd ~/.clojure/
clojure -A:outdated-update
```


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


## Data browsing - Cognitect REBL
Browse data structures as they are generated in the Clojure REPL.

* `cognitect-rebl-java8` - REBL, a visual data explorer (Java 8)
* `cognitect-rebl-java11` - REBL, a visual data explorer (Java 11)

* :`nrebl.middleware` - REBL data browser on nREPL connection (uses )

Run REBL listening to nREPL using the command
```shell
clojure -R:nrepl:cider-nrepl:cognitect-rebl-java11 -A:nrebl
```

`cider-connect` in Emacs CIDER successfully connects to the nREPL port and evaluated code is sent to REBL.  Create a `dir-locals.el` file with the following aliases:
```
((clojure-mode . ((cider-clojure-cli-global-options . "-R:nrepl:cider-nrepl:rebl-java11 -A:nrebl.middleware"))))
```

## Java source
[Look up Java Class and method definitions, eg. `cider-find-var` in Emacs](https://practicalli.github.io/spacemacs/navigating-code/java-definitions.html)
Requires: Java sources installed locally, examples from Ubuntu package install locations

* `:java-8-source`
* `:java-11-source`


## Testing frameworks
Unit test libraries, specifications and generative testing

`clojure-test` requires no alias as it is a part of the Clojure jar file.  If not using a test running the `:test-path` alias may be required to add the test directory to the class path in order to see test code.

* `:spec` - define specifications for functions and data structures
* `:spec2` - under active development

* [`:expectations`](https://github.com/clojure-expectations/clojure-test) - `clojure.test` with expectations
* [`:expectations-classic`](https://github.com/clojure-expectations/expectations) - expectations framework

Use expectations in a project `clojure -A:test:expectations` or from the command line with cognitect test runner `clojure -A:expectations:test-runner-cognitect`


## Test runners
Tools to run unit tests in a project which are defined under `test` path.

Run clojure with the specific test runner alias: `clojure -A:test-runner-alias`

* [`:test-runner-cognitect`](https://github.com/cognitect-labs/test-runner) - Cognitect test-runner
* [`:test-runner-cljs`](https://github.com/Olical/cljs-test-runner) - test runner for Clojure/Script
* [`:test-runner-kaocha`](https://github.com/lambdaisland/kaocha) - comprehensive test runner for Clojure/Script
* [`:test-runner-midje`	](https://github.com/miorimmax/midje-runner) - runner for midje and clojure.test tests
* [`:test-runner-eftest`](https://github.com/weavejester/eftest) - fast and pretty test runner


## Test Coverage tools
[Cloverage](https://github.com/cloverage/cloverage) - simple clojure coverage tool for `clojure.test` defined unit tests.

Run clojure with the test coverage alias: `clojure -A:test-coverage`

* [:test-coverage](https://github.com/cloverage/cloverage)


## Linting/ static analysis

* [`:lint`](https://github.com/borkdude/clj-kondo/) - comprehensive and fast lint tool
* [`:lint-eastwood`](https://github.com/jonase/eastwood) - classic lint tool for Clojure
* [`:idiom-check`](https://github.com/jonase/kibit) - checking for idiomatic Clojure code with Kibit


## Dependency version management
Manage versions for maven and git dependencies

* [:outdated](https://github.com/Olical/depot) - report newer dependencies (git and maven)
* [:outdated-update](https://github.com/Olical/depot) - update all dependencies (git and maven)
* [:outdated-ancient](https://github.com/slipset/deps-ancient) - check for newer dependencies (maven)


## Hot loading dependencies (unofficial - changes planned already)
> This is a very unofficial approach to hot loading and the design may change quite soon, so this alias is likely to break without notice.  Do not rely on this alias working and use with caution.

* [`:hot-load-deps`](https://github.com/clojure/tools.deps.alpha) - Add jar dependencies into a running REPL.

Require the `add-lib` function to include a maven style dependency
```
(require '[clojure.tools.deps.alpha.repl :refer [add-lib]])
  (add-lib 'domain/library {:mvn/version "RELEASE"})
```

Require `clojure.tools.gitlibs` namesapace to hot load dependencies from a Git repository
```
(require '[clojure.tools.gitlibs :as gitlibs])
(defn load-master [library]
  (let [git (str "https://github.com/" library ".git")]
    (add-lib library {:git/url git :sha (gitlibs/resolve git "master")})))
(load-master 'clojure/tools.trace)
```

## Visualizing project vars and library dependencies
Create [Graphviz](https://www.graphviz.org/) graphs of project and library dependencies

Morpheus creates grahps of project vars and their relationships

* [`:graph-vars`](https://github.com/benedekfazekas/morpheus) - generate graph of vars in a project as a .dot file
* [`:graph-vars-png`](https://github.com/benedekfazekas/morpheus) - generate graph of vars in a project as a .png file using `src` and `test` paths
* [`:graph-vars-svg`](https://github.com/benedekfazekas/morpheus) - generate graph of vars in a project as a .svg file using `src` and `test` paths

> Install [Graphviz](https://www.graphviz.org/) to generate PNG and SVG images.  Or use the [Edotor website](https://edotor.net/) to convert .dot files to PNG or SVG images and select different graph layout engines.


[Vizns](https://github.com/SevereOverfl0w/vizns) creates graphs of relationships between library dependencies and project namespaces

* `:graph-deps`
* `:graph-deps-png` - generate a single deps-graph png image

Other options:
* `clj -A:graph-deps navigate`  # navigable folder of SVGs
* `clj -A:graph-deps single`    # deps-graph.dot file
* `clj -A:graph-deps single -o deps-graph.png -f png`
* `clj -A:graph-deps single -o deps-graph.svg -f svg`
* `clj -A:graph-deps single --show `  # View graph without saving


## Deployment

* [:build-depstar](https://github.com/seancorfield/depstar) - build jars, uberjars for deps.edn projects
```
clojure -A:depstar -m hf.depstar.jar MyLib.jar
clojure -A:depstar -m hf.depstar.uberjar MyProject.jar
```

* [:build-uberdeps](https://github.com/tonsky/uberdeps) - uberjar builder


## Performance testing

* [:benchmark](https://github.com/hugoduncan/criterium/)
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
  (require '[clj-memory-meter.core :as memory-meter])
   (memory-meter/measure (your-expression))
```
