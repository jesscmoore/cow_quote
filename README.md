# README <!-- omit in toc -->

<!-- markdownlint-disable-file MD001 MD029 MD036 MD041 -->

Runs cow_quote to render random quote from fortune or my quote source as a cowsay or cowthink stdout graphic.

*Author: Jess Moore*

## Contents <!-- omit in toc -->

- [Dependencies](#dependencies)
- [Install](#install)
- [Options](#options)

## Dependencies

Required packages:

- `fortune` - package of quotes
- `cowsay` - package comprising cowsay and cowthink which render text as speech or thought bubble of random animal

Quote data sources:

- fortune
- quotes db (requires quote_engine repo to run quotes db in docker container)
- `$QUOTE_FILE` specified in `cow_quote.sh` (for format use template `quote_template.json`)

Quotes db is the default quote source if own quote type is selected. However, `cow_quote.sh` defaults to source the quote from fortune if quotes db fetch command `get_quote` not found, or if quote json selected and file not found.

## Install

Symlink cow_quote.sh to somewhere in your $PATH

```bash
chmod u+x cow_quote.sh
ln -s cow_quote.sh ~/bin/cow_quote
```

Add below to your ~/.zshrc or other shell config file to run `cow_quote` when a new terminal is opened.

```bash
# Requires: scripts/cow_quote.sh installed in ~/bin
cow_quote
```

## Options

To source a quote from quotes db use:

```bash
cow_quote -s own -o db
```

To source a quote from quotes json file use:

```bash
cow_quote -s own -o json
```

To source a quote from fortune quotes:

```bash
cow_quote -s fortune
```
