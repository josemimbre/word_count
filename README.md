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
  * [Testing](#testing)
  * [To Do](#to-do)

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
### With docker

```sh
docker build . -t word_count
```

Usage
-----

The program can be run in three ways:

### With args
```sh
./bin/word_count file_1.txt file_2.txt
```

### With stdin content
```sh
cat file_to_read | ./bin/word_count
```

### With docker
```sh
docker run -it --read-only -v files_path:/app/files word_count files/file_1.txt
```

Testing
-----

To run the test of the program you need to run:

```sh
$ mix test
```

To Do
-----

For a list of the future improvements that the program will have we have created a list of issues and bugs to keep track of those developments

* [All Issues](https://github.com/josemimbre/word_count/issues)
* [Enhancements](https://github.com/josemimbre/word_count/issues?q=is%3Aissue+is%3Aopen+label%3Aenhancement)
* [Bugs](https://github.com/josemimbre/word_count/issues?q=is%3Aissue+is%3Aopen+label%3Abug)