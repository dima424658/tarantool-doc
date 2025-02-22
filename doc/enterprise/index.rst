.. _tarantool_enterprise:

Tarantool Enterprise Edition
============================

.. ifconfig:: language == 'en'

    .. container:: documentation-main-page-description

        This section describes the Enterprise Edition of Tarantool software -- a Lua
        application server integrated with a DBMS for deploying fault-tolerant
        distributed data storages.

        The Enterprise Edition provides an `extended feature set <https://www.tarantool.io/en/compare/>`__ for developing
        and managing clustered Tarantool applications, for example:

        * :ref:`Static package <enterprise-env-independent-apps>`
          for standalone Linux systems.
        * Tarantool :ref:`bindings to OpenLDAP <ldap_auth>`.
        * Security :ref:`audit log <enterprise-logging>`.
        * Enterprise :ref:`database connectivity <enterprise-run-app>`:
          Oracle and any ODBC-supported DBMS
          (for example, MySQL, Microsoft SQL Server).
        * SSL support for :ref:`traffic encryption <enterprise-iproto-encryption>`.
        * :doc:`Tuple compression <tuple_compression>`.
        * :doc:`Non-blocking DDL <space_upgrade>`.

.. ifconfig:: language == 'ru'

    .. container:: documentation-main-page-description

        Данное руководство посвящено Enterprise-версии продукта Tarantool,
        который сочетает в себе сервер приложений Lua и отказоустойчивую
        распределенную СУБД.

        Enterprise-версия предлагает `дополнительные возможности <https://www.tarantool.io/ru/compare/>`__ по
        разработке и эксплуатации кластерных приложений, например:

        * :ref:`Статическая сборка <enterprise-env-independent-apps>`
          для автономных Linux-систем.
        * :ref:`Модуль интеграции с OpenLDAP <ldap_auth>`.
        * :ref:`Журнал аудита безопасности <enterprise-logging>`.
        * Подключения к :ref:`корпоративным базам данных <enterprise-run-app>`:
          Oracle и любым СУБД с интерфейсом ODBC (MySQL, Microsoft SQL Server и т.д.).
          (например, MySQL, Microsoft SQL Server).
        * :ref:`Шифрование трафика <enterprise-iproto-encryption>` с помощью SSL.
        * :doc:`Сжатие кортежей <tuple_compression>`.
        * :doc:`Смена схемы данных в фоновом режиме <space_upgrade>`.


..  toctree::
    :hidden:

    changelog
    setup
    dev
    admin
    security
    audit
    cartridge-auth
    tuple_compression
    wal_extensions
    read_views
    flight_recorder
    audit_log
    space_upgrade
    migration
    system_metrics
    deprecated
    rocksref
