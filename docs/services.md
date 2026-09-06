---
icon: lucide/server
---

# Services

Web servers and other standalone services run with Clojure CLI

* `:service/http` - serve files from current directory or specified directory and port.  More options at [kachayev/nasus project](https://github.com/kachayev/nasus).

| Command                                   | Description                                         |
|-------------------------------------------|-----------------------------------------------------|
| `clojure -M:service/http`                 | HTTP file server for current directory on port 8000 |
| `clojure -M:service/http 8888`            | as above with PORT specified to 8888                |
| `clojure -M:service/http 8888 --dir docs` | as above with PORT 8888 and doc directory           |

> Use `Ctrl-c` to stop the server when running in the foreground


## Databases and drivers

Databases and drivers, typically for development time inclusion such as embedded databases

* `:database/h2` - H2 embedded database library and next.jdbc

`clojure -M:database/h2` - [run a REPL with an embedded H2 database and next.jdbc libraries](https://cljdoc.org/d/seancorfield/next.jdbc/CURRENT/doc/getting-started#create--populate-a-database)

Use the aliases with either `-M` or `-X` flags on the Clojure command line.


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
