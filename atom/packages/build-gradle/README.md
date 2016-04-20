# Gradle runner for Atom
[![Build Status](https://travis-ci.org/AtomBuild/atom-build-gulp.svg?branch=master)](https://travis-ci.org/AtomBuild/atom-build-gradle)
[![Gitter chat](https://badges.gitter.im/noseglid/atom-build.svg)](https://gitter.im/noseglid/atom-build)

Uses the [atom-build](https://github.com/noseglid/atom-build) package to execute
gradle builds in the `Atom` editor.

This package requires [atom-build](https://github.com/noseglid/atom-build) to be installed.

## Capabilities

  * Support for gradle wrapper.
  * Support target extraction. Will run `gradle tasks` or `./gradlew tasks` to retrieve tasks.
  * Will refresh tasks automatically if you alter the gradle file.
