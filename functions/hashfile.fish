function hashfile -d "generate checksum files"
	set -g hashfile_version 0.0.1
	set -g rhash_vesion (rhash --version)[1]

	set -l current_dir (pwd)
	set -l cmd

	# echo "argv[1]: $argv[1]"
	# echo "argv[2]: $argv[2]"
	# echo "count(argv): "(count $argv)""

	if test (count $argv) -lt 2
		__hashfile_usage > /dev/stderr
		return 1
	end

	set -l target_path (dirname (realpath $argv[2]))
	set -l target_file (basename $argv[2])
	# echo "target_path: $target_path"
	# echo "target_file: $target_file"
	cd $target_path

	if test (count $argv) -eq 3
		# echo "only generating file..."
		echo "$target_file $argv[3]" | tee "$target_file.$argv[1]"
	end

	switch "$argv[1]"
		case -h --help help
			__hashfile_usage > /dev/stderr
			return
		case -v --version version
			echo "v$hashfile_version (using: $rhash_version)"
			return
		# case md5 sha1 sha3
		# 	echo "checking if valid checksum format..."
		# 	if test (count $argv) -eq 3
		# 		echo "only generating file..."
		# 		echo "$target_file $argv[3]" | tee "$target_file.$argv[1]"
		# 	end
		case md5
			# echo "generating md5 file..."
			rhash --output "$target_file.md5" --md5 $target_file
		case sha1
			# echo "generating sha1 file..."
			rhash --output $target_file.sha1 --sha1 $target_file
		case sha3
			# echo "generating sha3 file..."
			rhash --output $target_file.md5 --sha3-512 $target_file
		case -\*\*
			echo "hashfile: '$argv[1]' is not a valid option." > /dev/stderr
			__hashfile_usage > /dev/stderr
			return 1
	end

	# echo "checking file..."
	rhash -c "$target_file.$argv[1]"

	cd $current_dir
end
