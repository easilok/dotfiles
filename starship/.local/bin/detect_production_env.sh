#!/usr/bin/env bash

# Initialize the output string
output=""

# Store the result of filtering DB and rds.amazon into a variable
database_env_vars=$(printenv | grep -E "DB" | grep -E "rds\.amazon")

# Check if any environment variables match the DB and rds.amazon criteria
if [[ -n "$database_env_vars" ]]; then
  # Now check for "ro" in the filtered variables and append to output if found
  if echo "$database_env_vars" | grep -q "ro"; then
    output="$output  RO"
  fi

  # Now check for "rw" in the filtered variables and append to output if found
  if echo "$database_env_vars" | grep -q "rw"; then
    output="$output  RW"
  fi

  # Now check for "admin" in the filtered variables and append to output if found
  if echo "$database_env_vars" | grep -q "admin"; then
    output="$output  ADMIN"
  fi
fi

# Check Sendgrid key
if [[ ! -z $SENDGRID_API_KEY ]]; then
    output="$output  SENDGRID"
fi

# Store the result of filtering opensearch env vars
opensearch_env_vars=$(printenv | grep -E "AWS_SECRET_ACCESS|search-engine.*\.amazonaws.com")
# Check if any environment variables match the DB and rds.amazon criteria
if [[ -n "$opensearch_env_vars" ]]; then
    output="$output  SE"
fi

echo "$output"
