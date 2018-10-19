# Prerequisites
- Magento 1 supposed to be untouched during the migration. Run this command from Magento 2 installation directory to completely reinstall Magento 2
- Migration tool supposed to be executed many times, so you will need a script to clear Magento 2 database many times, e.g.
~~~~
bash ../samples/install.sh
~~~~
- Migration tool supposed to be executed many times, so don't do anything important from admin panel. As this will be lost
- Migration tool vocabulary: *Document* in migration tool is a *table* in database, *field* in migration tool is a *column* in database
# Working with migration
- define your Magento 1 and Magento 2 versions. We are using Magento CE 1.9.3.10 and Magento CE 2.2.6 in this project
- install migration tool within Magento 2 application
~~~~
composer config repositories.magento composer https://repo.magento.com
composer require magento/data-migration-tool:<Magento 2 version>
~~~~
- copy configuration file from `<your magento 2 installation dir>/vendor/magento/data-migration-tool/etc/<migration edition>/<ce or version>` to some git tracked directory, e.g. <your Magento 2 installation directory>/migration, e.g.
~~~~
cp ./vendor/magento/data-migration-tool/etc/<migration edition>/<ce or version>/config.xml.dist ./migration/config.xml
~~~~
- within copied config.xml specify credentials for accessing databases:
~~~~
<source>
    <database host="127.0.0.1" name="magento1" user="root" password="" port=""/>
</source>
<destination>
    <database host="127.0.0.1" name="magento2" user="root"/>
</destination>
<options>
    <source_prefix>mage1_</source_prefix><!-- optional -->
    <dest_prefix>mage2_</dest_prefix><!-- optional -->
    <crypt_key>d27a50f04c0b5879b48478a756ab2273</crypt_key><!-- mandatory -->
</options>
~~~~
- migrate settings
~~~~
php bin/magento migrate:settings local.xml
~~~~
- migrate data
~~~~
php bin/magento migrate:data local.xml
~~~~
# Migration process customization
- exclude document from migration process. To do this you need to add `ignore` node to your map.xml
~~~~
<source>
    <document_rules>
        <ignore>
            <document>paybox_question_number</document>
        </ignore>
    </document_rules>
</source>
~~~~
- the same way we can ignore field in document
~~~~
<source>
    <field_rules>
        <ignore>
            <field>customer_eav_attribute.is_used_for_customer_segment</field>
        </ignore>
    </document_rules>
</source>
~~~~
