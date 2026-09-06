---
icon: lucide/bug
---

# Debug Tools

Emacs CIDER has a built in debug tool that requires no dependencies (other than Cider itself).

[Sayid](https://github.com/clojure-emacs/sayid) is a comprehensive debug and profile tool (which requires your code to compile) and generated a full and detailed history of an evaluation.

* `:repl/debug` run basic REPL prompt with sayid, and cider-nrepl middleware
* `:repl/debug-refactor` run basic REPL prompt with sayid, clj-refactor and cider-nrepl middleware
* `:repl/rebel-debug` run Rebel rich UI REPL prompt with sayid, and cider-nrepl middleware
* `:repl/rebel-debug-refactor` run Rebel rich UI REPL prompt with sayid, clj-refactor and cider-nrepl middleware

[Practicalli Spacemacs - Sayid debug and profile tool](https://practical.li/spacemacs/debug-clojure/sayid-debug/) covers the use of these aliases in more detail
