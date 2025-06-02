#!/bin/bash

OPTSTRING=":fts:d:v:"

while getopts $OPTSTRING opt; do
    case ${opt} in
        f)
            FROM="true"
            ;;
        t)
            TO="true"
            ;;
        s)
            SOURCE="$OPTARG"
            ;;
        d)
            DESTINATION="$OPTARG"
            ;;
        v)
            VOLUME="$OPTARG"
            ;;
        ?)
            echo "Usage: $0 [-f] [-t] [-s source] [-d destination] [-v volume]"
            echo "  -f: Sync FROM the Docker volume to the local directory."
            echo "  -t: Sync TO the Docker volume from the local directory."
            echo "  -s source: Specify the source directory (required if -t is used)."
            echo "  -d destination: Specify the destination directory (required if -f is used)."
            echo "  -v volume: Specify the Docker volume to sync with (required)."
            exit 1
            ;;
    esac
done

if [ "$FROM" != "" ] && [ "$TO" != "" ]; then
    echo "ERROR: Cannot specify both -f (FROM) and -t (TO) options."
    exit 1
fi

if ! docker volume inspect "$VOLUME" > /dev/null 2>&1; then
    echo "ERROR: Docker volume '$VOLUME' does not exist."
    exit 1
fi
volume_mount=$(docker volume inspect "$VOLUME" --format '{{ .Mountpoint }}')

if [ "$TO" == "true" ]; then
    if ! test -d "$SOURCE"; then
        echo "ERROR: Source directory '$SOURCE' does not exist."
        exit 1
    fi
    echo "Syncing $SOURCE --> ${VOLUME}:/${DESTINATION}. Press 'Enter' to continue or 'Ctrl+C' to cancel."
    read -r
    src_dir=$(basename "$SOURCE")
    docker run --rm -v "$SOURCE":/${src_dir} -v "$VOLUME":/destination alpine sh -c "mkdir -p /destination/${DESTINATION}; cp -r ${src_dir} /destination/${DESTINATION}"    
elif [ "$FROM" == "true" ]; then
    if ! test -d "$DESTINATION"; then
        echo "ERROR: Destination directory '$DESTINATION' does not exist."
        exit 1
    fi
    echo "TBD: Syncing from $volume_mount to $DESTINATION"
    echo "Syncing ${VOLUME}:/${SOURCE} --> $DESTINATION. Press 'Enter' to continue or 'Ctrl+C' to cancel."
    read -r
    docker run --rm -v "$VOLUME":/${SOURCE} -v "$DESTINATION":/destination alpine sh -c "cp -r ${SOURCE}/* /destination"    
else
    echo "ERROR: Either -f (FROM) or -t (TO) option must be specified."
    exit 1
fi
echo "Sync completed successfully."