mysql -hmysql -uadmin -padmin -e "DROP DATABASE magento1_magento2_migration_dst"
mysql -hmysql -uadmin -padmin -e "CREATE DATABASE magento1_magento2_migration_dst"
rm app/etc/env.php
rm -rf generated/code
rm -rf generated/metadata
rm -rf var/cache
rm -rf var/page_cache
rm -rf var/view_preprocessed
rm -rf var/log
rm var/migration-tool-progress.lock
php bin/magento setup:install --base-url=http://migration-demo.magento2.local/ --db-host=mysql --db-name=magento1_magento2_migration_dst --db-user=admin --db-password=admin --admin-firstname=Sergey --admin-lastname=Nezbritskiy --admin-email=sergey.nezbritskiy@gmail.com --admin-user=admin --admin-password=aa123123 --language=en_US --currency=USD --timezone=America/Chicago --use-rewrites=1 --backend-frontname=admin
php bin/magento cache:flush
php bin/magento migrate:settings migration/config.xml
php bin/magento migrate:data migration/config.xml
php bin/magento indexer:reindex
