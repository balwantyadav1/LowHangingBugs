#!/bin/bash

# Output file for vulnerable links
output_file="SPFvulnerable.txt"

# Check if the -h option was provided to show the help section
function usage() {
  echo "Examples: $ ./spfvuln.sh example.com"
  echo "          $ ./spfvuln.sh -t targets.txt"
  echo "          $ ./spfvuln.sh -t targets.txt --verbose"
  echo "          $ ./spfvuln.sh example.com --verbose"
  echo ""
  exit 0
}

function style() {
  local style_left="\e[31m["
  local style_right="]\e[39m "
  if [[ -n $1 && $1 == "NO SPF" ]]; then
    spf_status="${style_left}$1${style_right}"
  elif [[ -n $1 && $1 == "NO DMARC" ]]; then
    dmarc_status="${style_left}$1${style_right}"
  fi
}

function print() {
  local domain=${domain}

  if [[ -n ${1} || -n ${2} ]]; then
    style "$1"
    style "$2"
    echo -e "${spf_status}${dmarc_status} : ${domain} are \e[31mvulnerable\e[39m"
    echo "${domain}" >> "${output_file}"
  else
    echo -e "${domain} are \e[1;32mnot vulnerable\e[0m"
  fi
}

function log() {
  echo -e "$@"
  if [[ ${VERBOSE} == 1 ]]; then
    echo "SPF record: $spf_record"
    echo "DMARC record: $dmarc_record"
  fi
}

# Check if the -v option was provided to show the tool version
function version() {
  echo "Email-Vulnerablity-checker v1.1.1"
  exit 0
}

spfdmarc_checker() {
  spf_record=$(dig +short TXT "$domain" | grep "v=spf1")
  local spf_vuln=""
  if [ -z "$spf_record" ]; then
    spf_vuln="NO SPF"
  fi

  dmarc_record=$(dig +short TXT _dmarc."$domain")
  local dmarc_vuln=""
  if [ -z "$dmarc_record" ]; then
    dmarc_vuln="NO DMARC"
  fi

  print "${spf_vuln}" "${dmarc_vuln}" "${domain}"
  log
}

function target() {
  if [ -z "$1" ]; then
    echo "Error: No target file provided, use -h for help"
    exit 1
  fi

  if [ ! -f "$1" ]; then
    echo "Error: Target file not found, use -h for help"
    exit 1
  fi

  while IFS= read -r domain; do
    if ! [[ $domain =~ ^([a-z0-9]+(-[a-z0-9]+)*\.)+[a-z]{2,}$ ]]; then
      echo "Error: Invalid domain '$domain'"
      continue
    else
      spfdmarc_checker
    fi
  done < "$1"
}

function single_domain() {
  if ! [[ $1 =~ ^([a-z0-9]+(-[a-z0-9]+)*\.)+[a-z]{2,}$ ]]; then
    echo "Error: Invalid domain '$1'"
    exit 1
  fi
  spfdmarc_checker
}

while [ $# -gt 0 ]; do
  case $1 in
    -h | --help)
      usage
      ;;
    --verbose)
      VERBOSE=1
      ;;
    -v | --version)
      version
      ;;
    -t | --target)
      target_file="$2"
      ;;
    *)
      domain="$1"
      ;;
  esac
  shift
done

if [[ -n ${target_file} ]]; then
  target "$target_file"
fi

if [[ -n ${domain} ]]; then
  single_domain "$domain"
fi

exit 0
