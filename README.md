# DB manager

**pinger** is tool for checking hosts.

Developed in **[perl](https://www.perl.org/)** code: **100%**.

A README file is required for CPAN modules since CPAN extracts the
README file from a module distribution so that people browsing the
archive can use it get an idea of the modules uses. It is usually a
good idea to provide version information here so that people can
decide whether fixes for the module are worth downloading.

![Perl package](https://github.com/vroncevic/pinger/workflows/pinger_checker/badge.svg?branch=master) [![GitHub issues open](https://img.shields.io/github/issues/vroncevic/pinger.svg)](https://github.com/vroncevic/pinger/issues) [![GitHub contributors](https://img.shields.io/github/contributors/vroncevic/pinger.svg)](https://github.com/vroncevic/pinger/graphs/contributors)

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**

- [Installation](#installation)
- [Dependencies](#dependencies)
- [Library structure](#library-structure)
- [Docs](#docs)
- [Copyright and licence](#copyright-and-licence)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

### Installation

Follow instructions from README for each module.

Set INSTALL_BASE=/usr/local/perl/

### Dependencies

**pinger** requires next modules and libraries

Check requires from README for each module.

### Library structure

```bash
    pinger/
       ├── bin/
       │   ├── Pinger.pm
       │   └── pinger_run.pl
       ├── conf/
       │   └── pinger.cfg
       └── log/
           └── pinger.log
```

### Docs

[![Documentation Status](https://readthedocs.org/projects/pinger/badge/?version=latest)](https://pinger.readthedocs.io/projects/pinger/en/latest/?badge=latest)

More documentation and info at

* [pinger.readthedocs.io](https://pinger.readthedocs.io/en/latest/)
* [www.perl.org](https://www.perl.org/)

### Copyright and licence

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) [![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

Copyright (C) 2016 - 2024 by [vroncevic.github.io/pinger](https://vroncevic.github.io/pinger/)

**pinger** is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.18.2 or,
at your option, any later version of Perl 5 you may have available.
