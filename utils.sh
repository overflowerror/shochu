#!/bin/bash

_hasStatus=0

status() {
	_hasStatus=1
	local status="$1"
	echo -n "Status: $status "
	case "$status" in
		100) echo "Continue" ;;
		101) echo "Switching Protocols" ;;
		102) echo "Processing" ;;

		200) echo "OK" ;;
		201) echo "Created" ;;
		202) echo "Accepted" ;;
		203) echo "Non-Authoritative Information" ;;
		204) echo "No Content" ;;
		205) echo "Reset Content" ;;
		206) echo "Partial Content" ;;
		207) echo "Multi-Status" ;;
		208) echo "Already Reported" ;;
		226) echo "IM Used" ;;

		300) echo "Multiple Choices" ;;
		301) echo "Moved Permanently" ;;
		302) echo "Found" ;;
		303) echo "See Other" ;;
		304) echo "Not Modified" ;;
		305) echo "Use Proxy" ;;
		306) echo "Switch Proxy" ;;
		307) echo "Temporary Redirect" ;;
		308) echo "Permanent Redirect" ;;

		400) echo "Bad Request" ;;
		401) echo "Unauthorized" ;;
		402) echo "Payment Required" ;;
		403) echo "Forbidden" ;;
		404) echo "Not Found" ;;
		405) echo "Method Not Allowed" ;;
		406) echo "Not Acceptable" ;;
		407) echo "Proxy Authentication Required" ;;
		408) echo "Request Timeout" ;;
		409) echo "Conflict" ;;
		410) echo "Gone" ;;
		411) echo "Length Required" ;;
		412) echo "Precondition Failed" ;;
		413) echo "Payload Too Large" ;;
		414) echo "URI Too Long" ;;
		415) echo "Unsupported Media Type" ;;
		416) echo "Range Not Satisfiable" ;;
		417) echo "Expectation Failed" ;;
		418) echo "I\'m a teapot" ;;
		421) echo "Misdirected Request" ;;
		422) echo "Unprocessable Entity" ;;
		423) echo "Locked" ;;
		424) echo "Failed Dependency" ;;
		426) echo "Upgrade Required" ;;
		428) echo "Precondition Required" ;;
		429) echo "Too Many Requests" ;;
		431) echo "Request Header Fields Too Large" ;;
		451) echo "Unavailable For Legal Reasons" ;;

		500) echo "Internal Server Error" ;;
		501) echo "Not Implemented" ;;
		502) echo "Bad Gateway" ;;
		503) echo "Service Unavailable" ;;
		504) echo "Gateway Timeout" ;;
		505) echo "HTTP Version Not Supported" ;;
		506) echo "Variant Also Negotiates" ;;
		507) echo "Insufficient Storage" ;;
		508) echo "Loop Detected" ;;
		510) echo "Not Extended" ;;
		511) echo "Network Authentication Required" ;;
		*) echo "Unknown"
	esac
}

header() {
	echo "$1: $2"
}

redirect() {
	status 302
	header "Location" "$1"
}

endHeaders() {
	if test "$_hasStatus" = 0; then
		status 200
	fi
	echo
}
