# README

<!-- markdownlint-disable-file MD001 MD029 MD036 MD041 -->

Runs cow_quote to render fortune or my quote as cowsay or cowthink stdout graphic.

*Author: Jess Moore*

## Dependencies

Required packages:

- fortune - package of quotes
- cowsay - package comprising cowsay and cowthink which render text as speech or thought bubble of random animal

Quote data sources:

- fortune
- ~/quotes.json

Uses fortune if ~/quotes.json does not exist.

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
