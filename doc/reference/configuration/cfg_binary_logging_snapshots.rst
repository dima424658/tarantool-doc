* :ref:`force_recovery <cfg_binary_logging_snapshots-force_recovery>`
* :ref:`wal_max_size <cfg_binary_logging_snapshots-wal_max_size>`
* :ref:`snap_io_rate_limit <cfg_binary_logging_snapshots-snap_io_rate_limit>`
* :ref:`wal_mode <cfg_binary_logging_snapshots-wal_mode>`
* :ref:`wal_dir_rescan_delay <cfg_binary_logging_snapshots-wal_dir_rescan_delay>`
* :ref:`wal_queue_max_size <cfg_binary_logging_snapshots-wal_queue_max_size>`
* :ref:`wal_cleanup_delay <cfg_binary_logging_snapshots-wal_cleanup_delay>`

.. _cfg_binary_logging_snapshots-force_recovery:

.. confval:: force_recovery

    Since version 1.7.4.
    If ``force_recovery`` equals true, Tarantool tries to continue if there is
    an error while reading a :ref:`snapshot file<index-box_persistence>`
    (at server instance start) or a :ref:`write-ahead log file<internals-wal>`
    (at server instance start or when applying an update at a replica): skips
    invalid records, reads as much data as possible and lets the process finish
    with a warning. Users can prevent the error from recurring by writing to
    the database and executing :doc:`box.snapshot() </reference/reference_lua/box_snapshot>`.

    Otherwise, Tarantool aborts recovery if there is an error while reading.

    | Type: boolean
    | Default: false
    | Environment variable: TT_FORCE_RECOVERY
    | Dynamic: no

.. _cfg_binary_logging_snapshots-wal_max_size:

.. confval:: wal_max_size

    Since version 1.7.4.
    The maximum number of bytes in a single write-ahead log file.
    When a request would cause an .xlog file to become larger than
    ``wal_max_size``, Tarantool creates another WAL file.

    | Type: integer
    | Default: 268435456 (256 * 1024 * 1024) bytes
    | Environment variable: TT_WAL_MAX_SIZE
    | Dynamic: no

.. _cfg_binary_logging_snapshots-snap_io_rate_limit:

.. confval:: snap_io_rate_limit

    Since version 1.4.9.
    Reduce the throttling effect of :doc:`box.snapshot() </reference/reference_lua/box_snapshot>` on
    INSERT/UPDATE/DELETE performance by setting a limit on how many
    megabytes per second it can write to disk. The same can be
    achieved by splitting :ref:`wal_dir <cfg_basic-wal_dir>` and
    :ref:`memtx_dir <cfg_basic-memtx_dir>`
    locations and moving snapshots to a separate disk.
    The limit also affects what
    :ref:`box.stat.vinyl().regulator <box_introspection-box_stat_vinyl_regulator>`
    may show for the write rate of dumps to .run and .index files.

    | Type: float
    | Default: null
    | Environment variable: TT_SNAP_IO_RATE_LIMIT
    | Dynamic: **yes**

.. _cfg_binary_logging_snapshots-wal_mode:

.. confval:: wal_mode

    Since version 1.6.2. Specify fiber-WAL-disk synchronization mode as:

    * ``none``: write-ahead log is not maintained.
      A node with ``wal_mode = none`` can't be replication master;
    * ``write``: :ref:`fibers <fiber-fibers>` wait for their data to be written to
      the write-ahead log (no :manpage:`fsync(2)`);
    * ``fsync``: fibers wait for their data, :manpage:`fsync(2)`
      follows each :manpage:`write(2)`;

    | Type: string
    | Default: "write"
    | Environment variable: TT_WAL_MODE
    | Dynamic: no

.. _cfg_binary_logging_snapshots-wal_dir_rescan_delay:

.. confval:: wal_dir_rescan_delay

    Since version 1.6.2.
    Number of seconds between periodic scans of the write-ahead-log
    file directory, when checking for changes to write-ahead-log
    files for the sake of :ref:`replication <replication>` or :ref:`hot standby <index-hot_standby>`.

    | Type: float
    | Default: 2
    | Environment variable: TT_WAL_DIR_RESCAN_DELAY
    | Dynamic: no

.. _cfg_binary_logging_snapshots-wal_queue_max_size:

.. confval:: wal_queue_max_size

    Since version :doc:`2.8.1 </release/2.8.1>`.
    The size of the queue (in bytes) used by a :ref:`replica <replication-roles>` to submit
    new transactions to a :ref:`write-ahead log<internals-wal>` (WAL).
    This option helps limit the rate at which a replica submits transactions to the WAL.
    Limiting the queue size might be useful when a replica is trying to sync with a master and
    reads new transactions faster than writing them to the WAL.

    .. NOTE::

        You might consider increasing the ``wal_queue_max_size`` value in case of
        large tuples (approximately one megabyte or larger).

    | Type: number
    | Default: 16777216 bytes
    | Environment variable: TT_WAL_QUEUE_MAX_SIZE
    | Dynamic: **yes**

.. _cfg_binary_logging_snapshots-wal_cleanup_delay:

.. confval:: wal_cleanup_delay

    Since version :doc:`2.6.3 </release/2.6.3>`.
    The delay (in seconds) used to prevent the :ref:`Tarantool garbage collector <cfg_checkpoint_daemon-garbage-collector>`
    from immediately removing :ref:`write-ahead log<internals-wal>` files after a node restart.
    This delay eliminates possible erroneous situations when the master deletes WALs
    needed by :ref:`replicas <replication-roles>` after restart.
    As a consequence, replicas sync with the master faster after its restart and
    don't need to download all the data again.

    Once all the nodes in the replica set are up and running,
    automatic cleanup is started again even if ``wal_cleanup_delay`` has not expired.

    .. NOTE::

        The ``wal_cleanup_delay`` option has no effect on nodes running as
        :ref:`anonymous replicas<cfg_replication-replication_anon>`.

    | Type: number
    | Default: 14400 seconds
    | Environment variable: TT_WAL_CLEANUP_DELAY
    | Dynamic: **yes**