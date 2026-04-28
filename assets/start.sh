#!/bin/bash

echo "🚀 Starting Laravel..."

# Fix folders
mkdir -p storage/logs bootstrap/cache database

chmod -R 775 storage bootstrap/cache database
chown -R www-data:www-data storage bootstrap/cache database

touch storage/logs/laravel.log
touch database/database.sqlite

# Clear cache
php artisan config:clear || true
php artisan cache:clear || true

# Run migration
php artisan migrate --force || true

# Start Laravel directly (NO nginx)
php artisan serve --host=0.0.0.0 --port=$PORT
