#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Использование: $0 <входная директория> <выходная директория>"
    exit 1
fi

input_dir="$1"
output_dir="$2"

mkdir -p "$output_dir"

find "$input_dir" -type f -print0 | while IFS= read -r -d '' file; do
    base_name=$(basename "$file")
    count=1
    new_name="$base_name"
    while [ -e "$output_dir/$new_name" ]; do
        new_name="${base_name%.*}_$count.${base_name##*.}"
        ((count++))
    done
    cp "$file" "$output_dir/$new_name"
done

echo "файлы скопированы в $output_dir"
