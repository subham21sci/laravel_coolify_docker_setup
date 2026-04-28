#!/bin/bash

echo "🚀 Laravel starting..."

# Fix permissions
mkdir -p storage/logs bootstrap/cache database
touch storage/logs/laravel.log
touch database/database.sqlite

chmod -R 775 storage bootstrap/cache database
chown -R www-data:www-data storage bootstrap/cache database

# Laravel cache
php artisan config:clear || true
php artisan cache:clear || true
php artisan config:cache || true
php artisan route:cache || true

# Run migration
php artisan migrate --force || true

# Start services
supervisord -c assets/supervisord.conf
