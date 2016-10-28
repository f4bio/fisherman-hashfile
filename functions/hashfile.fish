function hashfile -d "generate checksum files"
	set -g hashfile_version 0.0.1
	set -g rhash_vesion (rhash --version)[1]

	set -l cmd

	switch "$argv[1]"
		case -h --help help
			__hashfile_usage > /dev/stderr
			return

		case -v --version version
			echo "v$hashfile_version (using: $rhash_version)"
			return

		case -g --given

		case md5
			rhash --sha3-512 "(basename $argv[1])" | tee "$argv[1].sha3"

		case sha1
			__hashfile_sha1 $argv

		case sha3
			__hashfile_sha3 $argv

		case -\*\*
			echo "hashfile: '$argv[1]' is not a valid option." > /dev/stderr
			__hashfile_usage > /dev/stderr
			return 1
	end
end
