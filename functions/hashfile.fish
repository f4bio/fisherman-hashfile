function hashfile -d "generate checksum files"
	set -g hashfile_version 0.0.1
	set -g rhash_version (rhash --version)[1]
	set -g verbose 0

	set -l current_dir (pwd)
	set -l cmd
  set -l algo "md5"
	set -l input_file
  set -l given_hash

	rhash --version > /dev/null
	if test $status -ne 0
		__hashfile_rhash_missing > /dev/stderr
		return 1
	end

	if test (count $argv) -lt 2
		__hashfile_usage > /dev/stderr
		return 1
	end

	for idx in (seq (count $argv))

		switch $argv[$idx]
			case -h --help help
				__hashfile_usage > /dev/stderr
				return
			case -v --version version
				echo -e "\nv$hashfile_version (using: $rhash_version)\n"
				return
			case --verbose
				set -g verbose 1
			case -g --given
				set -l given_hash $argv[(math "$idx + 1")]
			case md5 sha1 sha3
				set -l algo $argv[$idx]
			case sha3
				set -l algo "sha3-256"
		end
		if test -f $argv[$idx]
			set input_file $argv[$idx]
			set target_path (dirname (realpath $argv[$idx]))
			set target_file (basename $argv[$idx])
		end
	end
	# echo "given hash: $given_hash"
	# echo "target path: $target_path"
	# echo "target file: $target_file"
	# echo "algo: $algo"
	# echo "input file: $input_file"

	if test ! -f "$target_path/$target_file"
		echo -e "\n > no such file $target_file in $target_path\n"
		__hashfile_usage > /dev/stderr
		return 2
	end
	if test -d $target_path
		__hashfile_log "changing directory to $target_path"
		cd $target_path
	end

	if test -n $given_hash
		__hashfile_log "no hash given, calculating..."
		rhash --output "$target_file.$algo" "--$algo" "$target_file"
	else
		__hashfile_log "hash given, writing file..."
		echo "$target_file $given_hash" > "$target_file.$algo"
	end

	__hashfile_log "checking..."
	rhash -c "$target_file.$algo"

	cd $current_dir
	__hashfile_log "done!"
end
