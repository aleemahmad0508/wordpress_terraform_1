#!/bin/bash
set -e

# Log everything
exec > >(tee /var/log/user-data.log | logger -t user-data) 2>&1

echo "========== Starting WordPress Installation =========="

# --------------------------------------
# Update System
# --------------------------------------
dnf update -y

# --------------------------------------
# Install Packages
# --------------------------------------
dnf install -y \
httpd \
php \
php-mysqlnd \
php-fpm \
php-json \
php-gd \
php-mbstring \
php-xml \
php-curl \
php-zip \
mariadb105 \
amazon-efs-utils \
wget \
tar

# --------------------------------------
# Enable Apache
# --------------------------------------
systemctl enable httpd
systemctl start httpd

# --------------------------------------
# Download WordPress
# --------------------------------------
cd /tmp

if [ ! -f latest.tar.gz ]; then
    wget https://wordpress.org/latest.tar.gz
fi

tar -xzf latest.tar.gz

# Copy WordPress files only if they don't exist
if [ ! -f /var/www/html/index.php ]; then
    cp -R wordpress/* /var/www/html/
fi

# --------------------------------------
# Save Original wp-content
# --------------------------------------
if [ ! -d /tmp/wp-content-original ]; then
    cp -R /var/www/html/wp-content /tmp/wp-content-original
fi

# --------------------------------------
# Mount EFS
# --------------------------------------
mkdir -p /var/www/html/wp-content

mount -t efs ${efs_dns_name}:/ /var/www/html/wp-content || true

# Persist mount after reboot
grep -q "${efs_dns_name}" /etc/fstab || \
echo "${efs_dns_name}:/ /var/www/html/wp-content efs defaults,_netdev 0 0" >> /etc/fstab

# --------------------------------------
# Initialize EFS (only first time)
# --------------------------------------
if [ -z "$(ls -A /var/www/html/wp-content)" ]; then
    echo "EFS is empty. Copying default wp-content..."
    cp -R /tmp/wp-content-original/* /var/www/html/wp-content/
fi

# --------------------------------------
# Configure WordPress
# --------------------------------------
cd /var/www/html

if [ ! -f wp-config.php ]; then
    cp wp-config-sample.php wp-config.php

    sed -i "s/database_name_here/${rds_name}/" wp-config.php
    sed -i "s/username_here/${rds_username}/" wp-config.php
    sed -i "s/password_here/${rds_password}/" wp-config.php
    sed -i "s/localhost/${rds_endpoint}/" wp-config.php
fi

# --------------------------------------
# Permissions
# --------------------------------------
chown -R apache:apache /var/www/html
find /var/www/html -type d -exec chmod 755 {} \;
find /var/www/html -type f -exec chmod 644 {} \;

# --------------------------------------
# Restart Apache
# --------------------------------------
systemctl restart httpd

echo "========== WordPress Installation Completed =========="