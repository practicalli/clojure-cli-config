# Library Repositories

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
