---
icon: lucide/test-tube-diagonal
---

# Testing

[Unit tests](#unit-tests) can be run via the current REPL session and/or an external [test runner](#test-runners).

Test coverage reports show how much of the code has unit test coverage.

[Performance testing](#performance-testing) helps select appropriate functions and algorithms to used by timing multiple calls and reporting the results.  The choice of function can have a significant effect on the critical paths in the code.


## Unit tests

Unit test libraries and configuration.  The Clojure standard library includes the `clojure.test` namespace, so no alias is required.

* `:env/test` - add `test` directory to classpath


## Test runners

[Practicalli Clojure: Unit testing](https://practical.li/clojure/testing/) covers many aspects of testing for projects.

Kaocha is the main test runner used by Practicalli as it is simple to use and easily configurable to create an effective test workflow.

Run unit tests in a project which are defined under the `test` path.

| Command                     | Description                                                                               |
|-----------------------------|-------------------------------------------------------------------------------------------|
| `clojure -X:test/run`       | run tests with the Kaocha comprehensive test runner for Clojure (same as :test/kaocha)    |
| `clojure -X:test/watch`     | run tests in watch mode using Kaocha test runner for Clojure (same as :test/kaocha-watch) |
| `clojure -X:test/cognitect` | Cognitect Clojure test runner                                                             |
| `clojure -X:test/coverage`  | Cloverage clojure.test coverage report                                                    |
| `clojure -M:test/cljs`      | ClojureScript test runner (Kaocha)                                                        |

`:lib/kaocha` alias adds kaocha as a library to the class path, enabling scripts such as kaocha-runner.el to run Kaocha test runner from Emacs Cider

> A `test.edn` [configuration file](https://cljdoc.org/d/lambdaisland/kaocha/1.77.1236/doc/3-configuration) can be used with the :test/run alias instead of using various aliases defined above


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
