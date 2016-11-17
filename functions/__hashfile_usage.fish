function __hashfile_usage
    # set -l uline (set_color -u)
    # set -l nc (set_color normal)

    echo "Usage: hashfile [ALGORITHM] [FILE]"
    echo
    echo "where ALGORITHM can be one of:"
    echo "       "md5"  generate .md5 file"
    echo "       "sha1"  generate .sha1 file"
    echo "       "sha3"  generate .sha3 file"
    # echo "       "$uline"u"$nc"se  Use the given node version (default)"
    # echo "       "$uline"r"$nc"m   Remove the given node version/s"
    # echo "       "$uline"l"$nc"s   List the available node version/s"
    echo
end
