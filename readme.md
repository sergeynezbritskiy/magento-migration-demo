- define your Magento 1 and Magento 2 versions. We are using Magento CE 1.9.3.10 and Magento CE 2.2.6 in this project
- install migration tool within Magento 2 application
~~~~
composer config repositories.magento composer https://repo.magento.com
composer require magento/data-migration-tool:<Magento 2 version>
~~~~