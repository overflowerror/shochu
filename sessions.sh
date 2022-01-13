#!/bin/bash

_sessionDuration=

_sessionPath="/dev/shm/shochu/sessions/"
mkdir -p "$_sessionPath"

_sessionCookie="shochu_sessid"

_currentSessionId=""

_makeSessionPath() {
	echo "$_sessionPath/$(basename "$1")"
}

_getSessionDate() {
	date -Ins -u
}

_createSession() {
	_getSessionDate > "$(_makeSessionPath "$1")"
}

_getSession() {
	f="$(_makeSessionPath "$1")"
	if test -f "$f"; then
		cat "$f"
		return 0
	else
		return 1
	fi
}

_newSessionId() {
	base="$(date -Ins -u)"
	random="$RANDOM"
	while _getSession "$(echo "$base$random" | md5sum | cut -d' ' -f1)" > /dev/null; do
		random="$RANDOM"
	done
	echo "$base$random" | md5sum | cut -d' ' -f1
}

_hasSession() {
	test ! -z "$(_getSessionId)"
	return
}

_getSessionId() {
	if test -z "$_currentSessionId"; then
		_currentSessionId="$(getCookie "$_sessionCookie")"
	fi
	echo "$_currentSessionId"
}

startSession() {
	_getSessionId > /dev/null # not in subshell to cache result
	if _hasSession; then
		return 1
	else
		id="$(_newSessionId)"
		_currentSessionId="$id"
		
		_createSession "$id"
		setCookie "$_sessionCookie" "$id"
		
		return 0
	fi
}

getSession() {
	_getSession "$(_getSessionId)" | tail -n +2
}

setSession() {
	if _hasSession; then
		echo "$1" | cat <(_getSessionDate) - > "$(_makeSessionPath "$(_getSessionId)")"
	fi
}
