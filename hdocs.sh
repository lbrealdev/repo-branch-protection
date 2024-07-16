#!/bin/bash

#set -euo pipefail

ORG_LOGIN="test"
GITHUB_TOKEN="$GITHUB_AUTH_TOKEN"

ORG_ID_QUERY=$(cat <<EOF
{
  "query": "query {
    organization(login: \\"$ORG_LOGIN\\") {
      id
    }
  }"
}
EOF
)

function fetch_repos() {
  after_cursor="$1"
  repos_query=""
}

#curl -sL \
#  -H "Accept: application/vnd.github+json" \
#  -H "Authorization: Bearer $GITHUB_TOKEN" \
#  -H "X-Github-Next-Global-ID: 1" \
#  https://api.github.com/graphql \
#  -d "$ORG_ID_QUERY" | \
#  jq -r '.'

query="{ \"query\": \"query GetReposFromOrg(\"owner\": String!) { organization(login: \"owner\") { id name login description resourcePath createdAt repositories(first: 100, after: null) { nodes { id name } pageInfo { endCursor hasNextPage } } }}\" }"

echo "$query" | jq .