Word Count
==========

This package aims to count the top 100 of three words sequences of a given file.

[![Elixir version][shield-elixir]](#)

[shield-elixir]: https://img.shields.io/badge/elixir-v1.13.0-blue.svg

Table of Contents
-----------------

  * [Requirements](#requirements)
  * [Installation](#installation)
  * [Usage](#usage)
  * [Contributing](#contributing)
  * [Support and Migration](#support-and-migration)
  * [License](#license)

Requirements
------------

Word Count requires the following to run:

  * [Elixir][elixir] 1.13.0

[elixir]: https://elixir-lang.org/install.html


Installation
-----

### Step 1: Get sources from GitHub
```sh
git clone git@github.com:josemimbre/word_count.git
cd word_count
```

### Step 2: Get dependencies and build the escript
```sh
mix deps.get
mix escript.build
```

Usage
-----

```sh
./word_count file_to_read
cat file_to_read | ./word_count
```

Testing
-----

```sh
$ mix test
```
## To Dos