.. _tt-build:

Building an application
=======================

..  code-block:: console

    $ tt build [PATH] [--spec SPEC_FILE_PATH]


``tt build`` builds a Tarantool application locally.

Options
-------

..  option:: --spec SPEC_FILE_PATH

    Path to a ``.rockspec`` file to use for the current build

Details
-------

The ``PATH`` argument should contain the path to the application directory
(that is, to the build source). The default path is ``.`` (current directory).

The application directory must contain a ``.rockspec`` file to use for the build.
If there is more than one ``.rockspec`` file in the application directory, specify
the one to use in the ``--spec`` argument.

``tt build`` builds an application with the ``tt rocks make`` command.
It downloads the application dependencies into the ``.rocks`` directory,
making the application ready to run locally.

Pre-build and post-build scripts
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In addition to building the application with LuaRocks, ``tt build``
can execute *pre-build* and *post-build* scripts. These scripts should
contain steps to execute right before and after building the application.
These files must be named ``tt.pre-build`` and ``tt.post-build`` correspondingly
and located in the application directory.

.. note::

    For compatibility with Cartridge applications,
    the pre-build and post-build scripts can also have names ``cartridge.pre-build``
    and ``cartridge.post-build``.

If your application depends on closed-source rocks, or if the build should contain
rocks from a project added as a submodule, **install** these
dependencies using the pre-build script **before** building.
For example, add the following line:

..  code-block:: bash

    tt rocks make --chdir ./third_party/proj

Learn more about :doc:`pre-build and post-build scripts </book/cartridge/cartridge_cli/pre-post-build>`.

Examples
--------

*   Build the application ``app1`` from its directory:

    ..  code-block:: console

        $ tt build

*   Build the application ``app1`` from the ``simple_app`` directory inside the current directory:

    ..  code-block:: console

        $ tt build simple_app

*   Build the application ``app1`` from its directory explicitly specifying the rockspec file to use:

    ..  code-block:: console

        $ tt build --spec app1-scm-1.rockspec