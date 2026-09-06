---
icon: lucide/terminal
---

# REPL terminal UI

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


## Remote REPL connection

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


## Environment

Environment settings and libraries to support REPL driven development

* `:dev/env` - add `dev` directory to class path - e.g. include `dev/user.clj` to [configure REPL startup](https://practical.li/clojure/clojure-cli/repl-startup/)
* `:dev/reloaded` - reloaded workflow, `dev` and `test` paths, testing libraries
* `:lib/hotload` - include `org.clojure/tools.deps.alpha` add-libs commit to [hotload libraries into a running REPL](https://practical.li/clojure/clojure-cli/repl-reloaded/)
* `:lib/tools-ns` - include `org.clojure/tools.namespace` to refresh the current namespace in a running REPL
* `:lib/reloaded` - combination of hotload and tools-ns aliases
* `:lib/pretty-errors` - highlight important aspects of error stack trace using ANSI formatting
