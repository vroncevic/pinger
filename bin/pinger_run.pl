#!/usr/bin/env perl
#
# @brief    Ping operation and logging statistics
# @version  ver.1.0
# @date     Sun Oct 25 11:15:32 2015
# @company  Frobas IT Department, www.frobas.com 2015
# @author   Vladimir Roncevic <vladimir.roncevic@frobas.com>
#
use strict;
use warnings;
use Pod::Usage;
use Getopt::Long;
use Cwd qw(abs_path);
use File::Basename qw(dirname);
use lib dirname(dirname(abs_path(__FILE__))) . '/bin';
use Pinger qw(pinger);
use lib abs_path(dirname(__FILE__)) . '/../../../lib/perl5';
use OrCheckStatus qw(or_check_status);
use Utils qw(def);
use Status;
our $TOOL_DBG = "false";

#
# @brief   Main entry point
# @param   Value optional help | manual
# @exitval Script tool pinger exit with integer value
#			0   - success operation
#			127 - run as root user
#			128 - failed to:
#				load configuration from CFG file or
#				write log message to LOG file or
#				send email notification
#
my ($help, $man, %morh);

if(@ARGV > 0) {
	GetOptions(
		'help|?' => \$help,
		'manual' => \$man
	) || pod2usage(2);
}

%morh = (HLP => def($help), MAN => def($man));

if(or_check_status(\%morh) == $SUCCESS) {
	if(def($help) == $SUCCESS) {
		pod2usage(1);
	}
	if(def($man) == $SUCCESS) {
		pod2usage(VERBOSE => 2);
	}
}

my $username = (getpwuid($>));
my $uid = ($<);

if(($username eq "root") && ($uid == 0)) {
	if(pinger() == $SUCCESS) {
		exit(0);
	}
	exit(128);
}

exit(127);
__END__

############################## POD pinger_run.pl ###############################

=head1 NAME

pinger - ping operation and logging statistics

=head1 SYNOPSIS

Use:

	pinger [options]

Examples:

	pinger --help

	pinger --manual

	# Ping operation and logging statistics

	pinger

=head1 DESCRIPTION

This script is for ping operation and logging statistics.

=head1 ARGUMENTS

pinger takes the following arguments:

=over 2

=item help

	help

(Optional.) Show help info information

=item manual

	help

(Optional.) Display manual information

=back

=head1 AUTHORS

Ullrich Nake, E<lt>ullrich.nake@frobas.comE<gt>
Vladimir Roncevic, E<lt>vladimir.roncevic@frobas.comE<gt>

=head1 COPYRIGHT

This program is distributed under the Frobas License.

=head1 DATE

23-Oct-2014

=cut

############################## POD pinger_run.pl ###############################
