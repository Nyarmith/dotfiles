getcert() {
    URI="$1"
    openssl s_client -showcerts -connect "$URI" < /dev/null | openssl x509 -text
}
