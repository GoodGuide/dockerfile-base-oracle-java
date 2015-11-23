# goodguide/oracle-java:ubuntu-15.10

This is a Docker base image with Oracle JDK, built upon Ubuntu Linux 15.10 using the image `goodguide/base:ubuntu-15.10`.

It's canonical registry is on [Quay.io as goodguide/oracle-java](https://quay.io/repository/goodguide/oracle-java) -- see the tags listed there for available versions.

## Updating

Any git tag pushed to this repo will be built on Quay, resulting in a tag of the same name being made available at the above Quay repo. Please use the following format for git tags:

```
#{OS}-#{OS_VERSION}-java-#{JAVA_VERSION}.#{JAVA_UPDATE_VERSION}[.#{JAVA_BUILD}]-#{TAG_SERIAL}
```
(Where the `JAVA_BUILD` should only be specified if it was used in the Dockerfile explicitly)

`TAG_SERIAL` is a 0-based index to differentiate images which are different in build process or some other aspect of the Dockerfile, but constitute the same Java version. In this way, any referenced Git/Docker tag can be counted on to exist forever, but we can push updates to a given Java version if needed and consumer can update when convenient.

[![Docker Repository on Quay](https://quay.io/repository/goodguide/oracle-java/status "Docker Repository on Quay")](https://quay.io/repository/goodguide/oracle-java)
