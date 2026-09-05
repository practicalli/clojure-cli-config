# Data Inspectors

REPL driven data inspectors and `tap>` sources for visualising data.

## [Portal](https://github.com/djblue/portal)

Navigate data in the form of edn, json and transit
[Practicalli Clojure -data browsers section - portal](https://practical.li/clojure/data-inspector/portal/)

- `inspect/portal-cli` - Clojure CLI (simplest approach)
- `inspect/portal-web` - Web ClojureScript REPL
- `inspect/portal-node` - node ClojureScript REPL

| Command                          | Description                                           |
|----------------------------------|-------------------------------------------------------|
| `clojure -M:inspect/portal-cli`  | Clojure REPL with Portal dependency                   |
| `clojure -M:inspect/portal-web`  | ClojureScript web browser REPL with Portal dependency |
| `clojure -M:inspect/portal-node` | ClojureScript node.js REPL with Portal dependency     |


### Using Portal once running

`(require '[portal.api :as portal])` once the REPL starts.  For `inspect/portal-web` use `(require '[portal.web :as portal])` instead

`(portal/open)` to open the web based inspector window in a browser.

`(portal/tap)` to add portal as a tap target (add-tap)

`(tap> {:accounts [{:name "jen" :email "jen@jen.com"} {:name "sara" :email "sara@sara.com"}]})` to send data to the portal inspector window (or any other data you wish to send)

`(portal/clear)` to clear all values from the portal inspector window.

`(portal/close)` to close the inspector window.
