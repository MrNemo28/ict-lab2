#!/bin/bash
set -eu

# Пути к папкам лабораторной работы
BASE="$HOME/ict_lab2"
SOURCE="$BASE/docs"
DEST="$BASE/backup"
LOG="$BASE/logs/backup.log"

# Если исходной папки нет, сообщаем об ошибке
if [ ! -d "$SOURCE" ]; then
    echo "ERROR: Source directory not found: $SOURCE" >&2
    exit 1
fi

mkdir -p "$DEST" "$BASE/logs"

# Дата и время делают имя каждого архива уникальным
STAMP=$(date +%Y%m%d_%H%M%S_%N)
ARCHIVE="$DEST/docs_$STAMP.tar.gz"

# Создаём архив и записываем успешный результат
tar -czf "$ARCHIVE" -C "$BASE" docs
echo "$(date '+%F %T') SUCCESS: $ARCHIVE" >> "$LOG"

# Удаляем резервные архивы старше 7 дней
find "$DEST" -maxdepth 1 -type f -name 'docs_*.tar.gz' -mmin +10080 -delete

echo "Backup created: $ARCHIVE"
