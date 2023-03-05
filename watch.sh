#!/usr/bin/env bash
LUA_VERSION="${LUA_VERSION:-5.1}"

yue --target="$LUA_VERSION" "$PWD"
clear

if command -v inotifywait &> "/dev/null"; then
	function wait_for_change() {
		inotifywait \
			--event create \
			--event modify \
			--event moved_to \
			--event move_self \
			--include '.*\.yue$' \
			--recursive "$PWD" \
			2> /dev/null |
			awk '{ printf "%s%s\n", $1, $3 }'
	}

	function compile() {
		yue --target="$LUA_VERSION" "$1"
	}

	while true; do
		yue_file="$(wait_for_change)"
		success="$?"

		if ((success == 0)); then
			clear

			compile "$yue_file"
		fi

		# Files starting with '---#NAMESPACE_FILE' will automatically be
		# updated to include all subdirectories
		find "sunshine" -type d -print0 | while IFS= read -r -d '' dir; do
			f="$dir/init.yue"
			if [[ -f "$f" && "$(head --lines=1 "$f")" = '---#NAMESPACE_FILE' ]]; then
				file_content=$'---#NAMESPACE_FILE\n'
				for sub_dir in "$dir/"*/; do
					base_name="$(basename "$sub_dir")"
					sub_dir_fmt="$(sed 's|^/*||' <<< "$sub_dir" | sed 's|/*$||')"
					file_content+="export $base_name = require("'"'"${sub_dir_fmt//\//.}"'"'")"$'\n'
				done
				echo -n "$file_content" > "$f"
				compile "$f"
			fi
			unset f
		done
	done
else
	yue --target="$LUA_VERSION" -w "$PWD"
fi
