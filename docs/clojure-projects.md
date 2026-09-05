# Clojure Projects

Create Clojure CLI configured projects, either built-in or [practicalli/project-templates](https://github.com/practicalli/project-templates) to provide [REPL Reloaded tools](https://practical.li/clojure/clojure-cli/repl-reloaded/) and production-level CI workflows.

Default values (can be over-ridden on the command line)

- `:template project/application` template, includes REPL Reloaded workflow, GitHub workflows, Dockerfile & compose.yaml, Makefile tasks
- `:name practicalli/playground` creates a practicalli domain containing `playground` namespace and example Clojure code

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


## Running projects

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

## Project packaging

[tools.build](https://practical.li/clojure/clojure-cli/projects/tools-build/) is a library for creating scripts to manage packaging the projects to a fine level of control.  Projects start with common tasks for builind a jar or uberjar from the project.


## Project Deployment

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

Requires: Java sources installed locally (e.g. `"/usr/lib/jvm/openjdk-21/lib/src.zip"`)

* `:src/java21`
* `:src/clojure`

Use the aliases with either `-A`, `-M` or `-X` execution options on the Clojure command line.

> Clone [clojure/clojure](https://github.com/clojure-expectations/clojure-test) repository. Clojure core Java source code in [src/jvm/clojure/lang/](https://github.com/clojure/clojure/tree/master/src/jvm/clojure/lang "GitHub: Clojure core Java source code")


## Clojure Specification

Clojure spec, generators and test.check

* `:lib/spec-test` - generative testing with Clojure test.check
* `:lib/spec2` - experiment with the next version of Clojure spec - alpha: design may change


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


## Security

`:security/nvd-scan` and `:security/ndv-fix` adds [clj-watson](https://github.com/clj-holmes/clj-watson) tool

The alias requires an [API Key to access the NIST National Vulnerability Database (NVD)](https://nvd.nist.gov/developers/request-an-api-key).

`CLJ_WATSON_NVD_API_KEY` environment variable should be set to the value of the API Key, e.g via `.bashrc` or `.zshenv` file.

| Command                        | Description                                                         |
|------------------------------- | ------------------------------------------------------------------- |
| `clojure -T:security/nvd-scan` | check all libraries on the class path for security vulnerabilities  |
| `clojure -T:security/nvd-fix`  | update all libraries on the class path for security vulnerabilities |

> [clj-watson-action](https://github.com/clj-holmes/clj-watson-action) can be used in a GitHub workflow to run security vulnerability checks
