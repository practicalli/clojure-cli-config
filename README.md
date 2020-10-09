![Practicalli Clojure deps.edn user wide configuration for Clojure projects](https://raw.githubusercontent.com/practicalli/graphic-design/master/practicalli-clojure-deps.png)

> MAJOR CHANGES: practicalli/clojure-deps-edn recommends using [Clojure CLI tools](https://clojure.org/guides/getting_started) version 1.10.1.697 or later.
> Aliases are now qualified keywords, which is recommended in general for using keywords in Clojure.
> Use the `classic-aliases` tag for the last version of this repository before these changes


[practicalli/clojure-deps-edn](https://github.com/practicalli/clojure-deps-edn) provides a user wide configuration, `~/.clojure/deps.edn`, for over 30 aliases to support Clojure CLI and tools.deps project development.  These aliases use meaningful and descriptive names to avoid clashes with project specific aliases, ensuring that the user wide aliases remain available in all projects.

Aliases with common options are provided for convenience and to minimize the amount of cognitive load required to remember how to use aliases. Initial inspiration taken from [seancorfield/dot-clojure](https://github.com/seancorfield/dot-clojure).

# Contents

* [Updating practicalli/clojure-deps-edn](#updating-practicalli-clojure-deps-edn)
* [Aliases](#aliases)
    * [REPL experience](#repl-experience) | [Projects](#clojure-projects) | [Java sources](#java-sources) | [Databases](#databases-and-drivers) | [Data Inspectors](#data-inspectors) | [Middleware](#middleware) | [Clojure Spec](#clojure-specification) | [Unit Testing](#unit-testing-frameworks) | [Test runners](#test-runners-and-test-coverage-tools) | [Lint tools](#lint-tools) | [Visualize vars and deps](#visualizing-project-vars-and-library-dependencies) | [Performance testing](#performance-testing)
* [Library repositories](#library-repositories)
* [Experimental](#experimental)

# For use with [Clojure CLI tools version 1.10.1.697](https://clojure.org/guides/getting_started) or above
Check the version of Clojure CLI tools currently installed
```shell
clojure -Sdescribe
```

## Install Clojure CLI tools
Linux Script:
```shell
curl -O https://download.clojure.org/install/linux-install-1.10.1.697.sh
chmod +x linux-install-1.10.1.697.sh
sudo ./linux-install-1.10.1.697.sh
```

Homebrew - MacOSX or Linux:
```shell
brew install clojure/tools/clojure
```

Windows version not currently released.

## Installing Clojure deps.edn
[Fork the practicalli/clojure-deps-edn repository](https://github.com/practicalli/clojure-deps-edn/) and clone your fork to an existing `~/.clojure/` directory (eg. $HOME/.clojure or %HOME%\.clojure).

```shell
git clone your-fork-url ~/.clojure/
```

The configuration from `~/.clojure/deps.edn` is now available for all Clojure CLI projects for that user account.

Any directory containing a `deps.edn` file is considered a Clojure project. A `deps.edn` file can contain an empty hash-map, `{}` or hash-map with configuration.  The project `deps.edn` file is merged with the user wide configuration, with the project `deps.edn` keys taking precedence if there is duplication.

![Clojure CLI tools deps.edn configuration precedence](https://raw.githubusercontent.com/jr0cket/developer-guides/master/clojure/clojure-cli-tools-deps-edn-configuration-precedence.png)

See the rest of this readme for examples of how to use each alias this configuration contains.


## Updating Practicalli clojure-deps-edn
The collection of aliases is regularly reviewed and expanded upon and suggestions are most welcome.

The versions of libraries are manually updated at least once per month using the `:outdated` alias and a new version of the `deps.edn` file pushed to this repository.
```shell
cd ~/.clojure/
clojure -M:project/outdated
```


# Aliases
Aliases provide additional configuration when running a REPL, an application or to use a community tool.

* add or remove dependencies
* add or remove directories on the class path
* define a function or main namespace to run, along with arguments

## Clojure CLI main flag options
| Flag            | Purpose                                                  | Config used                                          |
|-----------------|----------------------------------------------------------|------------------------------------------------------|
| `-M`            | Run Clojure project with clojure.main                    | deps, path, `:main-opts` & command line args         |
| `-P`            | Prepare / dry run (CI servers, Containers)               | deps, path                                           |
| `-P -M:aliases` | Prepare / dry run including alias deps and paths         | deps, path                                           |
| `-P -X:aliases` | Prepare / dry run including alias deps and paths         | deps, path                                           |
| `-X`            | Execute a qualified function, optional default arguments | deps, path, `:exec-fn`, `:exec-args` & :key val args |
| `-J`            | Java Virtual Machine specific options (menory size, etc) |                                                      |

* deps = `:deps`, `:extra-deps`, `replace-deps`
* path = `:path`, `:extra-paths`, `replace-paths`


## REPL experience
[Rebel readline](https://github.com/bhauman/rebel-readline) provides a feature rich REPL experience, far beyond the basic `clojure` and `clj` commands.

* `repl/rebel` - run a Clojure REPL
* `repl/rebel-cljs` - run the default ClojureScript REPL
* `repl/rebel-nrepl` - run rebel REPL with nrepl connection for editor connections (eg. CIDER, Calva)
* `:env/dev` include `dev/` in classpath to [configure REPL startup actions using `dev/user.clj`](http://practicalli.github.io/clojure/clojure-tools/configure-repl-startup.html)

| Command                            | Description                                                                                                    |
|------------------------------------|----------------------------------------------------------------------------------------------------------------|
| `clojure -M:repl/rebel`            | Run a Clojure REPL using Rebel Readline                                                                        |
| `clojure -M:alias:repl/rebel`      | Run a Clojure REPL using Rebel Readline, including deps and path from alias                                    |
| `clojure -M:env/dev:repl/rebel`    | Run a Clojure REPL using Rebel Readline, including deps and path from `:env/dev` alias to configure REPL start |
| `clojure -M:repl/rebel-cljs`       | Run a ClojureScript REPL using Rebel Readline                                                                  |
| `clojure -M:alias:repl/rebel-cljs` | Run a ClojureScript REPL using Rebel Readline, including deps and path from alias                              |

`:repl/help` in the REPL for help and available commands.  `:repl/quit` to close the REPL.


## Clojure Projects
- Create projects from deps, leiningen and boot templates with [clj-new](https://github.com/seancorfield/clj-new)
- Check and update project dependencies
- Package projects as jar and uberjars
- Deploy projects locally and to Clojars

### Create new projects from templates
* `:project/new` - create a new project from a template

Create a new project (via clojure.main - classic approach)
```shell
clojure -M:project/new luminus practicalli/full-stack-app +http-kit +h2 +reagent +auth
```

Create a new project (Edn command line arguments - recommended approach)
| Command                                                                                   | Description                                          |
|-------------------------------------------------------------------------------------------|------------------------------------------------------|
| `clojure -X:project/new`                                                                  | library project called playground                    |
| `clojure -X:project/new :name practicalli/my-library`                                     | library project with given name                      |
| `clojure -X:project/new :template app :name practicalli/my-application`                   | App project with given name                          |
| `clojure -X:project/new :template luminus :name practicalli/full-stack-app +http-kit +h2` | Luminus project with given name and template options |


Run project with or without an alias:
```shell
clojure -M:alias -m domain.app-name
clojure -M -m domain.app-name
```

> The `-M` flag is required even if an alias is not included in the running of the application.  A warning will be displayed if the `-M` option is missing.


## Project dependencies

* [`:project/check`](https://github.com/athos/clj-check.git) - detailed report of compilation errors for a project
* [`:project/outdated`](https://github.com/liquidz/antq) - report newer versions for maven and git dependencies
* [`:project/outdated-mvn`](https://github.com/slipset/deps-ancient) - check for newer dependencies (maven only)

| Command                                              | Description                                               |
|------------------------------------------------------|-----------------------------------------------------------|
| `clojure -M:project/check`                           | detailed report of compilation errors for a project       |
| `clojure -M:project/find-deps library-name`          | fuzzy search Maven & Clojars                              |
| `clojure -M:project/find-deps -F:merge library-name` | fuzzy search Maven & Clojars and save to project deps.edn |
| `clojure -M:project/outdated`                        | report newer versions for maven and git dependencies      |
| `clojure -M:project/outdated-mvn`                    | check for newer dependencies (maven only)                 |


### Project packaging
Build a project archive file for deployment

* [:project/jar](https://github.com/seancorfield/depstar) - build jar for deps.edn project
* [:project/uberjar](https://github.com/seancorfield/depstar) - build uberjars for deps.edn project
* [:project/uberdeps](https://github.com/tonsky/uberdeps) - uberjar builder

| Command                                                  | Description                                                  |
|----------------------------------------------------------|--------------------------------------------------------------|
| `clojure -X:project/jar :main-class domain.app-name`     | package `project.jar` for deps.edn project (publish library) |
| `clojure -X:project/uberjar :main-class domain.app-name` | package `uber.jar` for deps.edn project (deploy application) |

Additionally specify `:jar` name and if ahead of time compilation should be used (default true)

```clojure
clojure -X:project/jar :jar '"practicalli.app.jar"' :aot false :main-class domain.app-name
```


### Project Deployment
Deploy a project archive file locally or to Clojars.org

* [`-X:deps mvn-install`](https://insideclojure.org/2020/09/04/clj-exec/) - built-in Clojure CLI alias to deploy a Jar locally in the `~/.m2/repository` directory
* [:deploy/clojars](https://github.com/slipset/deps-deploy) - deploy jar to [clojars.org](https://clojars.org/)
* [:deploy/clojars-signed](https://github.com/slipset/deps-deploy) - sign and deploy jar to [clojars.org](https://clojars.org/)

| Command                                         | Description                                                              |
|-------------------------------------------------|--------------------------------------------------------------------------|
| `clojure -X:deps mvn-install project.jar`       | [NEW] deploy jar file to local maven repository, i.e. `~/.m2/repository` |
| `clojure -M:project/clojars project.jar`        | deploy jar file to Clojars                                               |
| `clojure -M:project/clojars-signed project.jar` | deploy signed jar file to Clojars                                        |

Set Clojars username/token in `CLOJARS_USERNAME` and `CLOJARS_PASSWORD` environment variables.

Set fully qualified artifact-name and version in project `pom.xml` file

Path to project.jar can also be set in alias to simplify the Clojure command.

> `clojure -X:deps mvn-install project.jar` for local deployment of jars is part of the 1.10.1.697 release of the [Clojure CLI tools](https://clojure.org/guides/getting_started) in September 2020.




## Java Sources
Include Java source on the  classpath to [look up Java Class and method definitions, eg. `cider-find-var` in Emacs](https://practicalli.github.io/spacemacs/navigating-code/java-definitions.html)
Requires: Java sources installed locally (e.g. "/usr/lib/jvm/openjdk-11/lib/src.zip")

* `:lib/java8-source`
* `:lib/java11-source`

Use the aliases with either `-M` or `-X` flags on the Clojure command line.


## Databases and drivers
Databases and drivers, typically for development time inclusion such as embedded databases

* `:database/h2` - H2 embedded database library and next.jdbc

`clojure -M:database/h2` - run a REPL with an embedded H2 database and next.jdbc libraries

https://cljdoc.org/d/seancorfield/next.jdbc/CURRENT/doc/getting-started#create--populate-a-database

Use the aliases with either `-M` or `-X` flags on the Clojure command line.

## Data Inspectors
REPL driven data inspectors and `tap>` sources for visualizing data.


### [Portal](https://github.com/djblue/portal)
Navigate data in the form of edn, json and transit
[Practicalli Clojure -data browsers section - portal](https://practicalli.github.io/clojure/clojure-tools/data-browsers/portal.html)

* `inspect/portal-cli` - Clojure CLI (simplest approach)
* `inspect/portal-web` - Web ClojureScript REPL
* `inspect/portal-node` - node ClojureScript REPL

| Command                          | Description                                            |
|----------------------------------|--------------------------------------------------------|
| `clojure -M:inspect/portal-cli`  | Clojure REPL with Portal dependency                    |
| `clojure -M:inspect/portal-web`  | ClojureScript web browswer REPL with Portal dependency |
| `clojure -M:inspect/portal-node** | ClojureScript node.js REPL with Portal dependency      |

**Using Portal once running**
`(require '[portal.api :as portal])` once the REPL starts.  For `inspect/portal-web` use `(require '[portal.web :as portal])` instead

`(portal/open)` to open the web based inspector window in a browser.

`(portal/tap) `to add portal as a tap target (add-tap)

`(tap> {:accounts [{:name "jen" :email "jen@jen.com"} {:name "sara" :email "sara@sara.com"}]})` to send data to the portal inspector window (or any other data you wish to send)

`(portal/clear)` to clear all values from the portal inspector window.

`(portal/close)` to close the inspector window.


### [Reveal](https://vlaaad.github.io/reveal/) is a repl and data visualization tool
Reveal - read evaluate visualize loop.  A REPL with data visualisation.  Also used as a tap> source

* `inspector/reveal` - repl and data visualization tool
* `inspector/reveal-nrepl` - repl and data visualization tool with nrepl server, for connection from [Clojure aware editors](https://practicalli.github.io/clojure/clojure-editors/)

| Command                                      | Description                                                                        |
|----------------------------------------------|------------------------------------------------------------------------------------|
| `clojure -M:inspect/reveal`                  | start a Reveal repl with data visualization window (cloure.main)                   |
| `clojure -M:inspect/reveal-light`            | as above with light theme and large font                                           |
| `clojure -X:inspect/reveal`                  | start a Reveal repl with data visualization window (clojure exec)                  |
| `clojure -X:inspect/reveal-light`            | as above with light theme and large font                                           |
| `clojure -M:inspect/reveal:repl/rebel`       | Start a Rebel REPL with Reveal dependency. Add reveal as tap> source               |
| `clojure -M:inspect/reveal-light:repl/rebel` | Start a Rebel REPL with Reveal dependency & light theme. Add reveal as tap> source |

**Running different types of repl**

Using Clojure exec `-X` flag, the default repl function can be over-ridden on the command line, supplying the `io-prepl` or `remote-prepl` functions.

* `clojure -X:inspect/reveal io-prepl :title '"I am a prepl repl"`
* `clojure -X:inspect/reveal remote-prepl :title '"I am a remote prepl repl"'`

**Configure theme & font**

Add a custom theme and font via the `-J` command line option or create an alias using `:insepct/reveal-light` as an example.

```shell
clojure -M:inspect/reveal -J-Dvlaaad.reveal.prefs='{:theme :light :font-family "Ubuntu Mono" :font-size 32}'
```

**Rebel Readline & Reveal: Add Reveal as tap> source**

Evaluate `(add-tap ((requiring-resolve 'vlaaad.reveal/ui)))` when using Rebel Readline to add Reveal as a tap source, showing `(tap> ,,,)` expressions in the reveal window, eg. `(tap> (map inc [1 2 3 4 5]))`.

[Practicalli Clojure - data browsers section](http://practicalli.github.io/clojure/clojure-tools/data-browsers/reveal.html) has more details on using reveal.


### Cognitect REBL
Visualize the results of each evaluation in the REPL in the REBL UI.  Navigate through complex data structures.

* `inspect/rebl` - REBL, a visual data explorer (Java 11)
* `inspect/rebl-java8` - REBL, a visual data explorer (Oracle Java 8)

| Command                                                    | Description                                       |
|------------------------------------------------------------|---------------------------------------------------|
| `clojure -M:inspect/rebl`                                  | Start REBL REPL and UI (Java 11)                  |
| `clojure -M:inspect/rebl-java8`                            | REBL REPL and UI  (Java 8)                        |
| `clojure -M:lib/cider-nrepl:inspect/rebl:middleware/nrebl` | REBL REPL and UI with nREPL server (CIDER, Calva) |



## Middleware
Aliases for libraries that combine community tools and REPL protocols (nREPL, SocketREPL).

Run a REPL on the command line for access by `cider-connect-` commands, providing the require cider middleware libraries that are auto-injected in `ccider-jack-in-` commands.

### nREPL
* `:middleware/nrepl` - Clojure REPL with an nREPL server
* `:middleware/cider-clj` - Clojure REPL with nREPL server and CIDER dependencies for `cider-connect-clj`
* `:middleware/cider-cljs` - ClojureScript REPL with nREPL server and CIDER dependencies for `cider-connect-cljs`

Use the aliases with either `-M` or `-X` flags on the Clojure command line.

| Command                             | Description                                                                           |
|-------------------------------------|---------------------------------------------------------------------------------------|
| `clojure -M::middleware/nrepl`      | Run a Clojure REPL that includes nREPL server                                         |
| `clojure -M::middleware/cider-clj`  | Run a Clojure REPL that includes nREPL server and CIDER connection dependencies       |
| `clojure -M::middleware/cider-cljs` | Run a ClojureScript REPL that includes nREPL server and CIDER connection dependencies |



### Cognitect REBL with CIDER
Run the REBL REPL with nREPL server so CIDER can connect.

* `:middleware/nrebl` - REBL data browser on nREPL connection
* `:lib/cider-nrepl` - include nrepl, cider-nrepl and refactor-nrepl library dependencies (support `:inspect/nrebl` alias)

In a terminal, run REBL listening to nREPL using the command
```shell
clojure -M:lib/cider-nrepl:inspect/rebl:middleware/nrebl
```

`cider-connect-clj` in Spacemacs / Emacs and CIDER successfully connects to the nREPL port and evaluated code is sent to REBL.


To start a REBL REPL from `cider-jack-in-clj` add a `.dir-locals.el` file to the root of a Clojure project. The `.dir-locals.el` configuration adds the nREBL aliases set via `cider-clojure-cli-global-options` and all other automatically injected configuration is disabled (to prevent those dependencies over-riding the nREBL aliases).
```
((clojure-mode . ((cider-preferred-build-tool . clojure-cli)
                  (cider-clojure-cli-global-options . "-M:lib/cider-nrepl:inspect/rebl:middleware/nrebl")
                  (cider-jack-in-dependencies . nil)
                  (cider-jack-in-nrepl-middlewares . nil)
                  (cider-jack-in-lein-plugins . nil)
                  (cider-clojure-cli-parameters . ""))))
```
* [REBL data visualization: run REBL with nREPL based editors](http://practicalli.github.io/clojure/clojure-tools/data-browsers/rebl-data-visualization.html#run-rebl-for-nrepl-based-editors)


## Clojure Specification
Clojure spec, generators and test.check

* `:lib/spec-test` - generative testing with Clojure test.check
* `:lib/spec2` - experiment with the next version of Clojure spec - alpha: design may change


## Unit Testing frameworks
Unit test libraries and configuration.  The Clojure standard library includes the `clojure.test` namespace, so no alias is required.

* `:env/test` - add `test` directory to classpath
* [`:lib/expectations`](https://github.com/clojure-expectations/clojure-test) - `clojure.test` with expectations
* [`:lib/expectations-classic`](https://github.com/clojure-expectations/expectations) - expectations framework

Use expectations in a project `clojure -A:test:expectations` or from the command line with cognitect test runner `clojure -A:expectations:test-runner-cognitect`


## Test runners and Test Coverage tools
Tools to run unit tests in a project which are defined under `test` path.

Run clojure with the specific test runner alias: `clojure -A:test-runner-alias`

* [`:test/cognitect`](https://github.com/cognitect-labs/test-runner) - Cognitect test-runner
* [`:test/cljs`](https://github.com/Olical/cljs-test-runner) - test runner for Clojure/Script
* [`:test/kaocha`](https://github.com/lambdaisland/kaocha) - comprehensive test runner for Clojure
* [`:test/kaocha-cljs`](https://github.com/lambdaisland/kaocha) - comprehensive test runner for ClojureScript
* [`:test/kaocha-cucumber`](https://github.com/lambdaisland/kaocha-cucumber) - comprehensive test runner with BDD Cucumber tests
* [`:test/kaocha-junit-xml`](https://github.com/lambdaisland/kaocha) - comprehensive test runner with Junit XML reporting for CI dashboards and wallboards
* [`:test-runner/kaocha-cljs`](https://github.com/lambdaisland/kaocha) - comprehensive test runner with test coverage
* [`:test-runner/midje`	](https://github.com/miorimmax/midje-runner) - runner for midje and clojure.test tests
* [`:test-runner/eftest`](https://github.com/weavejester/eftest) - fast and pretty test runner
* [:test-runner/coverage](https://github.com/cloverage/cloverage) - simple clojure coverage tool for `clojure.test` defined unit tests.

| Command                            | Description                                                                       |
|------------------------------------|-----------------------------------------------------------------------------------|
| `clojure -M:test/cognitect`        | Cognitect Clojure test runner                                                     |
| `clojure -M:test/cljs`             | ClojureScript test runner (Olical)                                                |
| `clojure -M:test/runner`           | Kaocha - comprehensive test runner for Clojure (same as :test/kaocha)             |
| `clojure -M:test/kaocha`           | Kaocha - comprehensive test runner for Clojure                                    |
| `clojure -M:test/kaocha-cljs`      | Kaocha - comprehensive test runner for ClojureScript                              |
| `clojure -M:test/kaocha-cucumber`  | Kaocha - comprehensive test runner with BDD Cucumber tests                        |
| `clojure -M:test/kaocha-junit-xml` | Kaocha - comprehensive test runner with Junit XML reporting for CI dashboards & wallboards |
| `clojure -M:test/kaocha-cloverage` | Kaocha - comprehensive test runner with test coverage reporting                   |
| `clojure -M:test/midje`            | Midje test runner for BDD style tests                                             |
| `clojure -M:test/eftest`           | Fast Clojure test runner, pretty output, parallel tests                           |
| `clojure -M:test/coverage`         | Cloverage clojure.test coverage report                                            |


## Lint tools
Static analysis tools to help maintain code quality and suggest Clojure idioms.

* [`:lint/kondo`](https://github.com/borkdude/clj-kondo/) - comprehensive and fast static analysis lint tool
* [`:lint/eastwood`](https://github.com/jonase/eastwood) - classic lint tool for Clojure
* [`:lint/idiom-check`](https://github.com/jonase/kibit) - checking for idiomatic Clojure code with Kibit

| Command                    | Description                                      |
|----------------------------|--------------------------------------------------|
| `clojure -M:lint/kondo`    | comprehensive and fast static analysis lint tool |
| `clojure -M:lint/eastwood` | classic lint tool for Clojure                    |
| `clojure -M:lint/idiom`    | Suggest idiomatic Clojure code                   |


## Visualizing project vars and library dependencies
Create [Graphviz](https://www.graphviz.org/) graphs of project and library dependencies

Morpheus creates grahps of project vars and their relationships

* [`:graph/vars`](https://github.com/benedekfazekas/morpheus) - generate graph of vars in a project as a .dot file
* [`:graph/vars-png`](https://github.com/benedekfazekas/morpheus) - generate graph of vars in a project as a .png file using `src` and `test` paths
* [`:graph/vars-svg`](https://github.com/benedekfazekas/morpheus) - generate graph of vars in a project as a .svg file using `src` and `test` paths

> Install [Graphviz](https://www.graphviz.org/) to generate PNG and SVG images.  Or use the [Edotor website](https://edotor.net/) to convert .dot files to PNG or SVG images and select different graph layout engines.


[Vizns](https://github.com/SevereOverfl0w/vizns) creates graphs of relationships between library dependencies and project namespaces

* `:graph/deps`
* `:graph/deps-png` - generate a single deps-graph png image

Other options:
* `clojure -M:graph/deps navigate`  # navigable folder of SVGs
* `clojure -M:graph/deps single`    # deps-graph.dot file
* `clojure -M:graph/deps single -o deps-graph.png -f png`
* `clojure -M:graph/deps single -o deps-graph.svg -f svg`
* `clojure -M:graph/deps single --show `  # View graph without saving



## Performance testing
Performance testing tools for the REPL

* [:performance/benchmark](https://github.com/hugoduncan/criterium/)

Use the aliases with either `-M` or `-X` flags on the Clojure command line.

TODO: check these alias combinations are correct
```
clojure -M:performance/benchmark:repl/rebel

(require '[criterium.core :refer [bench quick-bench]])
(bench (adhoc-expression))
```


TODO: check these alias combinations are correct
Performance test a project in the REPL
```
clojure -M:performance/benchmark:repl/rebel

(require '[practicalli/namespace-name]) ; require project code
(in-ns 'practicalli/namespace-name)
(quick-bench (project-function args))
```


*  [:performance/memory-meter](https://github.com/clojure-goes-fast/clj-memory-meter) - memory usage

Use the aliases with either `-M` or `-X` flags on the Clojure command line.

In the REPL:
```
  (require '[clj-memory-meter.core :as memory-meter])
   (memory-meter/measure (your-expression))
```

## Experimental / Alpha Aliases

* [`:alpha/carve`](https://github.com/borkdude/carve) - EXPERIMENTAL, use with caution - carve out unwanted vars in code
* [`:alpha/hot-load`](https://github.com/clojure/tools.deps.alpha) - EXPERIMENTAL, use with caution - hot-load libraries into a running namespace.


**Hot loading dependencies** (unofficial - changes planned already)
> This is a very unofficial approach to hot loading and the design may change quite soon, so this alias is likely to break without notice.  Do not rely on this alias working and use with caution.

* [`:project/hotload-dep`](https://github.com/clojure/tools.deps.alpha) - Add jar dependencies into a running REPL.

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


# Library repositories
Repositories that host libraries for Clojure.

`central` and `clojars` are the man repositories for Clojure development are consulted in order.

`central` and `clojars` repos can be removed from consideration by setting their configuration hash-map to `nil` in `~/.clojure/deps.edn`.  For example, `{:mvn/repos {"central" nil}}`.

The order of additional repositories consulted is not guaranteed, so may cause unpredictable side effects in the project build especially if `RELEASE` or `LATEST` tags are used rather than a numeric library version.



Maven supports [explicit mirror definition](http://maven.apache.org/guides/mini/guide-mirror-settings.html) in `~/.m2/settings.xml` and Clojure CLI tools(tools.deps) supports this configuration.  Adding Maven Central or a mirror to  `~/.m2/settings.xml` negates the need for its entry in deps.edn configuration.

**Recommended repositories**
* `central` - Maven Central, the canonical repository for JVM libraries, including Clojure releases
* `clojars` - clojars.org, the canonical repositories for Clojure community libraries fronted by a contend delivery network service, https://repo.clojars.org/

**Optional repositories**
* `sonatype` - snapshots of Clojure development releases, useful for testing against before new stable releases.
* `jcenter` - the largest mirror of all open source libraries (useful as a backup or accessing through corporate firewalls)
* `business-area` - example of adding a local Artifactory server for your team or business area.
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
