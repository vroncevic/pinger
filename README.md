# Ping test analytic tool (Perl tool)
The README is used to introduce the tool and provide instructions on
how to install the tool, any machine dependencies it may have and any
other information that should be provided before the tool is installed.

A README file is required for CPAN modules since CPAN extracts the
README file from a module distribution so that people browsing the
archive can use it get an idea of the modules uses. It is usually a
good idea to provide version information here so that people can
decide whether fixes for the module are worth downloading.

### INSTALLATION

To install this tool type the following:
```
cp -R  ~/bin/   /root/scripts/pinger/ver.1.0/
cp -R  ~/conf/  /root/scripts/pinger/ver.1.0/
cp -R  ~/log/   /root/scripts/pinger/ver.1.0/
```
Location of perl-util:

	/usr/local/perl/lib/perl5/

### DEPENDENCIES

This tool requires these other modules and libraries:
```
strict
warnings
Sys::Hostname
Getopt::Long
Pod::Usage
Logging   https://github.com/vroncevic/perl_util
Configuration   https://github.com/vroncevic/perl_util
Notification   https://github.com/vroncevic/perl_util
Status   https://github.com/vroncevic/perl_util
```
### COPYRIGHT AND LICENCE

Copyright (C) 2016 by https://github.com/vroncevic/pinger

This tool is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.18.2 or,
at your option, any later version of Perl 5 you may have available.

