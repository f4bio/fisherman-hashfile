function __hashfile_sha3
	echo "argv: $argv"
	rhash --sha3-512 "$argv[1]" > "$argv[1].sha3"
end
