function hashfile -d "generate checksum files"
	set -g hashfile_version 0.0.1
	set -g rhash_vesion (rhash --version)[1]

	set -l current_dir (pwd)
	set -l cmd
  set -l algo "--md5"
	set -l input_file
  set -l given_hash

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
			echo "v$hashfile_version (using: $rhash_version)"
			return
		case -g --given
			set given_hash $argv[(math "$idx + 1")]
		case md5 sha1 sha3
			set algo $argv[$idx]
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
		echo "no such file $target_file in $target_path"
		__hashfile_usage > /dev/stderr
		return 2
	end
	if test -d $target_path
		# echo "changing directory to $target_path"
		cd $target_path
	end

	if test -n $given_hash
		# echo "no hash given, calculating..."
		rhash --output "$target_file.$algo" "--$algo" "$target_file"
	end

	rhash -c "$target_file.$algo"

	cd $current_dir
end
