![Practicalli Clojure deps.edn user wide configuration for Clojure projects](https://raw.githubusercontent.com/practicalli/graphic-design/master/practicalli-clojure-deps.png)

[practicalli/clojure-deps-edn](https://github.com/practicalli/clojure-deps-edn) provides a user wide configuration, `~/.clojure/deps.edn`, for over 30 aliases to support Clojure CLI and tools.deps project development.  These aliases use meaningful and descriptive names to avoid clashes with project specific aliases, ensuring that the user wide aliases remain available in all projects.

Aliases with common options are provided for convenience and to minimize the amount of cognitive load required to remember how to use aliases. Inspiration taken from [seancorfield/dot-clojure](https://github.com/seancorfield/dot-clojure).


## Installing Clojure deps.edn
[Fork the practicalli/clojure-deps-edn repository](https://github.com/practicalli/clojure-deps-edn/) and clone your fork to an existing `~/.clojure/` directory (eg. $HOME/.clojure or %HOME%\.clojure).

```shell
git clone your-fork-url ~/.clojure/
```

The configuration from `~/.clojure/deps.edn` is now available for all Clojure CLI projects for that user account.

Any directory containing a `deps.edn` file is considered a Clojure project. A `deps.edn` file can contain an empty hash-map, `{}` or hash-map with configuration.  The project `deps.edn` file is merged with the user wide configuration, with the project `deps.edn` keys taking precedence if there is duplication.

![Clojure CLI tools deps.edn configuration precedence](https://raw.githubusercontent.com/jr0cket/developer-guides/master/clojure/clojure-cli-tools-deps-edn-configuration-precedence.png)

See the rest of this readme for examples of how to use each alias this configuration contains.


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
* `rebel-nrepl` - run rebel REPL with nrepl connection for editor connections (eg. CIDER, Calva)

`:repl/help` in the REPL for help and available commands.  `:repl/quit` to close the REPL.

* `:dev` include `dev/` in classpath to [configure REPL startup actions using `dev/user.clj`](http://practicalli.github.io/clojure/repl-driven-development/configure-repl-startup.html)


[Reveal](https://github.com/vlaaad/reveal) is a repl and data visualization tool

* `repl-reveal` - repl and data visualization tool
* `clojure -A:repl-reveal-themed` - repl and data visualization tool with light theme
* `repl-reveal-nrepl` - repl and data visualization tool with nrepl server, for connection from [Clojure aware editors](https://practicalli.github.io/clojure/clojure-editors/)

`clj -A:repl-reveal` to start a Reveal repl with data visualization window that shows all values.

  ;; clojure -R:repel-reveal -A: rebel
`clojure -R:repl-reveal -A:rebel` to start a REPL with Rebel Readline with Reveal dependency. Evaluate `(add-tap ((requiring-resolve 'vlaaad.reveal/ui)))` to add Reveal as a tap source, showing `tap>` expressions in the reveal window.

`clojure -R:repl-reveal -A:rebel -J-Dvlaaad.reveal.prefs='{:theme :light :font-family "Ubuntu Mono" :font-size 32}'` to run Rebel Readline with Reveal using a light theme.  Change the values in the map for a different theme.

[Practicalli Clojure - data browsers section](http://practicalli.github.io/clojure/clojure-tools/data-browsers/reveal.html) has more details on using reveal.

## Data browsing
[Portal](https://github.com/djblue/portal) (new project)
Navigate data in the form of edn, json and transit
[Practicalli Clojure -data browsers section - portal](https://practicalli.github.io/clojure/clojure-tools/data-browsers/portal.html)

* `inspector-portal-cli` - Clojure CLI (simplest approach)
* `inspector-portal-web` - Web ClojureScript REPL
* `inspector-portal-node` - node ClojureScript REPL

`(require '[portal.api :as portal])` once the REPL starts.  For `inspector-portal-web` use `(require '[portal.web :as portal])` instead

`(portal/open)` to open the web based inspector window in a browser.

`(portal/tap) `to add portal as a tap target (add-tap)

`(tap> {:accounts [{:name "jen" :email "jen@jen.com"} {:name "sara" :email "sara@sara.com"}]})` to send data to the portal inspector window (or any other data you wish to send)

`(portal/clear)` to clear all values from the portal inspector window.

`(portal/close)` to close the inspector window.


Cognitect REBL
Browse data structures as they are generated in the Clojure REPL.

* `cognitect-rebl` - REBL, a visual data explorer (Java 11)
* `cognitect-rebl-java8` - REBL, a visual data explorer (Java 8)

* `:nrebl` - REBL data browser on nREPL connection

Run REBL listening to nREPL using the command
```shell
clojure -R:nrepl:cider-nrepl:cognitect-rebl -A:nrebl
```

`cider-connect` in Emacs CIDER successfully connects to the nREPL port and evaluated code is sent to REBL.  Create a `dir-locals.el` file with the following aliases:
```
((clojure-mode . ((cider-clojure-cli-global-options . "-R:nrepl:cider-nrepl:cognitect-rebl -A:nrebl.middleware"))))
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

* [:carve](https://github.com/borkdude/carve) - EXPERIMENTAL, use with caution - carve out unwanted vars in code

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

Build a project archive file for deployment

* [:build-depstar](https://github.com/seancorfield/depstar) - build jars, uberjars for deps.edn projects
```
clojure -A:depstar -m hf.depstar.jar MyLib.jar
clojure -A:depstar -m hf.depstar.uberjar MyProject.jar
```

* [:build-uberdeps](https://github.com/tonsky/uberdeps) - uberjar builder


Deploy a project archive file locally or to Clojars.org

* [:deploy-locally](https://github.com/slipset/deps-deploy) - copy jar to `~/.m2/` directory
* [:deploy-clojars](https://github.com/slipset/deps-deploy) - deploy jar to [clojars.org](https://clojars.org/)
* [:deploy-clojars-signed](https://github.com/slipset/deps-deploy) - sign and deploy jar to [clojars.org](https://clojars.org/)

Deploy Locally:
`clojure -A:deploy-locally project.jar`
Deploy to Clojars:
`clojure -A:deploy-clojars project.jar`
Deploy to Clojars signed:
`clojure -A:deploy-clojars-signed project.jar`

Path to project.jar can also be set in alias to simplify the Clojure command.

Set Clojars username/token in `CLOJARS_USERNAME` and `CLOJARS_PASSWORD` environment variables.
Set fully qualified artifact-name and version in project `pom.xml` file


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

## Library repositories
Repositories that host libraries for Clojure.

If using a mirror for a repository the original repository should not be included as well.  The order in which repositories are consulted is not guaranteed, so may cause unpredictable side effects in the project build especially if `RELEASE` or `LATEST` tags are used rather than a numeric library version.

Maven supports [explicit mirror definition](http://maven.apache.org/guides/mini/guide-mirror-settings.html) in `~/.m2/settings.xml` and Clojure CLI tools(tools.deps) supports this configuration.  Adding Maven Central or a mirror to  `~/.m2/settings.xml` negates the need for its entry in deps.edn configuration.

**Recommended repositories**
* `central` - Maven Central, the canonical repository for JVM libraries, including Clojure releases
* `clojars` - clojars.org, the canonical repositories for Clojure community libraries fronted by a contend delivery network service, https://repo.clojars.org/

**Optional repositories**
* `sonatype` - snapshots of Clojure development releases, useful for testing against before new stable releases.
* `jcenter` - the largest mirror of all open source libraries (useful as a backup or accessing through corporate firewalls)
* `business-area** - example of adding a local Artifactory server for your team or business area.
* `google-maven-central` - [Maven Central mirror hosted on Google Cloud Storage](https://storage-download.googleapis.com/maven-central/index.html) - Americas, Asia, Europe

**Americas mirrors**
```clojure
 :mvn/repos
 {"google-maven-central" {:url "https://maven-central.storage-download.googleapis.com/maven2/"}}
```

**Europe mirrors**
Use only one mirror entry for a specific repository, to ensure a repeatable build.
```
 :mvn/repos
 {"google-maven-central" {:url "https://maven-central-eu.storage-download.googleapis.com/maven2/"}

 ;; UK specific mirror
 "uk"      {:url "http://uk.maven.org/maven2/"}

  ;; CDN access to clojars
  "clojars" {:url "https://repo.clojars.org/"}}
```

**Asian Region Mirrors**
```
 :mvn/repos
 {"google-maven-central" {:url "https://maven-central-asia.storage-download.googleapis.com/maven2/"}

  ;; Community mirror
  "clojars-china-mirror" {:url "https://mirrors.tuna.tsinghua.edu.cn/clojars/"}

  ;; CDN access to clojars
  "clojars" {:url "https://repo.clojars.org/"}}
```

**Maven local repository**
```
 :mvn/local-repo "m2"
```

> NOTE: using `clj -Sforce` forces a classpath recompute, deleting the contents of .cpcache
