#!/bin/sh

_set() {
	while [[ ! -z $1 ]]; do
		field=$(printf -- '%s' "$1" | sed -e 's/^-//g'); shift 1
		value=$(printf -- '%s' "$1"); shift 1
		[[ ! -z ${field} ]] && [[ ! -z ${value} ]] || return 1
		args=${args}$(printf -- '  --arg %s "%s"' "${field}" "${value}")
		line=${line}$(printf -- ',"%s":$%s' "${field}" "${field}")
	done
	args=$(printf -- '%s' "${args}" | sed -e 's/^ //g')
	line=$(printf -- '%s' "${line}" | sed -e "s/^,/'{/g" -e "s/$/}'/g")
	eval $(printf -- '$(which jq) -nc %s %s' "${args}" "${line}")
}

_get() {
	[[ ! -z $1 ]] && [[ ! -z $2 ]] || return 1
	field="$1"; shift 1
	printf -- '%s' "$@" | jq -r ".${field}"
}
