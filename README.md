# README <!-- omit in toc -->

<!-- markdownlint-disable-file MD001 MD029 MD036 MD041 -->

Runs cow_quote to render fortune or my quote as cowsay or cowthink stdout graphic.

*Author: Jess Moore*

## Contents <!-- omit in toc -->

- [Dependencies](#dependencies)
- [Install](#install)
- [Options](#options)

## Dependencies

Required packages:

- fortune - package of quotes
- cowsay - package comprising cowsay and cowthink which render text as speech or thought bubble of random animal

Quote data sources:

- fortune
- quotes db (requires quote_engine repo to run quotes db in docker container)
- ~/quotes.json

Quotes db is the default quote source if own quote type is selected. However, defaults to source quote from fortune if quotes db fetch command get_quote not found, or if quote json selected and file not found.

## Install

Symlink cow_quote.sh to somewhere in your $PATH

```bash
ln -s cow_quote.sh ~/bin/cow_quote
```

Add below to your ~/.zshrc or other shell config file which is sourced when new terminal is opened.

```bash
# Requires: scripts/cow_quote.sh installed in ~/bin
cow_quote
```

## Options

To source from quotes db use:

```bash
cow_quote -s own -o db
```

To source from quotes json use:

```bash
cow_quote -s own -o json
```

To source from fortune quotes:

```bash
cow_quote -s fortune
```
