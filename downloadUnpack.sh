#!/bin/bash

if [ -z "$1" ]; then
    echo "Error: No dataset provided."
    echo "Usage: source $0 <DATASET_DID> or ./$0 <DATASET_DID>"
    return 1 || exit 1
fi

DATASET_DID="$1"
DOWNLOAD_DIR="$DATASET_DID"

echo "Downloading dataset: $DATASET_DID..."
rucio download "$DATASET_DID"

if [ $? -ne 0 ]; then
    echo "Error downloading files."
    return 1 || exit 1
fi

if [ ! -d "$DOWNLOAD_DIR" ]; then
    echo "Error: Directory $DOWNLOAD_DIR does not exist."
    return 1 || exit 1
fi

cd "$DOWNLOAD_DIR" || return 1

UNPACKED_DIR="extracted_results"
ARCHIVE_DIR="original_backups"
mkdir -p "$UNPACKED_DIR" "$ARCHIVE_DIR"

echo "Starting to process .root.tgz files..."

for file in *.root.tgz; do
    if [ -f "$file" ]; then
        echo "-> Processing file: $file"
        
        internal_files=$(tar -tf "$file")
        tar -xzf "$file" -C "$UNPACKED_DIR"

        if [ $? -eq 0 ]; then
            for internal_name in $internal_files; do
                if [ -f "$UNPACKED_DIR/$internal_name" ]; then
                    mv "$UNPACKED_DIR/$internal_name" "$UNPACKED_DIR/${file}_${internal_name}"
                fi
            done
            mv "$file" "$ARCHIVE_DIR/"
            echo "   [OK] $file extracted and moved to $ARCHIVE_DIR/"
        else
            echo "   [ERROR] Failed to extract $file"
        fi
    fi
done

echo "Process completed for: $DATASET_DID"
echo "Results are in $DOWNLOAD_DIR/$UNPACKED_DIR"
