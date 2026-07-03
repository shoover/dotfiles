#!/usr/bin/env bash
# Claude Code status line: model, project dir, live context size, session token totals.
# Receives the status JSON on stdin. See:
# https://docs.claude.com/en/docs/claude-code/statusline
set -euo pipefail

input=$(cat)

model=$(printf '%s' "$input" | jq -r '.model.display_name // .model.id // "?"')
project=$(printf '%s' "$input" | jq -r '.workspace.project_dir // .workspace.current_dir // .cwd // ""')
project=${project##*/}
transcript=$(printf '%s' "$input" | jq -r '.transcript_path // ""')

# ctx  = input side of the most recent main-chain assistant message (current context fill)
# tin  = total input-side tokens across the session (incl. subagents; cache reads counted each turn)
# tout = total output tokens across the session
ctx=0; tin=0; tout=0
if [[ -n "$transcript" && -f "$transcript" ]]; then
  read -r ctx tin tout < <(jq -nr '
    reduce inputs as $e (
      {ctx:0, tin:0, tout:0};
      if ($e.type == "assistant") and ($e.message.usage) then
        ($e.message.usage) as $u
        | ( ($u.input_tokens // 0)
          + ($u.cache_read_input_tokens // 0)
          + ($u.cache_creation_input_tokens // 0) ) as $in
        | ($u.output_tokens // 0) as $out
        | .tin += $in
        | .tout += $out
        | if (($e.isSidechain // false) == false) then .ctx = $in else . end
      else . end
    )
    | "\(.ctx) \(.tin) \(.tout)"
  ' "$transcript")
fi

fmt() { # integer -> human-readable (k / M)
  awk -v n="$1" 'BEGIN {
    if (n >= 1000000)   printf "%.1fM", n / 1000000;
    else if (n >= 1000) printf "%dk", int(n / 1000 + 0.5);
    else                printf "%d", n;
  }'
}

d=$'\033[2m'  # dim
r=$'\033[0m'  # reset

printf '%s %s·%s %s %s·%s %sctx%s %s %s·%s %sin%s %s %sout%s %s' \
  "$model" "$d" "$r" \
  "${project:-~}" "$d" "$r" \
  "$d" "$r" "$(fmt "$ctx")" "$d" "$r" \
  "$d" "$r" "$(fmt "$tin")" "$d" "$r" "$(fmt "$tout")"
