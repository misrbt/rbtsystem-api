#!/bin/bash
set -e

PROJECT_DIR="/var/www/staging/rbtsystem-api"

echo "======================================"
echo " RBTSYSTEM-API — Staging Deploy"
echo "======================================"

echo "[1/4] Pulling latest code from develop..."
git -C "$PROJECT_DIR" pull origin develop

echo "[2/4] Installing backend dependencies..."
composer install --no-dev --optimize-autoloader --no-interaction --working-dir="$PROJECT_DIR"

echo "[3/4] Running database migrations..."
php "$PROJECT_DIR/artisan" migrate --force

echo "[4/4] Caching config and routes..."
php "$PROJECT_DIR/artisan" config:cache
php "$PROJECT_DIR/artisan" route:cache
php "$PROJECT_DIR/artisan" view:cache

# PHP-FPM serves this project — reload to pick up changes
sudo systemctl reload php8.3-fpm

echo ""
echo "✓ RBT API Staging deploy complete!"
