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
our $TOOL_DBG = "false";

#
# @brief   Main entry point
# @param   Value optional help | manual
# @exitval Script tool pinger exit with integer value
#			0   - success operation
# 			127 - run as root user
# 			128 - failed to load configuration from CFG file
# 			129 - failed to write log message to LOG file
# 			130 - failed to send email notification
#
my $help = 0;
my $man = 0;

if(@ARGV > 0) {
	GetOptions(
		'help|?' => \$help,
		'manual' => \$man
	) || pod2usage(2);
}

if($man || $help) {
	if($help) {
		pod2usage(1);
	}
	if($man) {
		pod2usage(VERBOSE => 2);
	}
}

my $username = (getpwuid($>));
my $uid = ($<);

if(($username eq "root") && ($uid == 0)) {
	pinger();
}

exit(127);
__END__

################################ POD pinger.pl #################################

=head1 NAME

pinger - ping operation and logging statistics

=head1 SYNOPSIS

Use:

	pinger [options] 

Examples:

	pinger help

	pinger man

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

################################ POD pinger.pl #################################
