![Practicalli Clojure deps.edn user wide configuration for Clojure projects](https://raw.githubusercontent.com/practicalli/graphic-design/live/practicalli-clojure-deps.png)

# User level configuration for Clojure CLI tools
[practicalli/clojure-deps-edn](https://github.com/practicalli/clojure-deps-edn) provides a user level configuration, containing over 30 aliases to support Clojure CLI and tools.deps project development.  These aliases use meaningful and descriptive names to avoid clashes with project specific aliases, ensuring that the user wide aliases remain available in all projects.

Aliases with common options are provided for convenience and to minimize the amount of cognitive load required to remember how to use aliases. Initial inspiration taken from [seancorfield/dot-clojure](https://github.com/seancorfield/dot-clojure).

The **[Practicalli Clojure book](https://practicalli.github.io/clojure/clojure-tools/data-browsers/portal.html)** uses this configuration extensively to help you develop Clojure projects and learn the Clojure language.

> MAJOR CHANGES: practicalli/clojure-deps-edn recommends using [Clojure CLI tools](https://clojure.org/guides/getting_started) version 1.10.1.697 or later.
> Aliases are now qualified keywords, which is recommended in general for using keywords in Clojure.
> Use the `classic-aliases` tag for the last version of this repository before these changes

# Contents
* [Installing practicalli/clojure-deps-edn](#installing-practicalli-clojure-deps-edn)
* [Updating practicalli/clojure-deps-edn](#updating-practicalli-clojure-deps-edn)
* [Common development tasks](#common-development-tasks)
* [Aliases](#aliases)
    * [REPL experience](#repl-experience) | [Alternative REPLs](#alternative-repls) | [Projects](#clojure-projects) | [Java sources](#java-sources) | [Databases](#databases-and-drivers) | [Data Inspectors](#data-inspectors) | [Middleware](#middleware) | [Clojure Spec](#clojure-specification) | [Unit Testing](#unit-testing-frameworks) | [Test runners](#test-runners-and-test-coverage-tools) | [Lint tools](#lint-tools) | [Visualize vars and deps](#visualizing-project-vars-and-library-dependencies) | [Performance testing](#performance-testing)
* [Library repositories](#library-repositories)
* [Experimental](#experimental)

# For use with [Clojure CLI tools version 1.10.1.697](https://clojure.org/guides/getting_started) or above
Check the version of Clojure CLI tools currently installed
```shell
clojure -Sdescribe
```


# Install Practicalli clojure-deps-edn
Clojure CLI tools creates a configuration directory called `.clojure`, which [by default](https://clojure.org/reference/deps_and_cli#_deps_edn_sources) is placed in the root of the operating system user account directory, e.g. `$HOME/.clojure`.

`XDG_CONFIG_HOME` may be set by your operating system and over-rides the default location, e.g. `$HOME/.config/.clojure`

`CLJ_CONFIG` can be used to over-ride all other location settings

> Check the location of your Clojure configuration directory by running `clojure -Sdescribe` and checking the `:user-config` value.


Fork the practicalli/clojure-deps-edn repository and clone your fork to an existing `.clojure/` directory (eg. `$HOME/.clojure` or `%HOME%\.clojure`).

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

The versions of libraries are manually updated at least once per month using the `:outdated` alias and a new version of the `deps.edn` file pushed to this repository.
```shell
cd ~/.clojure/
clojure -M:project/outdated
```

# Common development tasks
How to run common tasks for Clojure development.
* Built-in tasks require no additional configuration.
* User aliases should be added to `~/.clojure/deps.edn`.
* Project aliases should be added to the individual project deps.edn file (or may be part of a template).
* User/Project alias can be defined in both user and project deps.edn files (typically added to project deps.edn for external running such as Continuous Integration)

| Task                                                    | Command                                                         | Configuration      |
|---------------------------------------------------------|-----------------------------------------------------------------|--------------------|
| Create project (clojure exec)                           | `clojure -X:project/new :template app :name practicalli/my-app` | User alias         |
| Run REPL (rebel readline)                               | `clojure -M:repl/rebel`                                         | User alias         |
| Run REPL (rebel and nrepl)                              | `clojure -M:repl/rebel-nrepl`                                   | User alias         |
| Run REPL (rebel and reveal data visualization)          | `clojure -M:repl/rebel-reveal`                                  | User alias         |
| Download dependencies                                   | `clojure -Spath` or `clojure -P`  (plus optional aliases)       | Built-in           |
| Find libraries (mvn & git)                              | `clojure -M:project/find-deps library-name`                     | User alias         |
| Generate image of project dependency graph              | `clojure -X:project/graph-deps`                                 | User alias         |
| Check for new dependency versions                       | `clojure -M:project/outdated`                                   | User alias         |
| Run tests                                               | `clojure -M:test/runner`                                        | User/Project alias |
| Run the project                                         | `clojure -M -m domain.main-namespace`                           | Built-in           |
| [Run the project](https://youtu.be/u5VoFpsntXc?t=2166)* | `clojure -X:project/run`                                        | Project alias      |
| Package library                                         | `clojure -X:project/jar`                                        | User/Project alias |
| Deploy library locally                                  | `clojure -X:deps mvn-install`                                   | Built-in           |
| Package application                                     | `clojure -X:project/uberjar`                                    | User/Project alias |

> Add alias `:project/run` to the deps.edn file in the root of a project: `:project/run {:ns-default domain.namespace :exec-fn -main}` - see this video for an example https://youtu.be/u5VoFpsntXc?t=2166

> Most aliases use the `-M` flag.  Only use the `-X` flag when you know it is supported by that task


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
* `repl/reveal-nrepl` - run terminal UI REPL, Reveal data visualization, with nrepl connection for editor connections (eg. CIDER, Calva, Conjure)
* `repl/reveal-light-nrepl` - as above with light theme
* `:env/dev` include `dev/` in classpath to [configure REPL startup actions using `dev/user.clj`](http://practicalli.github.io/clojure/clojure-tools/configure-repl-startup.html)

| Command                            | Description                                                                                                    |
|------------------------------------|----------------------------------------------------------------------------------------------------------------|
| `clojure -M:repl/rebel`            | Run a Clojure REPL using Rebel Readline                                                                        |
| `clojure -M:alias:repl/rebel`      | Run a Clojure REPL using Rebel Readline, including deps and path from alias                                    |
| `clojure -M:env/dev:repl/rebel`    | Run a Clojure REPL using Rebel Readline, including deps and path from `:env/dev` alias to configure REPL start |
| `clojure -M:repl/rebel-cljs`       | Run a ClojureScript REPL using Rebel Readline                                                                  |
| `clojure -M:alias:repl/rebel-cljs` | Run a ClojureScript REPL using Rebel Readline, including deps and path from alias                              |
| `clj -M:repl/reveal-nrepl`         | Run a Clojure REPL with Reveal data visualization and nREPL interactively                                     |
| `clj -M:repl/reveal-light-nrepl`   | Run a Clojure REPL with Reveal data visualization (light theme) and nREPL interactively                        |


`:repl/help` in the REPL for help and available commands.  `:repl/quit` to close the REPL.


## Alternative REPLs
Clojure 1.10.x onward can [run a Socket Server](https://clojure.org/reference/repl_and_main#_launching_a_socket_server) for serving a socket-based REPL (Clojure and ClojureScript).  [tubular](https://github.com/mfikes/tubular) is a Socket Server client for Clojure and Clojurescript REPLs.

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
Then the project can be run using `clojure -X:project/run` and arguments can optionally be included in this command line, to complement or replace any default aruments in `exec-args`.

## Project dependencies

* [`:project/check`](https://github.com/athos/clj-check.git) - detailed report of compilation errors for a project
* [`:project/graph-deps`](https://github.com/clojure/tools.deps.graph) - graph of project dependencies (png image)
* [`:project/find-deps`](https://github.com/hagmonk/find-deps) - fuzzy search for libraries to add as dependencies
* [`:project/outdated`](https://github.com/liquidz/antq) - report newer versions for maven and git dependencies
* [`:project/outdated-mvn`](https://github.com/slipset/deps-ancient) - check for newer dependencies (maven only)

| Command                                              | Description                                                          |
|------------------------------------------------------|----------------------------------------------------------------------|
| `clojure -M:project/outdated`                        | report newer versions for maven and git dependencies                 |
| `clojure -M:project/outdated-mvn`                    | check for newer dependencies (maven only)                            |
| `clojure -M:project/check`                           | detailed report of compilation errors for a project                  |
| `clojure -M:project/find-deps library-name`          | fuzzy search Maven & Clojars                                         |
| `clojure -M:project/find-deps -F:merge library-name` | fuzzy search Maven & Clojars and save to project deps.edn            |
| `clojure -X:project/graph-deps`                      | generate png image of project dependencies from projet deps.edn file |
| `clojure -M:project/outdated`                        | report newer versions for maven and git dependencies                 |
| `clojure -M:project/outdated-mvn`                    | check for newer dependencies (maven only)                            |


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


### Reveal data inspector and visualization tool
[Reveal](https://vlaaad.github.io/reveal/) - run a Terminal REPL with data visualisation or connect with nREPL, socket or prepl connection and use from any [Clojure aware editor]([Clojure aware editors](https://practicalli.github.io/clojure/clojure-editors/)).
Reveal can also used as a `tap>` source for more powerful manual debugging.

* `:inspect/reveal` - visualisation with terminal REPL.
* `:inspect/reveal-light` - as above with light theme and 32 point Ubuntu Mono font
* `:inspect/reveal-nrepl` - visualization for [Clojure aware editors](https://practicalli.github.io/clojure/clojure-editors/) via an nrepl server
* `:inspec/reveal-light-nrepl` - as above with light theme and 32 point Ubuntu Mono font
* `:inspect/reveal-nrepl-cider` - visualization tool for Emacs Cider / Spacemacs / VSCode Calva
* `:inspec/reveal-light-nrepl-cider` - as above with light theme and 32 point Ubuntu Mono font

| Command                                       | Description                                                                        |
|-----------------------------------------------|------------------------------------------------------------------------------------|
| `clojure -M:inspect/reveal`                   | start a Reveal repl with data visualization window (cloure.main)                   |
| `clojure -M:inspect/reveal-light`             | as above with light theme and large font                                           |
| `clojure -X:inspect/reveal`                   | start a Reveal repl with data visualization window (clojure exec)                  |
| `clojure -X:inspect/reveal-light`             | as above with light theme and large font                                           |
| `clojure -M:inspect/reveal-nrepl`             | Start nrepl server to use Cider / Calva editors with reveal                        |
| `clojure -X:inspect/reveal-light-nrepl`       | as above with light theme and large font                                           |
| `clojure -M:inspect/reveal-rebel`             | Start a Rebel REPL with Reveal Visualizations                                      |
| `clojure -M:inspect/reveal-light-rebel`       | Start a Rebel REPL with Reveal Visualizations & light theme                        |
| `clojure -M:inspect/reveal:repl/rebel`        | Start a Rebel REPL with Reveal dependency. Add reveal as tap> source               |
| `clojure -M:inspect/reveal-light:repl/rebel** | Start a Rebel REPL with Reveal dependency & light theme. Add reveal as tap> source |

**Connecting nREPL based editors**
Use the `:inspect/reveal-nrepl` alias when running the REPL, either in the terminal or via an nREPL based editor (CIDER, Calva, Conjure, Cursive, etc.)

Alternatively, add an `.nrepl.edn` file to the root of a project to include the Reveal middleware
```
{:middleware [vlaaad.reveal.nrepl/middleware]}
```

**Cider jack-in and reveal**
See the [Reveal section of Practicalli Clojure](https://practicalli.github.io/clojure-staging/clojure-tools/data-browsers/reveal.html#using-reveal-with-nrepl-editors) for full details, including how to set up a `.dir-locals.el` configuration.

`:inspect/reveal-nrepl-cider` alias contains Reveal REPL with nrepl server and Emacs CIDER specific middleware

`C-u cider-jack-in-clj` in CIDER to start a reveal REPL  (`SPC u , '` in Spacemacs)

Edit the jack-in command by deleting the all the configuration after the `clojure` command and add the alias
```
clojure -M:inspect/reveal-nrepl-cider
```

`:inspect/reveal-nrepl-cider` is a light version of the above.


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

> Cognitect REBL aliases requires [several separate install steps](http://practicalli.github.io/clojure/alternative-tools/clojure-tools/cognitect-rebl.html) before they are operational
>
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

Run a REPL on the command line for access by `cider-connect-` commands, providing the require cider middleware libraries that are auto-injected in `ccider-jack-in-` commands.

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

| Command                                     | Description                                                                                |
|---------------------------------------------|--------------------------------------------------------------------------------------------|
| `clojure -M:test/cognitect`                 | Cognitect Clojure test runner                                                              |
| `clojure -M:test/cljs`                      | ClojureScript test runner (Olical)                                                         |
| `clojure -M:test/runner`                    | Kaocha - comprehensive test runner for Clojure (same as :test/kaocha)                      |
| `clojure -M:env/test:test/kaocha`           | Kaocha - comprehensive test runner for Clojure                                             |
| `clojure -M:env/test:test/kaocha-cljs`      | Kaocha - comprehensive test runner for ClojureScript                                       |
| `clojure -M:env/test:test/kaocha-cucumber`  | Kaocha - comprehensive test runner with BDD Cucumber tests                                 |
| `clojure -M:env/test:test/kaocha-junit-xml` | Kaocha - comprehensive test runner with Junit XML reporting for CI dashboards & wallboards |
| `clojure -M:env/test:test/kaocha-cloverage` | Kaocha - comprehensive test runner with test coverage reporting                            |
| `clojure -M:test/midje`                     | Midje test runner for BDD style tests                                                      |
| `clojure -M:test/eftest`                    | Fast Clojure test runner, pretty output, parallel tests                                    |
| `clojure -M:test/coverage`                  | Cloverage clojure.test coverage report                                                     |
| `clojure -X:test/coverage`                  | Cloverage clojure.test coverage report (clojure exec)                                      |

#### Compiling tests before running - automate Ahead of Time compilation
Use one of the test runner alias and over-ride the :main-opts on the command line
```shell
clojure -M:test/cognitect -e "(compile, 'your.namespace)" -m cognitect.test-runner
```

Or add the following alias in your project `deps.edn`, changing to the specific namespace in `:main-opts` before use
```clojure
  :test/cognitect-precompile
  {:extra-paths ["test"]
   :extra-deps  {com.cognitect/test-runner
                 {:git/url "https://github.com/cognitect-labs/test-runner.git"
                  :sha     "b6b3193fcc42659d7e46ecd1884a228993441182"}}
   :main-opts   ["-e" "(compile,'your.namespace-here)"
                 "-m" "cognitect.test-runner"]}
```


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

## Community activities
The [Clojurians Zulip CLI](https://gitlab.com/clojurians-zulip/feeds/-/blob/master/README.md#announce-an-event) provides a simple way to register community events.

* `:community/zulip-event` create an event on the Clojurians Zulip community

Set an environment variable called ZULIP_AUTH to your account email, followed by
the account token (in settings), e.g.

```
your@email.com:493u984u3249834uo4u
```
Create an event using the following command

```
clojure -M:community/zulip-event create --zulip-auth "${ZULIP_AUTH}" --title 'Practicalli Live - Exercism.io challenges' --start '2020-11-14T09:00+00:00' --duration 1 --url https://youtu.be/Z5C7X1UN8yo --description 'Walking through solutions to the Exercism.io challenges'
```

Take care to get the timezone notation correct.


---


## Experimental / Alpha Aliases

* [`:alpha/carve`](https://github.com/borkdude/carve) - EXPERIMENTAL, use with caution - carve out unwanted vars in code
* [`:alpha/hotload-libs`](https://github.com/clojure/tools.deps.alpha) - EXPERIMENTAL, use with caution - hot-load libraries into a running namespace.


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
