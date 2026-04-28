#!/bin/bash

echo "🚀 Starting Laravel..."

# Create folders
mkdir -p storage/logs bootstrap/cache database

# Fix permissions
chmod -R 775 storage bootstrap/cache database
chown -R www-data:www-data storage bootstrap/cache database

# Fix log file
touch storage/logs/laravel.log
chmod 664 storage/logs/laravel.log

# SQLite (optional)
touch database/database.sqlite

# Clear & cache
php artisan config:clear || true
php artisan cache:clear || true
php artisan config:cache || true
php artisan route:cache || true
php artisan view:cache || true

# Run migration
php artisan migrate --force || true

# Start services
echo "Starting Supervisor..."
supervisord -c assets/supervisord.conf
