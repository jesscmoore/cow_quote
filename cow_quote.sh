#!/bin/bash
#
# Time-stamp: <Monday 2025-02-24 19:53:01 Jess Moore>
#
# Cowsay/cowthink sourcing fortune and user quotes.json
#
# Usage: cow_quote.sh

# shellcheck disable=SC2012 # Disable preference for find over ls

QUOTE_FILE=~/quotes.json

OS=$(uname)
case "${OS}" in
'Linux')
    COWS_DIR="/opt/homebrew/share/cowsay/cows";
    COWS_BIN="/usr/games";;
'Darwin')
    COWS_DIR="$(brew --prefix)/share/cowsay/cows";
    COWS_BIN="$(brew --prefix)/bin";;
*)
    echo "Supported operating systems: Linux, Darwin. Not";;
esac


# Random quote from fortune and my quotes.json
# Get quote from fortune
QUOTE_FORT="$(fortune)"

declare -a QUOTE_TYPES=("fortune" "own")
QUOTE_TYPE_SEL="${QUOTE_TYPES[$RANDOM % 2]}"
echo "Quote type selected: ${QUOTE_TYPE_SEL}"

if [ -f ${QUOTE_FILE} ] && [ "${QUOTE_TYPE_SEL}" == "own" ]; then

    # Random quote and author from user's quotes.json
    QUOTE_MY="$(cat $QUOTE_FILE  | jq -c '.[] | [.quote, .author]' | shuf -n 1 | sed 's/[][]//g')"

    QUOTE_SEL=$QUOTE_MY
    SOURCE_SEL="\n(Source: ~/quotes.json)."

else

    QUOTE_SEL=$QUOTE_FORT
    SOURCE_SEL="\n(Source: fortune quotes)."

fi

# Output quote as cowsay/cowthink using all "cow" animals
echo "${QUOTE_SEL}" | $(ls "${COWS_BIN}"/cow* | shuf -n 1) -f "$(ls "${COWS_DIR}" | shuf -n 1)"

echo -e "${SOURCE_SEL}"
