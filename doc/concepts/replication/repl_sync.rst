.. _repl_sync:

Synchronous replication
=======================

Overview
--------

By default, replication in Tarantool is **asynchronous**: if a transaction
is committed locally on a master node, it does not mean it is replicated onto any
replicas. If a master responds success to a client and then dies, after failover
to a replica, from the client's point of view the transaction will disappear.

**Synchronous** replication exists to solve this problem. Synchronous transactions
are not considered committed and are not responded to a client until they are
replicated onto some number of replicas.

To learn how to enable and use synchronous replication,
check the :ref:`guide <how-to-repl_sync>`.

Synchronous and asynchronous transactions
-----------------------------------------

A killer feature of Tarantool's synchronous replication is its being *per-space*.
So, if you need it only rarely for some critical data changes, you won't pay for
it in performance terms.

When there is more than one synchronous transaction, they all wait for being
replicated. Moreover, if an asynchronous transaction appears, it will
also be blocked by the existing synchronous transactions. This behavior is very
similar to a regular queue of asynchronous transactions because all the transactions
are committed in the same order as they make the :ref:`box.commit() <box-commit>` call.
So, here comes **the commit rule**:
transactions are committed in the same order as they make
the ``box.commit()`` call -- regardless of being synchronous or asynchronous.

If one of the waiting synchronous transactions times out and is rolled back, it
will first roll back all the newer pending transactions. Again, just like how
asynchronous transactions are rolled back when WAL write fails.
So, here comes **the rollback rule:**
transactions are always rolled back in the order reversed from the one they
make the ``box.commit()`` call -- regardless of being synchronous or asynchronous.

One more important thing is that if an asynchronous transaction is blocked by
a synchronous transaction, it does not become synchronous as well.
This just means it will wait for the synchronous transaction to be committed.
But once it is done, the asynchronous transaction will be committed
immediately -- it won't wait for being replicated itself.

..  warning::

    Be careful when using synchronous and asynchronous transactions together.
    Asynchronous transactions are considered committed even if there is no connection to other nodes.
    Therefore, an old leader node (:ref:`synchronous transaction queue owner <box_info_synchro>`) might have some
    committed asynchronous transactions that no other replica set member has.

    When the connection to such an old (previous) leader node is restored, it starts receiving data from the new leader.
    At the same time, other replica set members receive the data from the previous leader that they don't have yet.
    The data from the previous leader contains some committed asynchronous transactions.
    At this time, the integrity protection will throw
    the :ref:`ER_SPLIT_BRAIN <repl_leader_elect_splitbrain>` error, which will force the user to rebootstrap the previous leader.


Limitations and known problems
------------------------------

Until version :doc:`2.5.2 </release/2.5.2>`,
there was no way to enable synchronous replication for
existing spaces, but since 2.5.2 it can be enabled by
:ref:`space_object:alter({is_sync = true}) <box_space-alter>`.

Synchronous transactions work only for master-slave topology. You can have multiple
replicas, anonymous replicas, but only one node can make synchronous transactions.

Since Tarantool :doc:`2.10.0 </release/2.10.0>`, anonymous replicas do not participate in the quorum.

Leader election
---------------

Starting from version :doc:`2.6.1 </release/2.6.1>`,
Tarantool has the built-in functionality
managing automated leader election in a replica set. For more information,
refer to the :ref:`corresponding chapter <repl_leader_elect>`.
