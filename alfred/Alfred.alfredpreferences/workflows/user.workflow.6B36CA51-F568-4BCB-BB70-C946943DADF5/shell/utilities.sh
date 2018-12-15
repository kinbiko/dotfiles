#!/usr/bin/env bash

###############################################################################
# Author: M. Oranje
# Licence: MIT
###############################################################################

STRING="[^\"]*"
NUMBER="-?[0-9]+([.][0-9]+)?"
BOOLEAN="true|false"

function json_create () {
  string="$1"
  # Regex that matches the last item and the closing bracket of the root object
  regex="({\".+)(}$)"
  if [[ $string =~ $regex ]]
  then
    prefix=${BASH_REMATCH[1]}
    postfix=${BASH_REMATCH[2]}
    if [[ "$3" == "$NUMBER" || "$3" == "$BOOLEAN" ]]
    then
      echo "$prefix, \"$2\": $3$postfix"
    else
      echo "$prefix, \"$2\": \"$3\"$postfix"
    fi
  else
    if [[ $3 =~ $NUMBER || $3 =~ $BOOLEAN ]]
    then
      echo "{\"$2\": $3}"
    else
      echo "{\"$2\": \"$3\"}"
    fi
  fi
}

function json_find () {
  string="$1"
  regex_string="\"$2\": *\"($STRING)\",?"
  regex_number="\"$2\": *($NUMBER)"
  regex_boolean="\"$2\": *($BOOLEAN)"
  if [[ $string =~ $regex_string ]]
  then
    echo "${BASH_REMATCH[1]}" | xargs
  elif [[ $string =~ $regex_number ]]
  then
    echo "${BASH_REMATCH[1]}" | xargs
  elif [[ $string =~ $regex_boolean ]]
  then
    echo "${BASH_REMATCH[1]}" | xargs
  else
    echo "FALSE"
  fi
}

function json_update () {
  string="$1"
  regex_string="(.+)\"$2\": *\"$STRING\"(,?.+)"
  regex_number="(.+)\"$2\": *$NUMBER(,?.+)"
  regex_boolean="(.+)\"$2\": *$BOOLEAN(,?.+)"
  if [[ $string =~ $regex_string ]]
  then
    echo "${BASH_REMATCH[1]}\"$2\": \"$3\"${BASH_REMATCH[2]}"
  elif [[ $string =~ $regex_number || $string =~ $regex_boolean ]]
  then
    echo "${BASH_REMATCH[1]}\"$2\": $3${BASH_REMATCH[2]}"
  else
    echo "Error: Key ($2) not present in JSON, use create() to add new keys"
  fi
}

function string_update() {
  local string="$1"
  local regex="$2"
  if [[ $string =~ $regex ]]
  then
    echo "${BASH_REMATCH[1]}$3${BASH_REMATCH[2]}"
  else
    echo "$string"
  fi
}

function version_patch() {
  version="$1"
  regex_string="[0-9]+.[0-9]+.([0-9]+)"
  if [[ $version =~ $regex_string ]]
  then
    echo "${BASH_REMATCH[1]}"
  else
    echo "Not a valid semver string"
  fi
}

function version_minor() {
  version="$1"
  regex_string="[0-9]+.([0-9]+).[0-9]+"
  if [[ $version =~ $regex_string ]]
  then
    echo "${BASH_REMATCH[1]}"
  else
    echo "Not a valid semver string"
  fi
}
function version_major() {
  version="$1"
  regex_string="([0-9]+).[0-9]+.[0-9]+"
  if [[ $version =~ $regex_string ]]
  then
    echo "${BASH_REMATCH[1]}"
  else
    echo "Not a valid semver string"
  fi
}
