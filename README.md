# Practicalli Clojure CLI Config

```none
██████╗ ██████╗  █████╗  ██████╗████████╗██╗ ██████╗ █████╗ ██╗     ██╗     ██╗
██╔══██╗██╔══██╗██╔══██╗██╔════╝╚══██╔══╝██║██╔════╝██╔══██╗██║     ██║     ██║
██████╔╝██████╔╝███████║██║        ██║   ██║██║     ███████║██║     ██║     ██║
██╔═══╝ ██╔══██╗██╔══██║██║        ██║   ██║██║     ██╔══██║██║     ██║     ██║
██║     ██║  ██║██║  ██║╚██████╗   ██║   ██║╚██████╗██║  ██║███████╗███████╗██║
╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝   ╚═╝   ╚═╝ ╚═════╝╚═╝  ╚═╝╚══════╝╚══════╝╚═╝
```

[Practicalli Clojure CLI Config](https://github.com/practicalli/clojure-cli-config/) provides a user scope `deps.edn` file containing alias definitions for a wide range of community libraries and tools to that extend the features of Clojure CLI.

Aliases are qualified keywords using descriptive names to clearly convey purpose and provide a level of consistency to minimise cognitive load.

Common arguments are included in alias definitions via `main-opts` and `:exec-args` to provide a default behaviour and simplify the use aliases.

Alias  used with the `-A`, `-M`, `-T` or `-X` execution options

Aliases are defined to be used with all execution options `-A`, `-M`, `-P`, `-T` or `-X` where possible, otherwise use the following execution options:

* `-M` for `:main-opts` configuration
* `-X` for `:exec-opts` configuration
* `-T` for `:exec-opts`, ignoring project dependencies

> [Clojure CLI - Which execution options to use](https://practical.li/clojure/clojure-cli/execution-options/)

The project also contains

* GitHub workflow that runs MegaLinter and Code Quality checks (clj-kondo and cljstyle via the setup-clojure action)
* cljstyle configuration that follows the Clojure Style Guide
* Rebel Readline example configuration (supports the Rich Terminal UI used by Practicalli)
* cspell configuration for linting markdown and other text
* `deps-deprecated.edn` containing alias examples of tools not currently used by Practialli which may still be of interest to the wider community

[Practicalli books](https://practical.li/#books) uses the Clojure CLI Config extensively to support a [REPL Reloaded workflow](https://practical.li/clojure/clojure-cli/repl-reloaded/) for Clojure projects.

[Practicalli Clojure book discusses Clojure CLI and its use](https://practical.li/clojure/clojure-cli/repl/), along with video walk-through of the key features.

[Practicalli Clojure CLI logo](https://github.com/practicalli/graphic-design/blob/live/logos/practicalli-clojure-cli-logo.png?raw=true)


[![License CC By SA 4.0](https://img.shields.io/badge/license-CC%20BY--SA%204.0%20-blueviolet)](http://creativecommons.org/licenses/by-sa/4.0/?ref=chooser-v1)
[![GitHub Sponsors for practicalli-john](https://img.shields.io/github/sponsors/practicalli-johnny)](https://github.com/sponsors/practicalli-johnny)
[![Quality Checks](https://github.com/practicalli/clojure-cli-config/actions/workflows/quality-checks.yaml/badge.svg)](https://github.com/practicalli/clojure-cli-config/actions/workflows/quality-checks.yaml)
[![MegaLinter](https://github.com/practicalli/clojure-cli-config/actions/workflows/megalinter.yaml/badge.svg)](https://github.com/practicalli/clojure-cli-config/actions/workflows/megalinter.yaml)

<div style="width:95%; margin:auto;">
  <a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-sa/4.0/88x31.png" /></a>
  Creative Commons Attribution 4.0 ShareAlike License
</div>


## Format Clojure

[cljstyle](https://github.com/greglook/cljstyle) is a format tool for Clojure files that supports the Clojure Style Guide, using the [.cljstyle configuration file](https://github.com/practicalli/clojure-cli-config/blob/main/.cljstyle)


## Contents

* [Install Practicalli Clojure CLI Config](#install-practicalli-clojure-cli-config)
* [Updating practicalli/clojure-cli-config](#update-practicalli-clojure-cli-config)
* [Common development tasks](#common-development-tasks)
* [REPL Terminal UI](#repl-terminal-ui) I
  * [Hotload dependencies](#hotload-libraries) I [Remote REPL Connection](#remote-repl-connection) I [Socket REPL](#socket-repl)
* [Development Environment](#development-environment)
* [Clojure Projects](#clojure-projects)
  * [Dependencies](#project-dependencies) I [Analysis](#project-analysis) I [Packaging](#project-packaging) I [Deployment](#project-deployment)
  * [Searching](#searching)
  * [Format](#format-code) I [Lint](#lint-tools)
  * [Java sources](#java-sources)
* [Testing](#unit-testing-frameworks)
  * [Test runners](#test-runners-and-test-coverage-tools) I [Clojure Spec](#clojure-specification) I [Performance](#performance-testing) I [Security](#security)
* [Databases](#databases-and-drivers)
* [Data Inspectors](#data-inspectors)
  * [Visualise vars and deps](#visualising-project-vars-and-library-dependencies)
* [Debug](#debug-tools)
* [Services](#services)
* [Library Hosting Services](#library-hosting-services) - maven mirrors, local repositories


## Install Practicalli Clojure CLI Config

[Clojure CLI](https://clojure.org/guides/install_clojure) version **1.11.1.xxxx** or later is recommended. Check the version of Clojure CLI currently installed via:

```shell
clojure --version
```

> [Practicalli guide to installing Clojure](https://practical.li/clojure/install/clojure-cli/) has detailed instructions to install Clojure CLI for a specific operating system, or follow the [Clojure.org Getting Started page](https://clojure.org/guides/getting_started).

When Clojure CLI runs for the first time a configuration directory is created in `$XDG_CONFIG_HOME/clojure` or `$HOME/.clojure` if [XDG_CONFIG_HOME](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html "FreeDesktop.org specification") not set

> Practicalli recommends setting `$XDG_CONFIG_HOME` to `$HOME/.config`

Backup or delete the Clojure CLI configuration directory if it exists

Clone [practicalli/clojure-cli-config](https://github.com/practicalli/clojure-cli-config) repository (or create a fork and clone that instead)

```shell
git clone git@github.com:practicalli/clojure-cli-config.git $XDG_CONFIG_HOME/clojure
```

> If $XDG_CONFIG_HOME not set, then use `git clone git@github.com:practicalli/clojure-cli-config.git $HOME/.clojure`

The `deps.edn` file in the Clojure CLI configuration directory contains all the Practicalli aliases, which are available from any Clojure CLI project for the current user account.

> Windows support:  Windows Sub-system for Linux (WSL) is strongly encouraged.  Aliases should also work on Powershell or cmd.exe, although [escape quoting of additional arguments](https://clojure.org/reference/deps_and_cli#quoting) may be required.


### Location of local Maven repository

`$HOME/.m2/repository` is the default location of the local maven repository, the directory where library dependency jar files are cached.

`:mvn/local-repo` is a top-level key to set the local maven repository location, such as `/home/practicalli/.cache/maven/repository` to follow the XDG specification.  If setting `:mvn/local-repository`, consider moving the contents of `$HOME/.m2/repository` to the new location to avoid downloading currently cached jar files (or use this as an opportunity to clear out the cache).


### Update Practicalli Clojure CLI Config

The collection of aliases is regularly reviewed and additional alias suggestions and PRs are most welcome.

The versions of libraries are updated at least once per month using the `:project/outdated` alias, updating the `deps.edn` file.  The [antq tool](https://github.com/liquidz/antq) is used to report new library versions, sent to an org file which is then used to update the changelog.

```shell
cd $XDG_CONFIG_HOME/clojure
clojure -T:search/outdated > outdated.org
```

> Pull Requests from `:search/outdated` cannot be accepted unless full testing of every change can be demonstrated


## Using Practicalli Clojure CLI Config

Any directory containing a `deps.edn` file is considered a Clojure project. A `deps.edn` file can contain an empty hash-map, `{}` or hash-map with configuration, usually `:paths` and `:dependencies` and perhaps some `:aliases`.

The project `deps.edn` file is merged with the user wide configuration, e.g `$HOME/.clojure/deps.edn`, with the project `deps.edn` keys taking precedence if there is duplication, otherwise they are merged.

Configuration passed via the command line when running `clojure` or the `clj` wrapper will take precedence over the project and user level configuration if there is duplication, otherwise they are merged.

![Clojure CLI tools deps.edn configuration precedence](https://raw.githubusercontent.com/practicalli/graphic-design/live/clojure/clojure-cli/clojure-cli-configuration-precedence.png)

See the rest of this readme for examples of how to use each alias this configuration contains.


## Common development tasks

How to run common tasks for Clojure development.

* Built-in: tasks provided by Clojure CLI
* Practicalli: aliases provided by Practicalli Clojure CLI Config

| Task                                               | Command                                                  | Configuration |
|----------------------------------------------------|----------------------------------------------------------|---------------|
| Create minimal playground project                  | `clojure -T:project/create`                              | Practicalli   |
| Clojure REPL - rebel readline & nrepl server       | `clojure -M:repl/rebel`                                  | Practicalli   |
| ClojureScript REPL with nREPL server               | `clojure -M:repl/cljs`                                   | Practicalli   |
| Run tests / watch for changes                      | `clojure -X:test/run` / `clojure -X:test/watch`          | Practicalli   |
| Run the project  (clojure.main)                    | `clojure -M -m domain.main-namespace`                    | Built-in      |
| Check library dependencies for newer versions      | `clojure -T:search/outdated`                             | Practicalli   |
| Download dependencies                              | `clojure -P`  (followed by optional aliases)             | Built-in      |
| Generate image of project dependency graph         | `clojure -T:project/graph-deps`                          | Practicalli   |
| Deploy library locally (~/.m2/repository)          | `clojure -X:deps mvn-install :jar '"project.jar"'`       | Built-in      |
| Find library names (Clojars & Maven Central)       | `clojure -M:search/libraries qualified-library-names`    | Practicalli   |
| Find available versions of a library               | `clojure -X:deps find-versions :lib domain/library-name` | Built-in      |
| Resolve git coord tags to shas and update deps.edn | `clojure -X:deps git-resolve-tags git-coord-tag`         | Built-in      |


## REPL terminal UI

Run an interactive REPL on the command line with the basic built-in REPL UI or [Rebel](https://practical.li/clojure/clojure-cli/repl/) for a feature rich REPL experience.

nREPL server is started for all Clojure repl aliases along with the cider-nrepl middleware, so Clojure editors can connect to the REPL process started on the command line.

| Command                        | Description                                                                        |
|--------------------------------|------------------------------------------------------------------------------------|
| `clojure -M:repl/rebel`        | Rebel Rich terminal UI Clojure REPL with nREPL for connecting editors              |
| `clojure -M:repl/basic`        | Basic terminal UI Clojure REPL with nREPL for connecting editors                   |
| `clojure -M:repl/reloaded`     | As above with `dev` path, library hotload, namespace reload, Portal data inspector |
| `clojure -M:repl/cljs`         | Basic terminal UI ClojureScript REPL using Rebel Readline                          |
| `clojure -M:repl/rebel-cljs`   | Rich terminal UI ClojureScript REPL using Rebel Readline                           |
| `clojure -M:repl/figwheel`     | Rich terminal UI ClojureScript REPL using Rebel Readline with Figwheel built tool  |
| `clojure -M:repl/headless`     | REPL without prompt, include nREPL for connecting editors                          |
| `clojure -M:repl/rebel-remote` | Connect to a remote REPL via nREPL with Rebel Rich terminal UI                     |
| `clojure -M:repl/remote`       | As above with basic prompt                                                         |

> Use `:env/dev`  with the `:repl/rebel` aliases to include `dev/` in classpath and [configure REPL startup actions using `dev/user.clj`](https://practical.li/clojure/clojure-cli/repl-startup/)

## Hotload Libraries

`clojure -M:repl/reloaded` provides common tools to [enhance the REPL workflow](https://practical.li/clojure/clojure-cli/repl-reloaded/) (hotload libraries, refresh code changes, inspect data, advanced test runner, log & trace)

Use `:dev/reloaded` with Editor jack-in commands or other aliases to start a REPL process, e.g. `clj -M:dev/reloaded:repl/basic` for a reloaded REPL workflow with a basic terminal REPL prompt.


### Remote REPL connection

Connect to the nREPL server of a remote REPL using nREPL connect, using a simple terminal UI

```shell
clojure -M:repl/remote --host hostname --port 12345
```

As above but using the enhanced Rebel Readline UI

```shell
clojure -M:repl/rebel-remote --host hostname --port 12345
```


## Socket REPL

Clojure 1.10.x onward can [run a Socket Server](https://clojure.org/reference/repl_and_main#_launching_a_socket_server) for serving a socket-based REPL (Clojure and ClojureScript).

[tubular](https://github.com/mfikes/tubular) is a Socket Server client for Clojure and Clojurescript REPL processes.

| Command                          | Description                                                                     |
|----------------------------------|---------------------------------------------------------------------------------|
| `clojure -M:repl/socket`         | Clojure REPL using Socket Server on port 50505                                  |
| `clojure -M:repl/socket-zero`    | As above but on first available port (container, cloud environment)             |
| `clojure -M:repl/socket-zero -r` | As above but and run a REPL                                                     |
| `clojure -M:repl/socket-node`    | ClojureScript REPL using Socket Server on port 55555                            |
| `clojure -M:repl/socket-browser` | ClojureScript REPL using Socket Server on port 58585                            |
| `clojure -M:repl/socket-client`  | Socket REPL client on port 50505 ([tubular](https://github.com/mfikes/tubular)) |


## Development Environment

Environment settings and libraries to support REPL driven development

* `:env/dev` - add `dev` directory to class path - e.g. include `dev/user.clj` to [configure REPL startup](https://practical.li/clojure/clojure-cli/repl-startup/)
* `:dev/reloaded` - reloaded workflow, `dev` and `test` paths, testing libraries
* `:lib/hotload` - include `org.clojure/tools.deps.alpha` add-libs commit to [hotload libraries into a running REPL](https://practical.li/clojure/clojure-cli/repl-reloaded/)
* `:lib/tools-ns` - include `org.clojure/tools.namespace` to refresh the current namespace in a running REPL
* `:lib/reloaded` - combination of hotload and tools-ns aliases
* `:lib/pretty-errors` - highlight important aspects of error stack trace using ANSI formatting


## Clojure Projects

Create Clojure CLI configured projects, either built-in or [practicalli/project-templates](https://github.com/practicalli/project-templates) to provide [REPL Reloaded tools](https://practical.li/clojure/clojure-cli/repl-reloaded/) and production-level CI workflows.

Default values (can be over-ridden on the command line)

* `:template project/application` template, includes REPL Reloaded workflow, GitHub workflows, Dockerfile & compose.yaml, Makefile tasks
* `:name practicalli/playground` creates a practicalli domain containing `playground` namespace and example Clojure code

| Command                                                         | Description                               |
|-----------------------------------------------------------------|-------------------------------------------|
| `clojure -T:project/create :template app :name domain/app-name` | A simple application                      |
| `clojure -T:project/create`                                     | Practicalli application called playground |
| `clojure -T:project/create :template practicalli/service`       | Practicalli Service called playground     |


> `:project/new` uses [clj-new](https://github.com/seancorfield/clj-new) which is an archived project, although can still be used to create projects using Leiningen style templates.  A Clojure CLI configuration must be manually added if these templates do not provide one.

| Command                                                                                                 | Description                                          |
|---------------------------------------------------------------------------------------------------------|------------------------------------------------------|
| `clojure -T:project/new :template app :name practicalli/my-application`                                 | App project with given name                          |
| `clojure -T:project/new :template luminus :name practicalli/full-stack-app :args '["+http-kit" "+h2"]'` | Luminus project with given name and template options |
| `clojure -T:project/new :template figwheel-main :name practicalli/landing-page :args '["--reagent"]'`   | ClojureScript Figwheel-main project with reagent     |


### Running projects

Run project using clojure.main with or without an alias:

```shell
clojure -M:alias-name -m domain.app-name
clojure -M -m domain.app-name
```

> The `-M` flag specified running the Clojure code with clojure.main library, so `-M'` is required even if an alias is not included in the running of the application.  A warning will be displayed if the `-M` option is missing.

In the project deps.edn file it could be useful to define an alias to run the project, specifying the main namespace, the function to run and optionally any default arguments that are passed to that function.

```clojure
:project/run
{:ns-default domain.main-namespace
 :exec-fn -main
 :exec-args {:port 8888}}
```

Then the project can be run using `clojure -X:project/run` and arguments can optionally be included in this command line, to complement or replace any default arguments in `exec-args`.

## Project dependencies

* [`:project/check`](https://github.com/athos/clj-check.git) - detailed report of compilation errors for a project
* [`:project/graph-deps`](https://github.com/clojure/tools.deps.graph) - graph of project dependencies (png image)
* [`:search/libraries`](https://github.com/hagmonk/find-deps) - fuzzy search for libraries to add as dependencies
* [`:search/outdated`](https://github.com/liquidz/antq) - report newer versions for maven and git dependencies
* [`:search/outdated-mvn`](https://github.com/slipset/deps-ancient) - check for newer dependencies (maven only)

| Command                                            | Description                                               |
|----------------------------------------------------|-----------------------------------------------------------|
| `clojure -M:project/check`                         | detailed report of compilation errors for a project       |
| `clojure -M:search/libraries library-name`         | fuzzy search Maven & Clojars                              |
| `clojure -M:search/libraries -F:save library-name` | fuzzy search Maven & Clojars and save to project deps.edn |
| `clojure -T:search/outdated`                       | report newer versions for maven and git dependencies      |
| `clojure -M:search/outdated-mvn`                   | check for newer dependencies (maven only)                 |

> `:search/libraries` will show warnings about unqualified libraries the first time it is used, which can safely be ignored


## Project analysis

[Carve](https://github.com/borkdude/carve) - static analysis of code
(clj-kondo) and remove or report unused vars

* [`:project/carve`](https://github.com/borkdude/carve.git) - remove / report unused vars
* [`:project/unused`](https://github.com/borkdude/carve.git) - alternative alias name for :project/carve
* [`:project/unused-vars`](https://github.com/borkdude/carve.git) - alternative alias name for :project/carve

| Command                                                                              | Description                                    |
|--------------------------------------------------------------------------------------|------------------------------------------------|
| `clojure -M:project/unused --opts '{:paths ["src" "test"]}'`                         | remove unused vars from the src and test paths |
| `clojure -M:project/unused --opts '{:paths ["src" "test"] :report {:format :text}}'` | report unused vars from the src and test paths |

Generate report in a file:

```shell
clojure -M:project/unused --opts '{:paths ["src" "test"] :report {:format :ignore}}' > .carve/ignore
```

### Project packaging

[tools.build](https://practical.li/clojure/clojure-cli/projects/tools-build/) is a library for creating scripts to manage packaging the projects to a fine level of control.  Projects start with common tasks for builind a jar or uberjar from the project.


### Project Deployment

Deploy a library jar locally  using the built-in `:deps` alias of Clojure CLI or to Clojars.org using [slipset/deps-deploy](https://github.com/slipset/deps-deploy) project.

* [`-X:deps mvn-install`](https://clojure.org/reference/deps_and_cli#_local_maven_install) built-in Clojure CLI alias to deploy a Jar locally in the `~/.m2/repository` directory
* [:deploy/clojars](https://github.com/slipset/deps-deploy) - deploy jar to [clojars.org](https://clojars.org/)
* [:deploy/clojars-signed](https://github.com/slipset/deps-deploy) - sign and deploy jar to [clojars.org](https://clojars.org/)

| Command                                            | Description                                                        |
|----------------------------------------------------|--------------------------------------------------------------------|
| `clojure -X:deps mvn-install :jar '"project.jar"'` | deploy jar file to local maven repository, i.e. `~/.m2/repository` |
| `clojure -M:project/clojars project.jar`           | deploy jar file to Clojars                                         |
| `clojure -M:project/clojars-signed project.jar`    | deploy signed jar file to Clojars                                  |

Set Clojars username/token in `CLOJARS_USERNAME` and `CLOJARS_PASSWORD` environment variables.

Set fully qualified artifact-name and version in project `pom.xml` file

Path to project.jar can also be set in alias to simplify the Clojure command.

> `clojure -X:deps mvn-install :jar '"project.jar"'` for [local deployment of jars](https://clojure.org/reference/deps_and_cli#_local_maven_install) is part of the 1.10.1.697 release of the [Clojure CLI](https://clojure.org/guides/getting_started) in September 2020.


## Searching

Tools to search through code and libraries

* `-M:search/errors` [clj-check](https://github.com/athos/clj-check.git) - search each namespace and report compilation warnings and errors
* `-M::search/unused-vars` [Carve](https://github.com/borkdude/carve) - search code for unused vars and remove them - optionally specifying paths `--opts '{:paths ["src" "test"]}'`
* `-M:search/libraries` - [find-deps](https://github.com/hagmonk/find-deps) - fuzzy search Maven & Clojars and add deps to deps.edn
* `-T:search/outdated` -  [liquidz/antq](https://github.com/liquidz/antq) - check for newer versions of libraries, updating `deps.edn` if `:upgrade true` passed as argument


### Searching library options

A fuzzy search for a library by name, passing multiple names to search for

```bash
clojure -M:search/libraries http-kit ring compojure
```

Add the matching library as a dependency into the project `deps.edn` file

clojure -M:search/libraries --format:merge http-kit


## Format code

* `:lib/pprint-sorted` - pretty printing with sorted keys and set values
* `:format/cljstyle` - check format of all Clojure, Edn and ClojureScript files in the project or a given file and show a diff of format changes
* `:format/cljstyle!` - automatically correct format of all Clojure, Edn and ClojureScript files in the project or a given file
* `:format/zprint` - check format of Clojure code and Edn data structures in the given file, or use file pattern `**/*.clj **/*.edn`
* `:format/zprint!` - format Clojure code and Edn data structures in the given file, or use file pattern `**/*.clj **/*.edn`
* `:format/cljfmt` - check clojure code and Edn data structures in the given file(s) using cljfmt
* `:format/cljfmt!` - format clojure code and Edn data structures in the given file(s) using cljfmt

## Java Sources

Include Java source on the  classpath to [look up Java Class and method definitions, eg. `cider-find-var` in Emacs](https://practical.li/spacemacs/navigating-code/java-definitions/)

Requires: Java sources installed locally (e.g. `"/usr/lib/jvm/openjdk-17/lib/src.zip"`)

* `:src/java17`
* `:src/clojure`

Use the aliases with either `-A`, `-M` or `-X` execution options on the Clojure command line.

> Clone [clojure/clojure](https://github.com/clojure-expectations/clojure-test) repository. Clojure core Java source code in [src/jvm/clojure/lang/](https://github.com/clojure/clojure/tree/master/src/jvm/clojure/lang "GitHub: Clojure core Java source code")


## Databases and drivers

Databases and drivers, typically for development time inclusion such as embedded databases

* `:database/h2` - H2 embedded database library and next.jdbc

`clojure -M:database/h2` - [run a REPL with an embedded H2 database and next.jdbc libraries](https://cljdoc.org/d/seancorfield/next.jdbc/CURRENT/doc/getting-started#create--populate-a-database)

Use the aliases with either `-M` or `-X` flags on the Clojure command line.

## Data Inspectors

REPL driven data inspectors and `tap>` sources for visualising data.

### [Portal](https://github.com/djblue/portal)

Navigate data in the form of edn, json and transit
[Practicalli Clojure -data browsers section - portal](https://practical.li/clojure/data-inspector/portal/)

* `inspect/portal-cli` - Clojure CLI (simplest approach)
* `inspect/portal-web` - Web ClojureScript REPL
* `inspect/portal-node` - node ClojureScript REPL

| Command                          | Description                                           |
|----------------------------------|-------------------------------------------------------|
| `clojure -M:inspect/portal-cli`  | Clojure REPL with Portal dependency                   |
| `clojure -M:inspect/portal-web`  | ClojureScript web browser REPL with Portal dependency |
| `clojure -M:inspect/portal-node` | ClojureScript node.js REPL with Portal dependency     |


**Using Portal once running**
`(require '[portal.api :as portal])` once the REPL starts.  For `inspect/portal-web` use `(require '[portal.web :as portal])` instead

`(portal/open)` to open the web based inspector window in a browser.

`(portal/tap)` to add portal as a tap target (add-tap)

`(tap> {:accounts [{:name "jen" :email "jen@jen.com"} {:name "sara" :email "sara@sara.com"}]})` to send data to the portal inspector window (or any other data you wish to send)

`(portal/clear)` to clear all values from the portal inspector window.

`(portal/close)` to close the inspector window.


## Debug Tools

Emacs CIDER has a built in debug tool that requires no dependencies (other than Cider itself).

[Sayid](https://github.com/clojure-emacs/sayid) is a comprehensive debug and profile tool (which requires your code to compile) and generated a full and detailed history of an evaluation.

* `:repl/debug` run basic REPL prompt with sayid, and cider-nrepl middleware
* `:repl/debug-refactor` run basic REPL prompt with sayid, clj-refactor and cider-nrepl middleware
* `:repl/rebel-debug` run Rebel rich UI REPL prompt with sayid, and cider-nrepl middleware
* `:repl/rebel-debug-refactor` run Rebel rich UI REPL prompt with sayid, clj-refactor and cider-nrepl middleware

[Practicalli Spacemacs - Sayid debug and profile tool](https://practical.li/spacemacs/debug-clojure/sayid-debug/) covers the use of these aliases in more detail


## Clojure Specification

Clojure spec, generators and test.check

* `:lib/spec-test` - generative testing with Clojure test.check
* `:lib/spec2` - experiment with the next version of Clojure spec - alpha: design may change


## Unit Testing frameworks

Unit test libraries and configuration.  The Clojure standard library includes the `clojure.test` namespace, so no alias is required.

* `:env/test` - add `test` directory to classpath


## Test runners and Test Coverage tools

[Practicalli Clojure: Unit testing](https://practical.li/clojure/testing/) covers many aspects of testing for projects.  Kaocha is the main test runner used by Practicalli as it is simple to use and easily configurable to create an effective test workflow.

Run unit tests in a project which are defined under the `test` path. See

| Command                     | Description                                                                               |
|-----------------------------|-------------------------------------------------------------------------------------------|
| `clojure -X:test/run`       | run tests with the Kaocha comprehensive test runner for Clojure (same as :test/kaocha)    |
| `clojure -X:test/watch`     | run tests in watch mode using Kaocha test runner for Clojure (same as :test/kaocha-watch) |
| `clojure -X:test/cognitect` | Cognitect Clojure test runner                                                             |
| `clojure -X:test/coverage`  | Cloverage clojure.test coverage report                                                    |
| `clojure -M:test/cljs`      | ClojureScript test runner (Kaocha)                                                        |

`:lib/kaocha` alias adds kaocha as a library to the class path, enabling scripts such as kaocha-runner.el to run Kaocha test runner from Emacs Cider

> A `test.edn` [configuration file](https://cljdoc.org/d/lambdaisland/kaocha/1.77.1236/doc/3-configuration) can be used with the :test/run alias instead of using various aliases defined above


## Lint tools

Static analysis tools to help maintain code quality and suggest Clojure idioms.

* [`:lint/clj-kondo`](https://github.com/borkdude/clj-kondo/) - comprehensive and fast static analysis lint tool
* [`:lint/eastwood`](https://github.com/jonase/eastwood) - classic lint tool for Clojure
* [`:lint/idiom-check`](https://github.com/jonase/kibit) - checking for idiomatic Clojure code with Kibit

| Command                     | Description                                      |
|-----------------------------|--------------------------------------------------|
| `clojure -M:lint/clj-kondo` | comprehensive and fast static analysis lint tool |
| `clojure -M:lint/eastwood`  | classic lint tool for Clojure                    |
| `clojure -M:lint/idiom`     | Suggest idiomatic Clojure code                   |


## Visualising project vars and library dependencies

Create [Graphviz](https://www.graphviz.org/) graphs of project and library dependencies

> Install [Graphviz](https://www.graphviz.org/) to generate PNG and SVG images. Or use the [Edotor website](https://edotor.net/) to convert .dot files to PNG or SVG images and select different graph layout engines.

### Var dependencies

Generate dependency graphs for Vars in Clojure & ClojureScript namespaces

* [`:graph/vars`](https://github.com/benedekfazekas/morpheus) - generate graph of vars in a project as a .dot file
* [`:graph/vars-png`](https://github.com/benedekfazekas/morpheus) - generate graph of vars in a project as a .png file using `src` and `test` paths
* [`:graph/vars-svg`](https://github.com/benedekfazekas/morpheus) - generate graph of vars in a project as a .svg file using `src` and `test` paths

> Use `-f` command line argument to over-ride file type created, i.e `-f png`

### Namespace dependencies

[Vizns](https://github.com/SevereOverfl0w/vizns) creates graphs of relationships between namespaces and their dependencies

* `clojure -M:graph/ns-deps` - generate a single deps-graph SVG image
* `clojure -M:graph/ns-deps-png` as above with PNG image

Other [options described in the visns project readme](https://github.com/SevereOverfl0w/vizns#usage):


### Project Dependency Relationships

Visualise the relationships between dependencies in the project (or given `deps.edn` configuration).  Shows the fully qualified name of a dependency, its version and size.

Generate a PNG image from the project `deps.edn` configuration and save to `project-dependencies-graph.png` file

```bash
clojure -T:graph/deps
```

Options available

* `:deps` - Path to deps file (default = "deps.edn")
* `:trace` - images showing individual trace images of dependency relations (default = false)
* `:trace-file` - Path to trace.edn file to read
* `:output` - file name string to save the generated image, `:output '"deps.png"'`
* `:trace-omit` - Collection of lib symbols to omit in trace output
* `:size` - Boolean flag to include sizes in images (default = false)


## Performance testing

Performance testing tools for the REPL

* [:performance/benchmark](https://github.com/hugoduncan/criterium/)

Use the aliases with either `-M` or `-X` flags on the Clojure command line.

```clojure
clojure -M:performance/benchmark:repl/rebel

(require '[criterium.core :refer [bench quick-bench]])
(bench (expression-to-test))
```

Performance test a project in the REPL

```clojure
clojure -M:performance/benchmark:repl/rebel

(require '[practicalli/namespace-name]) ; require project code
(in-ns 'practicalli/namespace-name)
(quick-bench (project-function args))
```

* [:performance/memory-meter](https://github.com/clojure-goes-fast/clj-memory-meter) - memory usage

Use the aliases with either `-M` or `-X` flags on the Clojure command line.

In the REPL:

```clojure
  (require '[clj-memory-meter.core :as memory-meter])
   (memory-meter/measure (your-expression))
```

## Services

Web servers and other standalone services run with Clojure CLI

* `:service/http` - serve files from current directory or specified directory and port.  More options at [kachayev/nasus project](https://github.com/kachayev/nasus).

| Command                                   | Description                                         |
|-------------------------------------------|-----------------------------------------------------|
| `clojure -M:service/http`                 | HTTP file server for current directory on port 8000 |
| `clojure -M:service/http 8888`            | as above with PORT specified to 8888                |
| `clojure -M:service/http 8888 --dir docs` | as above with PORT 8888 and doc directory           |

> Use `Ctrl-c` to stop the server when running in the foreground

## Security

`:security/nvd-scan` and `:security/ndv-fix` adds [clj-watson](https://github.com/clj-holmes/clj-watson) tool

The alias requires an [API Key to access the NIST National Vulnerability Database (NVD)](https://nvd.nist.gov/developers/request-an-api-key).

`CLJ_WATSON_NVD_API_KEY` environment variable should be set to the value of the API Key, e.g via `.bashrc` or `.zshenv` file.

| Command                        | Description                                                         |
|------------------------------- | ------------------------------------------------------------------- |
| `clojure -T:security/nvd-scan` | check all libraries on the class path for security vulnerabilities  |
| `clojure -T:security/nvd-fix`  | update all libraries on the class path for security vulnerabilities |

> [clj-watson-action](https://github.com/clj-holmes/clj-watson-action) can be used in a GitHub workflow to run security vulnerability checks


## Community activities

The [Clojurians Zulip
CLI](https://gitlab.com/clojurians-zulip/feeds/-/blob/master/README.md#announce-an-event) provides a simple way to register community events.

* `:community/zulip-event` create an event on the Clojurians Zulip community

Set an environment variable called ZULIP_AUTH to your account email, followed by the account token (see [Account & privacy](https://clojurians.zulipchat.com/#settings/account-and-privacy)), e.g.

```shell
your@email.com:493u984u3249834uo4u
```

Create an event using the following command

Show help and options

```shell
clojure -M:community/zulip-event create -h
```

Announce an meetup.com event (you'll be asked for confirmation before posting)

```shell
clojure -M:community/zulip-event create --zulip-auth "${ZULIP_AUTH}" --url https://www.meetup.com/some-group/events/123/
```

Full example

```shell
clojure -M:community/zulip-event create --zulip-auth "${ZULIP_AUTH}" \
--title 'Practicalli Live - Exercism.io challenges' \
--start '2020-11-14T09:00+00:00' \
--duration 1 \
--url https://youtu.be/Z5C7X1UN8yo \
--description 'Walking through solutions to the Exercism.io challenges'
```

Take care to get the timezone notation correct.


## Library Hosting Services

Clojure libraries are packaged as Java Archive (JAR) files and distributed by Maven style repositories. A Clojure project configuration defines library dependencies that are satisfied by downloading jar files from the collective repository sources.

`central` and `clojars` are defined in the Clojure CLI installation configuration and are the main repositories for Clojure development.

* `central` - Maven Central, the canonical repository for JVM libraries, including Clojure releases
* `clojars` - [clojars.org](https://repo.clojars.org/), the canonical repositories for Clojure community libraries fronted by a contend delivery network service

```clojure
 :mvn/repos
 {"central" {:url "https://repo1.maven.org/maven2/"}
  "clojars" {:url "https://repo.clojars.org/"}}
```

`central` and `clojars` repos can be removed by setting their configuration  to `nil` in the user or project `deps.edn` configuration.

```clojure
`:mvn/repos
 {"central" nil
  "clojars" nil}
```

Maven supports [explicit mirror definition](https://maven.apache.org/guides/mini/guide-mirror-settings.html) in `~/.m2/settings.xml` and Clojure CLI  supports this configuration.  Adding Maven Central or a mirror to  `~/.m2/settings.xml` negates the need for its entry in deps.edn configuration.


### Optional repositories

The order of additional repositories consulted is not guaranteed, so may cause unpredictable side effects in the project build especially if `RELEASE` or `LATEST` tags are used rather than a specifice numerical version.

* `sonatype` - [snapshots of Clojure development releases](https://oss.sonatype.org/), useful for testing against before new stable releases.
* `business-area` - example of adding a local Artifactory server for your team or business area.
* `google-maven-central` - [Maven Central mirror hosted on Google Cloud Storage](https://storage-download.googleapis.com/maven-central/index.html) - Americas, Asia, Europe

> Use only one entry for a specific repository to ensure a repeatable build.  For example, avoid having Maven Central and a Maven Central mirror both included.

### Business area

Example of local Artifactory repository configuration

```clojure
 :mvn/repos
 {"business-area" {:url "https://artifacts.internal-server.com:443/artifactory/business-area-maven-local"}
```

### Americas mirrors

```clojure
 :mvn/repos
 {"google-maven-central" {:url "https://maven-central.storage-download.googleapis.com/maven2/"}}
```

### Europe mirrors

```clojure
 :mvn/repos
 {"google-maven-central" {:url "https://maven-central-eu.storage-download.googleapis.com/maven2/"}

 ;; CDN access to clojars
 "clojars" {:url "https://repo.clojars.org/"}}
```

### Asia Region Mirrors

```clojure
 :mvn/repos
 {"google-maven-central" {:url "https://maven-central-asia.storage-download.googleapis.com/maven2/"}

 ;; Community mirror
 "clojars-china-mirror" {:url "https://mirrors.tuna.tsinghua.edu.cn/clojars/"}

 ;; CDN access to clojars
 "clojars" {:url "https://repo.clojars.org/"}}
```

## Maven local repository

Specify a local repository for maven, as an alternative to the default location: `$HOME/.m2/repository`

FreeDesktop.org `XDG_CACHE_HOME` is the recommended location for an alternative Maven local repository.

```clojure
:mvn/local-repo "/home/practicalli/.cache/maven/repository"
```

> NOTE: The full path should be specified, otherwise a relative directory path will be created

`clojure -Spath` will show the current class path which will include the path to the local maven repository for the library dependencies.

> NOTE: using `clojure -Sforce` forces a classpath recompute, deleting the contents of .cpcache


## Star History

[![Star History Chart](https://api.star-history.com/svg?repos=practicalli/clojure-cli-config&type=Date)](https://star-history.com/#practicalli/clojure-cli-config&Date)
