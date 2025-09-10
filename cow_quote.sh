#!/bin/bash
#
# Time-stamp: <Monday 2025-02-24 19:53:01 Jess Moore>
#
# Cowsay/cowthink sourcing fortune and user quotes.json
#
# Usage: cow_quote.sh

# shellcheck disable=SC2012,SC2001 # Disable preference for find over ls

function usage() {
    echo "Usage: cow_quote.sh [-s source] [-o own_quote_source]"
    echo ""
    echo "Description: Displays quote sourced from own data source or fortune"
    echo "source rendered in the thought or speech bubble of a random animal"
    echo "with cowsay/cowthink."
    echo ""
    echo "Examples:"
    echo "1: To retrieve random quote from fortune:"
    echo "   bash cow_quote.sh -s fortune"
    echo ""
    echo "2: To retrieve random quote from own json quotes file:"
    echo "   bash cow_quote.sh -s own -o json"
    echo ""
    echo "3: To retrieve random quote from own quotes db:"
    echo "   bash cow_quote.sh -s own -o db"
    echo ""
    echo "Arguments:"
    echo "  -o own_quote_source: Source of owned quotes. One of 'json' or 'db'"
    echo "                       (Default: 'db')."
    echo "  -s source:           Chosen source, one of 'own' or 'fortune'. "
    echo "                       (Optional). By default source is randomly chosen."
    echo ""
    exit 1 # Exit with a non-zero status to indicate an error
}

if [[ $* == *"help"* || $* == *"-h"* ]]; then
    usage
fi

QUOTE_FILE=~/quotes.json
OWN_QUOTE_SOURCE=db

# Parse arguments and flags
while getopts :ho:s: opt; do
    case $opt in
        h) usage;;
        o) OWN_QUOTE_SOURCE="$OPTARG";;
        s) QUOTE_TYPE_SEL="$OPTARG";;
        :) echo "Missing argument for option -$OPTARG"; exit 1;;
       \?) echo "Unknown option -$OPTARG"; exit 1;;
    esac
done

shift $(( OPTIND - 1 ))

# Locations of cow commands and data
OS=$(uname)
case "${OS}" in
'Linux')
    COWS_DIR="/opt/homebrew/share/cowsay/cows";
    COWS_BIN="/usr/games";;
'Darwin')
    COWS_DIR="$(brew --prefix)/share/cowsay/cows";
    COWS_BIN="$(brew --prefix)/bin";;
*)
    echo "Supported operating systems: Linux, Darwin. Not";
    exit 1;;
esac

# Randomly choose the quote source if not specified on commandline
if [[ -z $QUOTE_TYPE_SEL ]]; then

    declare -a QUOTE_TYPES=("fortune" "own")
    QUOTE_TYPE_SEL="${QUOTE_TYPES[$RANDOM % 2]}"

fi

# Fetch and format quote
case "${QUOTE_TYPE_SEL}" in
'own')

    case "${OWN_QUOTE_SOURCE}" in
    'json')

        if [ -f ${QUOTE_FILE} ]; then

            # Random quote and author from user's quotes.json
            QUOTE_MY="$(cat $QUOTE_FILE  | jq -c '.[] | [.quote, .author]' | shuf -n 1 | sed 's/[][]//g')"
            # Format author below quote
            QUOTE_MY=$(echo "$QUOTE_MY" | sed 's/"\s*,\s*"/"\n\n--"/g')
            # Remove surrounding double quote marks
            QUOTE_MY=$(echo "$QUOTE_MY" | sed 's/"//g')

            QUOTE_SEL=$QUOTE_MY
            SOURCE_SEL="\n(Source: ~/quotes.json)."

        else

            echo "Error: quote file ${QUOTE_FILE} not found. Using fortune instead."
            echo ""
            QUOTE_SEL="$(fortune)"
            SOURCE_SEL="\n(Source: fortune quotes).";

        fi;;

    'db')

        # Check get_quote command exists to retrieve quote from
        # quote db
        if command -v get_quote >/dev/null 2>&1; then

            QUOTE_SEL=$(get_quote)
            SOURCE_SEL="\n(Source: quotes db).";

        else

            echo "Error: 'db' option requires 'get_quote' from quote_engine. Using fortune instead."
            echo ""
            QUOTE_SEL="$(fortune)"
            SOURCE_SEL="\n(Source: fortune quotes).";

        fi;;
    *)

        echo "Error: supported own quote sources: json, db";
        echo ""
        usage;;

    esac;;

'fortune')

    # Random quote from fortune
    QUOTE_SEL="$(fortune)"
    SOURCE_SEL="\n(Source: fortune quotes).";;

*)

    echo "Error: supported quote source types: own, fortune";
    echo ""
    usage;;

esac


# Output quote as cowsay/cowthink using all "cow" animals
echo "${QUOTE_SEL}" | $(ls "${COWS_BIN}"/cow* | shuf -n 1) -f "$(ls "${COWS_DIR}" | shuf -n 1)"

echo -e "${SOURCE_SEL}"
