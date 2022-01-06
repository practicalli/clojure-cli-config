![Practicalli Clojure deps.edn user wide configuration for Clojure projects](https://raw.githubusercontent.com/practicalli/graphic-design/live/practicalli-clojure-deps.png)

![clj-kondo GitHub action](https://github.com/practicalli/clojure-deps-edn/actions/workflows/lint-with-clj-kondo.yml/badge.svg)
[![MegaLinter](https://github.com/practicalli/clojure-deps-edn/actions/workflows/megalinter.yaml/badge.svg)](https://github.com/practicalli/clojure-deps-edn/actions/workflows/megalinter.yaml)

## User level configuration for Clojure CLI

[practicalli/clojure-deps-edn](https://github.com/practicalli/clojure-deps-edn) adds community libraries and tools to use with all Clojure CLI projects or as stand-alone tools.  Aliases use qualified descriptive names to avoid clashes with project specific aliases, ensuring that the user wide aliases remain available in all projects.

Common default arguments are included in an alias via `:exec-args` to minimise the cognitive load required to use aliases.

The **[Practicalli Clojure book](https://practical.li/clojure)** uses this configuration extensively to help you develop Clojure projects and learn the Clojure language. Initial inspiration taken from [seancorfield/dot-clojure](https://github.com/seancorfield/dot-clojure).

# Contents

* [Installing practicalli/clojure-deps-edn](#install-practicalli-clojure-deps-edn)
* [Updating practicalli/clojure-deps-edn](#updating-practicalli-clojure-deps-edn)
* [Common development tasks](#common-development-tasks)
* [Aliases](#aliases)
  * Running a REPL
    * [REPL Terminal UI](#repl-terminal-ui) | [REPL with Editor](#repl-with-editor) | [Hotload dependencies](#hotload-libraries-into-a-running-repl) | [Remote REPL Connection](#remote-repl-connection) | [Alternative REPL](#alternative-repl) | [Middleware](#middleware)
  * [Clojure Projects](#clojure-projects)
    * [Dependencies](#project-dependencies) | [Analysis](#project-analysis) | [Packaging](#project-packaging) | [Deployment](#project-deployment)
  * [Format](#format-code) | [Lint](#lint-tools)
  * [Java sources](#java-sources)
  * [Unit Testing](#unit-testing-frameworks)
    * [Test runners](#test-runners-and-test-coverage-tools) | [Clojure Spec](#clojure-specification) | [Performance](#performance-testing) | [Security](#security)
  * [Databases](#databases-and-drivers)
  * [Data Inspectors](#data-inspectors)
    * [Visualise vars and deps](#visualising-project-vars-and-library-dependencies)
  * [Services](#services)
* [Library repositories](#library-repositories)
* [Experimental](#experimental)


## Install Practicalli clojure-deps-edn

Version **1.10.3.1040** or later of [Clojure CLI](https://clojure.org/guides/getting_started) is recommended. Check the version of Clojure CLI currently installed

```shell
clojure -Sdescribe
```

> To install Clojure CLI for a specific operating system, follow the [Practicalli guide to installing Clojure](https://practical.li/clojure/clojure-cli/install/clojure-cli.html) or follow the [Clojure.org Getting Started page](https://clojure.org/guides/getting_started).


Fork the practicalli/clojure-deps-edn repository and clone your fork to an existing `.clojure/` directory (eg. `$HOME/.clojure` or `$XDG_HOME%/.clojure`).

```shell
git clone your-fork-url ~/.clojure/
```

The configuration from `.clojure/deps.edn` is now available for all Clojure CLI projects for that user account.

# Using Practicalli clojure-deps-edn

Any directory containing a `deps.edn` file is considered a Clojure project. A `deps.edn` file can contain an empty hash-map, `{}` or hash-map with configuration, usually `:paths` and `:dependencies` and perhaps some `:aliases`.

The project `deps.edn` file is merged with the user wide configuration, e.g `$HOME/.clojure/deps.edn`, with the project `deps.edn` keys taking precedence if there is duplication, otherwise they are merged.

Configuration passed via the command line when running `clojure` or the `clj` wrapper will take precedence over the project and user level configuration if there is duplication, otherwise they are merged.

![Clojure CLI tools deps.edn configuration precedence](https://raw.githubusercontent.com/practicalli/graphic-design/live/clojure/clojure-cli-tools/clojure-cli-tools-deps-edn-configuration-precedence.png)

See the rest of this readme for examples of how to use each alias this configuration contains.

# Updating Practicalli clojure-deps-edn

The collection of aliases is regularly reviewed and expanded upon and suggestions are most welcome.

The versions of libraries are manually updated at least once per month using the `:outdated` alias and a new version of the `deps.edn` file pushed to this repository.  The antq project is used to report new library versions, sent to an org file which is then used to update the changelog.

```shell
cd ~/.clojure/
clojure -M:project/outdated > outdated.org
```

# Common development tasks

How to run common tasks for Clojure development.

* Built-in tasks require no additional configuration.
* User aliases should be added to `~/.clojure/deps.edn`.
* Project aliases should be added to the individual project `deps.edn` file (or may be part of a template).
* User/Project alias can be defined in both user and project `deps.edn` files (add to project `deps.edn` for Continuous Integration)

| Task                                                   | Command                                                         | Configuration      |
|--------------------------------------------------------|-----------------------------------------------------------------|--------------------|
| Create project (clojure exec)                          | `clojure -X:project/new :template app :name practicalli/my-app` | User alias         |
| Run REPL (rebel readline with nrepl server)            | `clojure -M:repl/rebel`                                         | User alias         |
| Run ClojureScipt REPL with nREPL (editor support)      | `clojure -M:repl/cljs-nrepl`                                    | User alias         |
| Download dependencies                                  | `clojure -P`  (followed by optional aliases)                    | Built-in           |
| Find libraries (mvn & git)                             | `clojure -M:project/find-deps library-name`                     | User alias         |
| Find available versions of a library                   | `clojure -X:deps find-versions`                                 | Built-in           |
| Resolve git coord tags to shas and update deps.edn     | `clojure -X:deps git-resolve-tags git-coord-tag`                | Built-in           |
| Generate image of project dependency graph             | `clojure -T:project/graph-deps`                                 | User alias         |
| Check for new dependency versions                      | `clojure -T:project/outdated`                                   | User alias         |
| Run tests                                              | `clojure -M:test/run`                                           | User/Project alias |
| Run the project  (clojure.main)                        | `clojure -M -m domain.main-namespace`                           | Built-in           |
| [Run the project](https://youtu.be/u5VoFpsntXc?t=2166) | `clojure -X:project/run`                                        | Project alias      |
| Package library                                        | `clojure -X:project/jar`                                        | User/Project alias |
| Deploy library locally (~/.m2/repository)              | `clojure -X:deps mvn-install`                                   | Built-in           |
| Package application                                    | `clojure -X:project/uberjar`                                    | User/Project alias |

> Add alias `:project/run` to the deps.edn file in the root of a project:
>
> `:project/run {:ns-default domain.namespace :exec-fn -main}` - see this video for an example <https://youtu.be/u5VoFpsntXc?t=2166


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
| `-T`            | Run a tool or alias separate from a project classpath    | `:exec-fn`, `:exec-args` & :key val args             |
| `-J`            | Java Virtual Machine specific options (memory size, etc) |                                                      |

* deps = `:deps`, `:extra-deps`, `replace-deps`
* path = `:path`, `:extra-paths`, `replace-paths`


## REPL terminal UI

Run an interactive REPL on the command line with the simple REPL UI or [Rebel readline](https://github.com/bhauman/rebel-readline) for a feature rich REPL experience.

nREPL server is started by default, so that editors and other command line sessions can connect to the same REPL.

See [Middleware aliases](#middleware) to run a headless REPL process without a REPL UI

Use the `:env/dev` alias with the :repl aliases to include `dev/` in classpath and [configure REPL startup actions using `dev/user.clj`](https://practical.li/clojure/clojure-cli/projects/configure-repl-startup.html)

| Command                            | Description                                                                                                    |
|------------------------------------|----------------------------------------------------------------------------------------------------------------|
| `clojure -M:repl/rebel`            | Run a Clojure REPL using Rebel Readline                                                                        |
| `clojure -M:env/dev:repl/rebel`    | Run a Clojure REPL using Rebel Readline, including deps and path from `:env/dev` alias to configure REPL start |
| `clojure -M:repl/rebel-cljs`       | Run a ClojureScript REPL using Rebel Readline                                                                  |

`:repl/help` in the Rebel UI for help and available commands.  `:repl/quit` to close the REPL.

> [Data Inspectors](#data-inspectors) section defines `:inspect/reveal` alias
> for a Reveal REPL with visualization, along with other data visualization
> tools.

## REPL with Editor

Run an interactive REPL on the command line with the simple terminal UI, including an nREPL server and Cider libraries to support connections from Clojure editors, e.g. Conjure, CIDER and Calva.

| Command                          | Description                                                                       |
|----------------------------------|-----------------------------------------------------------------------------------|
| `clojure -M:repl/nrepl`          | Clojure REPL with nREPL server for editor support                                 |
| `clojure -M:repl/cljs-nrepl`     | ClojureScipt REPL with nREPL for editor support                                   |
| `clojure -M:repl/cider`          | Clojure REPL with nREPL server and Cider-nrepl                                    |
| `clojure -M:repl/cider-refactor` | Clojure REPL with nREPL server, Cider-nrepl and clj-refactor                      |
| `clj -M:repl/reveal-nrepl`       | Clojure REPL with Reveal data visualization and nREPL interactively               |
| `clj -M:repl/reveal-light-nrepl` | Clojure REPL with Reveal data visualization (light theme) and nREPL interactively |

## Hotload libraries into a running REPL

Use the `:lib/hotload` alias in front of any of the above aliases to enable [hotloading of libraries into a running REPL process](https://practical.li/clojure/alternative-tools/clojure-cli/hotload-libraries.html).

`clojure -M:lib/hotload:repl/rebel` enables hotloading in the REPL terminal UI.

`clojure -M:lib/hotload:env/dev:repl/rebel` enables hotloading, included the dev directory (to auto-load `user.clj`) with a REPL terminal UI.

## Remote REPL connection

Connect to the nREPL server of a remote REPL using nREPL connect, using a simple terminal UI

```shell
clj -M:repl/remote --host hostname --port 12345
```

As above but using the enhanced Rebel Readline UI

```shell
clj -M:repl/rebel-remote --host hostname --port 12345
```


## Alternative REPL

Clojure 1.10.x onward can [run a Socket Server](https://clojure.org/reference/repl_and_main#_launching_a_socket_server) for serving a socket-based REPL (Clojure and ClojureScript).

[tubular](https://github.com/mfikes/tubular) is a Socket Server client for Clojure and Clojurescript REPL processes.

PREPL is a REPL with structured output.  See [Cloure socket prepl cookbook](https://oli.me.uk/clojure-socket-prepl-cookbook/) for examples.

| Command                          | Description                                                                     |
|----------------------------------|---------------------------------------------------------------------------------|
| `clojure -M:repl/socket`         | Clojure REPL using Socket Server on port 50505                                  |
| `clojure -M:repl/socket-zero`    | As above but on first available port (container, cloud environment)             |
| `clojure -M:repl/socket-zero -r` | As above but and run a REPL                                                     |
| `clojure -M:repl/socket-node`    | ClojureScript REPL using Socket Server on port 55555                            |
| `clojure -M:repl/socket-browser` | ClojureScript REPL using Socket Server on port 58585                            |
| `clojure -M:repl/socket-client`  | Socket REPL client on port 50505 ([tubular](https://github.com/mfikes/tubular)) |
| `clojure -M:repl/prepl`          | Clojure REPL using PREPL Server on port 40404                                   |
| `clojure -M:repl/prepl-cljs`     | Clojure REPL using PREPL Server on port 44444                                   |
|                                  |                                                                                 |

## Clojure Projects

* Create projects from deps, leiningen and boot templates with [clj-new](https://github.com/seancorfield/clj-new)
* Check and update project dependencies
* Package projects as jar and uberjars
* Deploy projects locally and to Clojars

### Create new projects from templates

* `:project/new` - create a new project from a template

Create a new project (via clojure.main - classic approach - recommended for Windows to ensure template arguments are parsed correctly)

```shell
clojure -M:project/new luminus practicalli/full-stack-app +http-kit +h2 +reagent +auth
```

Create a new project (Edn command line arguments - recommended approach - except for Windows)

| Command                                                                                                 | Description                                          |
|---------------------------------------------------------------------------------------------------------|------------------------------------------------------|
| `clojure -T:project/new`                                                                                | library project called playground                    |
| `clojure -T:project/new :name practicalli/my-library`                                                   | library project with given name                      |
| `clojure -T:project/new :template app :name practicalli/my-application`                                 | App project with given name                          |
| `clojure -T:project/new :template luminus :name practicalli/full-stack-app :args '["+http-kit" "+h2"]'` | Luminus project with given name and template options |
| `clojure -T:project/new :template figwheel-main :name practicalli/landing-page :args '["--reagent"]'`   | ClojureScript Figwheel-main project with reagent     |

### Running projects

Run project with or without an alias:

```shell
clojure -M:alias -m domain.app-name
clojure -M -m domain.app-name
```

> The `-M` flag is required even if an alias is not included in the running of the application.  A warning will be displayed if the `-M` option is missing.

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
* [`:project/find-deps`](https://github.com/hagmonk/find-deps) - fuzzy search for libraries to add as dependencies
* [`:project/outdated`](https://github.com/liquidz/antq) - report newer versions for maven and git dependencies
* [`:project/outdated-mvn`](https://github.com/slipset/deps-ancient) - check for newer dependencies (maven only)

| Command                                              | Description                                                             |
|------------------------------------------------------|-------------------------------------------------------------------------|
| `clojure -M:project/check`                           | detailed report of compilation errors for a project                     |
| `clojure -M:project/find-deps library-name`          | fuzzy search Maven & Clojars                                            |
| `clojure -M:project/find-deps -F:merge library-name` | fuzzy search Maven & Clojars and save to project deps.edn               |
| `clojure -T:project/graph-deps`                      | generate png image of project dependencies from project `deps.edn` file |
| `clojure -T:project/outdated`                        | report newer versions for maven and git dependencies                    |
| `clojure -M:project/outdated-mvn`                    | check for newer dependencies (maven only)                               |

## Project analysis

[Carve](https://github.com/borkdude/carve) - static analysis of code
(clj-kondo) and remove or report unused vars

* [`:project/carve`](https://github.com/borkdude/carve.git) - remove / report unused vars
* [`:project/unused`](https://github.com/borkdude/carve.git) - alternative alias name for :project/carve
* [`:project/unused-vars`](https://github.com/borkdude/carve.git) - alternative alias name for :project/carve

| Command                                                                               | Description                                    |
|---------------------------------------------------------------------------------------|------------------------------------------------|
| `clojure -M:project/unused --opts '{:paths ["src" "test"]}'`                          | remove unused vars from the src and test paths |
| `clojure -M:project/unused --opts '{:paths ["src" "test"] :report {:format :text}} '` | report unused vars from the src and test paths |

Generate report in a file:

```shell
clojure -M:project/unused --opts '{:paths ["src" "test"] :report {:format :ignore}}' > .carve/ignore
```

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
c
```clojure
clojure -X:project/jar :jar '"practicalli.app.jar"' :aot false :main-class domain.app-name
```

### Project Deployment

Deploy a project archive file locally or to Clojars.org

* [`-X:deps mvn-install`](https://insideclojure.org/2020/09/04/clj-exec/) built-in Clojure CLI alias to deploy a Jar locally in the `~/.m2/repository` directory
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

> `clojure -X:deps mvn-install project.jar` for local deployment of jars is part of the 1.10.1.697 release of the [Clojure CLI](https://clojure.org/guides/getting_started) in September 2020.

## Format code

* `:format/zprint filename` - format clojure code and Edn data structures in the given file using zprint
* `:format/cljfmt [check|fix] filename` - format clojure code and Edn data structures in the given file(s) using cljfmt

## Java Sources

Include Java source on the  classpath to [look up Java Class and method definitions, eg. `cider-find-var` in Emacs](https://practical.li/spacemacs/navigating-code/java-definitions.html)

Requires: Java sources installed locally (e.g. `"/usr/lib/jvm/openjdk-17/lib/src.zip"`)

* `:lib/java8-source`
* `:lib/java11-source`
* `:lib/java17-source`

Use the aliases with either `-M` or `-X` flags on the Clojure command line.

## Databases and drivers

Databases and drivers, typically for development time inclusion such as embedded databases

* `:database/h2` - H2 embedded database library and next.jdbc

`clojure -M:database/h2` - [run a REPL with an embedded H2 database and next.jdbc libraries](https://cljdoc.org/d/seancorfield/next.jdbc/CURRENT/doc/getting-started#create--populate-a-database)

Use the aliases with either `-M` or `-X` flags on the Clojure command line.

## Data Inspectors

REPL driven data inspectors and `tap>` sources for visualising data.

### [Portal](https://github.com/djblue/portal)

Navigate data in the form of edn, json and transit
[Practicalli Clojure -data browsers section - portal](https://practical.li/clojure/clojure-cli/data-browsers/portal.html)

* `inspect/portal-cli` - Clojure CLI (simplest approach)
* `inspect/portal-web` - Web ClojureScript REPL
* `inspect/portal-node` - node ClojureScript REPL

| Command                           | Description                                           |
|-----------------------------------|-------------------------------------------------------|
| `clojure -M:inspect/portal-cli`   | Clojure REPL with Portal dependency                   |
| `clojure -M:inspect/portal-web`   | ClojureScript web browser REPL with Portal dependency |
| `clojure -M:inspect/portal-node** | ClojureScript node.js REPL with Portal dependency     |


**Using Portal once running**
`(require '[portal.api :as portal])` once the REPL starts.  For `inspect/portal-web` use `(require '[portal.web :as portal])` instead

`(portal/open)` to open the web based inspector window in a browser.

`(portal/tap)` to add portal as a tap target (add-tap)

`(tap> {:accounts [{:name "jen" :email "jen@jen.com"} {:name "sara" :email "sara@sara.com"}]})` to send data to the portal inspector window (or any other data you wish to send)

`(portal/clear)` to clear all values from the portal inspector window.

`(portal/close)` to close the inspector window.

### Reveal data inspector and visualization tool

[Reveal](https://vlaaad.github.io/reveal/) - run a Terminal REPL with data visualisation or connect with nREPL, socket or prepl connection and use from
any [Clojure aware editor]([Clojure aware editors](https://practical.li/clojure/clojure-editors/)).

Reveal can also used as a `tap>` source for more powerful manual debugging.

* `:inspect/reveal` - visualisation with terminal REPL.
* `:inspect/reveal-light` - as above with light theme and 32 point Ubuntu Mono font
* `:inspect/reveal-nrepl` - visualization for [Clojure aware editors](https://practical.li/clojure/clojure-editors/) via an nrepl server
* `:inspec/reveal-light-nrepl` - as above with light theme and 32 point Ubuntu Mono font
* `:inspect/reveal-nrepl-cider` - visualization tool for Emacs Cider / Spacemacs / VSCode Calva
* `:inspec/reveal-light-nrepl-cider` - as above with light theme and 32 point Ubuntu Mono font

| Command                                      | Description                                                                        |
|----------------------------------------------|------------------------------------------------------------------------------------|
| `clojure -M:inspect/reveal`                  | start a Reveal repl with data visualization window (cloure.main)                   |
| `clojure -M:inspect/reveal-light`            | as above with light theme and large font                                           |
| `clojure -X:inspect/reveal`                  | start a Reveal repl with data visualization window (clojure exec)                  |
| `clojure -X:inspect/reveal-light`            | as above with light theme and large font                                           |
| `clojure -M:inspect/reveal-nrepl`            | Start nrepl server to use Cider / Calva editors with reveal                        |
| `clojure -X:inspect/reveal-light-nrepl`      | as above with light theme and large font                                           |
| `clojure -M:inspect/reveal-rebel`            | Start a Rebel REPL with Reveal Visualisations                                      |
| `clojure -M:inspect/reveal-light-rebel`      | Start a Rebel REPL with Reveal Visualisations & light theme                        |
| `clojure -M:inspect/reveal:repl/rebel`       | Start a Rebel REPL with Reveal dependency. Add reveal as tap> source               |
| `clojure -M:inspect/reveal-light:repl/rebel` | Start a Rebel REPL with Reveal dependency & light theme. Add reveal as tap> source |

#### Connecting nREPL based editors

Use the `:inspect/reveal-nrepl` alias when running the REPL, either in the terminal or via an nREPL based editor (CIDER, Calva, Conjure, Cursive, etc.)

Alternatively, add an `.nrepl.edn` file to the root of a project to include the Reveal middleware

```clojure
{:middleware [vlaaad.reveal.nrepl/middleware]}
```

#### Cider jack-in and reveal

See the [Reveal section of Practicalli Clojure](https://practical.li/clojure/clojure-cli/data-browsers/reveal.html#using-reveal-with-nrepl-editors) for full details, including how to set up a `.dir-locals.el` configuration.

`:inspect/reveal-nrepl-cider` alias contains Reveal REPL with nrepl server and Emacs CIDER specific middleware

`C-u cider-jack-in-clj` in CIDER to start a reveal REPL  (`SPC u , '` in Spacemacs)

Edit the jack-in command by deleting the all the configuration after the `clojure` command and add the alias

```shell
clojure -M:inspect/reveal-nrepl-cider
```

`:inspect/reveal-nrepl-cider` is a light version of the above.

#### Running different types of repl

Using Clojure exec `-X` flag, the default repl function can be over-ridden on the command line, supplying the `io-prepl` or `remote-prepl` functions.

* `clojure -X:inspect/reveal io-prepl :title '"I am a prepl repl"`
* `clojure -X:inspect/reveal remote-prepl :title '"I am a remote prepl repl"'`

#### Configure theme & font

Add a custom theme and font via the `-J` command line option or create an alias using `:inspect/reveal-light` as an example.

```shell
clojure -M:inspect/reveal -J-Dvlaaad.reveal.prefs='{:theme :light :font-family "Ubuntu Mono" :font-size 32}'
```

#### Rebel Readline & Reveal: Add Reveal as tap> source

Evaluate `(add-tap ((requiring-resolve 'vlaaad.reveal/ui)))` when using Rebel Readline to add Reveal as a tap source, showing `(tap> ,,,)` expressions in the reveal window, eg. `(tap> (map inc [1 2 3 4 5]))`.

[Practicalli Clojure - data browsers section](http://practicalli.github.io/clojure/clojure-cli/data-browsers/reveal.html) has more details on using reveal.

### Cognitect REBL (DEPRECATED)

Visualise the results of each evaluation in the REPL in the REBL UI.  Navigate through complex data structures.

> Cognitect REBL aliases requires [several separate install steps](http://practicalli.github.io/clojure/alternative-tools/clojure-cli/cognitect-rebl.html) before they are operational
> Tested on Oracle JDK 8 and OpenJDK 11 (current long term support).  Other Java 11 JDK distributions may work, but not tested. Newer (short term release) may work, but will need the `org.openjdk` library version in the `:inspect/rebl` alias changed to match the version of Java used.

* `inspect/rebl` - REBL, a visual data explorer (Java 11)
* `inspect/rebl-java8` - REBL, a visual data explorer (Oracle Java 8)

| Command                                                    | Description                                                      |
|------------------------------------------------------------|------------------------------------------------------------------|
| `clojure -M:inspect/rebl`                                  | Start REBL REPL and UI (Java 11 only)                            |
| `clojure -M:inspect/rebl-java8`                            | REBL REPL and UI  (Oracle Java 8 only)                           |
| `clojure -M:lib/cider-nrepl:inspect/rebl:middleware/nrebl` | REBL REPL and UI with nREPL server (CIDER, Calva) (Java 11 only) |

## Middleware

Aliases for libraries that combine community tools and REPL protocols (nREPL, SocketREPL).

Run a REPL on the command line for access by `cider-connect-` commands, providing the require cider middleware libraries that are auto-injected in `cider-jack-in-` commands.

### nREPL

* `:middleware/nrepl` - Clojure REPL with an nREPL server
* `:middleware/cider-clj` - Clojure REPL with nREPL server and CIDER dependencies for `cider-connect-clj`
* `:middleware/cider-clj-refactor` - as :middleware/cider-clj with clj-refactor added
* `:middleware/cider-cljs` - ClojureScript REPL with nREPL server and CIDER dependencies for `cider-connect-cljs`

| Command                                    | Description                                                                                      |
|--------------------------------------------|--------------------------------------------------------------------------------------------------|
| `clojure -M:middleware/nrepl`              | Run a Clojure REPL that includes nREPL server                                                    |
| `clojure -M:middleware/cider-clj`          | Run a Clojure REPL that includes nREPL server and CIDER connection dependencies                  |
| `clojure -M:middleware/cider-clj-refactor` | Run a Clojure REPL that includes nREPL server and CIDER connection dependencies and clj-refactor |
| `clojure -M:middleware/cider-cljs`         | Run a ClojureScript REPL that includes nREPL server and CIDER connection dependencies            |

#### Figwheel-main project and cider-connect-cljs

Open a terminal and run the REPL process with the command:

```bash
clojure -M:middleware/cider-cljs:fig
```

An nREPL server process is started along with the figwheel-main process.

In Emacs, run the command `cider-connect-cljs`, select `figwheel-main` build tool and the `dev` build

### Cognitect REBL with CIDER

Run the REBL REPL with nREPL server so CIDER can connect.

* `:middleware/nrebl` - REBL data browser on nREPL connection
* `:lib/cider-nrepl` - include nrepl, cider-nrepl and refactor-nrepl library
  dependencies (support `:inspect/nrebl` alias)

In a terminal, run REBL listening to nREPL using the command

```shell
clojure -M:lib/cider-nrepl:inspect/rebl:middleware/nrebl
```

`cider-connect-clj` in Spacemacs / Emacs and CIDER successfully connects to the nREPL port and evaluated code is sent to REBL.

To start a REBL REPL from `cider-jack-in-clj` add a `.dir-locals.el` file to the root of a Clojure project. The `.dir-locals.el` configuration adds the nREBL aliases set via `cider-clojure-cli-global-options` and all other automatically injected configuration is disabled (to prevent those dependencies over-riding the nREBL aliases).

```elisp
((clojure-mode . ((cider-preferred-build-tool . clojure-cli)
                  (cider-clojure-cli-global-options . "-M:lib/cider-nrepl:inspect/rebl:middleware/nrebl")
                  (cider-jack-in-dependencies . nil)
                  (cider-jack-in-lein-plugins . nil)
                  (cider-clojure-cli-parameters . ""))))
```

* [REBL data visualization: run REBL with nREPL based editors](https://practical.li/clojure/alternative-tools/clojure-cli/cognitect-rebl.html#configure-rebl-with-clojure-editors)


## Clojure Specification

Clojure spec, generators and test.check

* `:lib/spec-test` - generative testing with Clojure test.check
* `:lib/spec2` - experiment with the next version of Clojure spec - alpha: design may change

## Unit Testing frameworks

Unit test libraries and configuration.  The Clojure standard library includes the `clojure.test` namespace, so no alias is required.

* `:env/test` - add `test` directory to classpath
* [`:lib/expectations`](https://github.com/clojure-expectations/clojure-test) - `clojure.test` with expectations
* [`:lib/expectations-classic`](https://github.com/clojure-expectations/expectations) - expectations framework

Include expectations as a development dependency in a project `clojure -M:env/test:lib/expectations`, or on the command line with the cognitect test runner `clojure -M:lib/expectations:test/cognitect`

## Test runners and Test Coverage tools

Tools to run unit tests in a project which are defined under `test` path.

| Command                            | Description                                                                               |
|------------------------------------|-------------------------------------------------------------------------------------------|
| `clojure -M:test/run`              | run tests with the Kaocha comprehensive test runner for Clojure (same as :test/kaocha)    |
| `clojure -M:test/watch`            | run tests in watch mode using Kaocha test runner for Clojure (same as :test/kaocha-watch) |
| `clojure -X:test/cognitect`        | Cognitect Clojure test runner                                                             |
| `clojure -X:test/coverage`         | Cloverage clojure.test coverage report                                                    |
| `clojure -M:test/cljs`             | ClojureScript test runner (Olical)                                                        |
| `clojure -M:test/kaocha`           | Kaocha - test runner for Clojure                                                          |
| `clojure -M:test/kaocha-cljs`      | Kaocha - test runner for ClojureScript                                                    |
| `clojure -M:test/kaocha-cucumber`  | Kaocha - test runner with BDD Cucumber tests                                              |
| `clojure -M:test/kaocha-junit-xml` | Kaocha - test runner with Junit XML reporting for CI dashboards & wallboards              |
| `clojure -M:test/kaocha-cloverage` | Kaocha - test runner with test coverage reporting                                         |

> A `test.edn` [configuration file](https://cljdoc.org/d/lambdaisland/kaocha/1.0.829/doc/3-configuration) can be used with the :test/run alias instead of using various aliases defined above

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

## Visualising project vars and library dependencies

Create [Graphviz](https://www.graphviz.org/) graphs of project and library dependencies

Morpheus creates grahps of project vars and their relationships

* [`:graph/vars`](https://github.com/benedekfazekas/morpheus) - generate graph of vars in a project as a .dot file
* [`:graph/vars-png`](https://github.com/benedekfazekas/morpheus) - generate graph of vars in a project as a .png file using `src` and `test` paths
* [`:graph/vars-svg`](https://github.com/benedekfazekas/morpheus) - generate graph of vars in a project as a .svg file using `src` and `test` paths

> Install [Graphviz](https://www.graphviz.org/) to generate PNG and SVG images. Or use the [Edotor website](https://edotor.net/) to convert .dot files to PNG or SVG images and select different graph layout engines.

[Vizns](https://github.com/SevereOverfl0w/vizns) creates graphs of relationships between library dependencies and project namespaces

* `:graph/deps`
* `:graph/deps-png` - generate a single deps-graph png image

Other options:

* `clojure -M:graph/deps navigate`  # navigable folder of SVGs
* `clojure -M:graph/deps single`    # deps-graph.dot file
* `clojure -M:graph/deps single -o deps-graph.png -f png`
* `clojure -M:graph/deps single -o deps-graph.svg -f svg`
* `clojure -M:graph/deps single --show`  # View graph without saving

## Performance testing

Performance testing tools for the REPL

* [:performance/benchmark](https://github.com/hugoduncan/criterium/)

Use the aliases with either `-M` or `-X` flags on the Clojure command line.

> TODO: check these alias combinations are correct

```clojure
clojure -M:performance/benchmark:repl/rebel

(require '[criterium.core :refer [bench quick-bench]])
(bench (adhoc-expression))
```

> TODO: check these alias combinations are correct

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

> DEPRECATED: this command also [checks the clojure-nvd for security issues as clojure-nvd jar and dependencies are merged into the classpath](https://github.com/practicalli/clojure-deps-edn/pull/31).  This goes [against the recommended approach by the clojure-nvd maintainer](https://github.com/rm-hull/nvd-clojure#avoiding-classpath-interference) and will [in future fail to run](https://github.com/rm-hull/nvd-clojure/issues/117), so use with caution.

* `:service/nvd` - check library dependencies of a project against the [National Vulnerability Database](https://nvd.nist.gov/) using [nvd-clojure](https://github.com/rm-hull/nvd-clojure)

| Command                                          | Description                                                        |
|--------------------------------------------------|--------------------------------------------------------------------|
| `clojure -T:security/nvd "" "$(clojure -Spath)"` | check all jar files on the class path for security vulnerabilities |

> The first "" is required argument and can contain a filename to a json file of additional configuration.  The second argument, `"$(clojure -Spath)"`, passes the project classpath to be analysed as a string.


## Community activities

The [Clojurians Zulip
CLI](https://gitlab.com/clojurians-zulip/feeds/-/blob/master/README.md#announce-an-event) provides a simple way to register community events.

* `:community/zulip-event` create an event on the Clojurians Zulip community

Set an environment variable called ZULIP_AUTH to your account email, followed by the account token (in settings), e.g.

```shell
your@email.com:493u984u3249834uo4u
```

Create an event using the following command

```shell
clojure -M:community/zulip-event create --zulip-auth "${ZULIP_AUTH}" --title 'Practicalli Live - Exercism.io challenges' --start '2020-11-14T09:00+00:00' --duration 1 --url https://youtu.be/Z5C7X1UN8yo --description 'Walking through solutions to the Exercism.io challenges'
```

Take care to get the timezone notation correct.

---

## Experimental / Alpha Aliases

* [`:alpha/carve`](https://github.com/borkdude/carve) - EXPERIMENTAL, use with caution - carve out unwanted vars in code
* [`:alpha/hotload-libs`](https://github.com/clojure/tools.deps.alpha) - EXPERIMENTAL, use with caution - hot-load libraries into a running namespace.

**Hot loading dependencies** (unofficial)
> This is an unofficial approach using to hot loading and the API may change in future

* [`:alpha/hotload-libs`](https://github.com/clojure/tools.deps.alpha) - Add jar dependencies into a running REPL.

Practically Clojure [details how to hot-load libraries into a running REP using tools.deps.alpha](https://practical.li/clojure/alternative-tools/clojure-cli/hotload-libraries.html).

[The Clojure Webapp hotload libraries repository](https://github.com/practicalli/clojure-webapp-hotload-libraries) contains and example project that uses `add-libs` to hotload library dependencies.

# Library repositories

Repositories that host libraries for Clojure.

`central` and `clojars` are the man repositories for Clojure development are consulted in order.

`central` and `clojars` repos can be removed from consideration by setting their configuration hash-map to `nil` in `~/.clojure/deps.edn`.  For example, `{:mvn/repos {"central" nil}}`.

The order of additional repositories consulted is not guaranteed, so may cause unpredictable side effects in the project build especially if `RELEASE` or `LATEST` tags are used rather than a numeric library version.

Maven supports [explicit mirror definition](https://maven.apache.org/guides/mini/guide-mirror-settings.html) in `~/.m2/settings.xml` and Clojure CLI  supports this configuration.  Adding Maven Central or a mirror to  `~/.m2/settings.xml` negates the need for its entry in deps.edn configuration.

## Recommended repositories

* `central` - Maven Central, the canonical repository for JVM libraries, including Clojure releases
* `clojars` - [clojars.org](https://repo.clojars.org/), the canonical repositories for Clojure community libraries fronted by a contend delivery network service

## Optional repositories

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

### Asian Region Mirrors

```clojure
 :mvn/repos
 {"google-maven-central" {:url "https://maven-central-asia.storage-download.googleapis.com/maven2/"}

 ;; Community mirror
 "clojars-china-mirror" {:url "https://mirrors.tuna.tsinghua.edu.cn/clojars/"}

 ;; CDN access to clojars
 "clojars" {:url "https://repo.clojars.org/"}}
```

## Maven local repository

Define a local Maven repository.  Useful if you wish to specify an alternative to the default `~/.m2/` directory.

```clojure
 :mvn/local-repo "/cache/.m2"
```

> NOTE: using `clj -Sforce` forces a classpath recompute, deleting the contents of .cpcache
