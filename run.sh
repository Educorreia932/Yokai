filename="${1%%.*}"
extension="${1##*.}"

case $extension in
    "c")  # C
        gcc $1 -o $filename 
        chmod +x ./$filename
        ./$filename
        ;;
    "py") # Python
        python3 $1
        ;;
    *) 
        echo "This language is not supported."
esac

