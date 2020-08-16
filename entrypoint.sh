#!/bin/sh

cd "$GITHUB_WORKSPACE"

export REVIEWDOG_GITHUB_API_TOKEN="${INPUT_GITHUB_TOKEN}"

cd "${GITHUB_WORKSPACE}/${INPUT_WORKDIR}" || exit 1

if [ ! -f "$(npm bin)/commitlint" ]; then
  npm install
fi

$(npm bin)/commitlint --version

commitlint \
  | reviewdog -efm="%f:%l:%c: %m" \
      -name="linter-name (misspell)" \
      -reporter="${INPUT_REPORTER:-github-pr-check}" \
      -filter-mode="${INPUT_FILTER_MODE}" \
      -fail-on-error="${INPUT_FAIL_ON_ERROR}" \
      -level="${INPUT_LEVEL}" \
      ${INPUT_REVIEWDOG_FLAGS}
