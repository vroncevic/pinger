pinger
--------

**pinger** is tool for checking hosts.

Developed in `perl <https://www.perl.org/>`_ code.

The README is used to introduce the modules and provide instructions on
how to install the modules, any machine dependencies it may have and any
other information that should be provided before the modules are installed.

|pinger checker| |pinger github issues| |pinger github contributors|

|pinger documentation status|

.. |pinger checker| image:: https://github.com/vroncevic/pinger/actions/workflows/pinger_checker.yml/badge.svg
   :target: https://github.com/vroncevic/pinger/actions/workflows/pinger_checker.yml

.. |pinger github issues| image:: https://img.shields.io/github/issues/vroncevic/pinger.svg
   :target: https://github.com/vroncevic/pinger/issues

.. |pinger github contributors| image:: https://img.shields.io/github/contributors/vroncevic/pinger.svg
   :target: https://github.com/vroncevic/pinger/graphs/contributors

.. |pinger documentation status| image:: https://readthedocs.org/projects/pinger/badge/?version=master
   :target: https://pinger.readthedocs.io/?badge=master

.. toctree::
   :maxdepth: 4
   :caption: Contents

   self

Installation
-------------

Used next development environment

|debian linux os|

.. |debian linux os| image:: https://raw.githubusercontent.com/vroncevic/pinger/dev/docs/debtux.png

Navigate to release `page`_ download and extract release archive.

.. _page: https://github.com/vroncevic/pinger/releases

To install **pinger** 

Follow instructions from README for each module.

Set INSTALL_BASE=/usr/local/perl/

Dependencies
-------------

**pinger** requires next modules and libraries

Check requires from README for each module.

Library structure
--------------------

**pinger** is based on MOP.

Library structure

.. code-block:: bash

    pinger/
       ├── bin/
       │   ├── Pinger.pm
       │   └── pinger_run.pl
       ├── conf/
       │   └── pinger.cfg
       └── log/
           └── pinger.log

Copyright and licence
----------------------

|license: gpl v3| |license: apache 2.0|

.. |license: gpl v3| image:: https://img.shields.io/badge/License-GPLv3-blue.svg
   :target: https://www.gnu.org/licenses/gpl-3.0

.. |license: apache 2.0| image:: https://img.shields.io/badge/License-Apache%202.0-blue.svg
   :target: https://opensource.org/licenses/Apache-2.0

Copyright (C) 2016 - 2024 by `vroncevic.github.io/pinger <https://vroncevic.github.io/pinger>`_

**pinger** is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.18.2 or,
at your option, any later version of Perl 5 you may have available.

Indices and tables
------------------

* :ref:`genindex`
* :ref:`modindex`
* :ref:`search`
