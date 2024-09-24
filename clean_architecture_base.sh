#!/bin/bash
CURRENT_DIRECTORY=$(pwd)

#Những file và folder cần copy:
ASSETS_DIR="assets"
LIB_DIR="lib"
PUBSPEC_YAML="pubspec.yaml"
l10n_DIR="l10n.yaml"

echo "Thư mục gốc là: $CURRENT_DIRECTORY"

# Đường dẫn đến thư mục chứa cấu trúc dự án mẫu

#Copy assets folder¬
SOURCE_DIR="/Users/hieutran/Documents/freelance/simple_clean_architure/assets/"

# Đường dẫn đến thư mục đích (dự án mới)
mkdir -p "$CURRENT_DIRECTORY/lib/$ASSETS_DIR"
echo "Thư mục assets đã được tạo là: $CURRENT_DIRECTORY"
DESTINATION_DIR="$CURRENT_DIRECTORY/lib/$ASSETS_DIR";

# Copy toàn bộ cấu trúc
cp -r "$SOURCE_DIR"/* "$DESTINATION_DIR"