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
use Sys::Hostname;
use Getopt::Long;
use Cwd qw(abs_path);
use File::Basename qw(dirname);
use lib dirname(dirname(abs_path($0))) . '/../../lib/perl5';
use Status qw($SUCCESS $NOT_SUCCESS check_status);
use InfoDebugMessage qw(info_debug_message);
use Configuration qw(read_preference);
use Notification qw(notify);
use Logging qw(logging);

my $cfg = dirname(dirname(abs_path($0))) . "/conf/pinger.cfg";
my $log = dirname(dirname(abs_path($0))) . "/log/pinger.log";
our $TOOL_DBG="false";

#
# @brief   Ping operation and logging statistics
# @param   None
# @exitval Success 0, else 128, 129, 130
#
# @usage
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# 
# pinger()
#
sub pinger {
	my ($host, $pingCmd, $msg, %prefStruct, %notStruct, %logStruct);
	if(read_preference($cfg, \%prefStruct) == $SUCCESS) {
		$pingCmd = "ping -c5 " . $prefStruct{TARGET_HOST};
		$notStruct{ADMIN_EMAIL} = $prefStruct{ADMIN_EMAIL};
		$host = hostname();
		$notStruct{EMAIL_FROM} = "pinger\@$host";
		$logStruct{LOG_FILE_PATH} = $log;
		$msg = "Start ping command";
		info_debug_message($msg);
		open(PING_STUFF,"$pingCmd |");
		my ($lyne, $elt, $logLine);
		while($lyne = <PING_STUFF>) {
			if($lyne =~ /time=(\S+)/) {
				$elt = $1;
				$logLine = "ping to $prefStruct{TARGET_HOST}";
				$logStruct{LOG_MESSAGE} = "$logLine $elt ms";
				if(logging(\%logStruct) == $SUCCESS) {
					if($elt > 300) {
						$notStruct{MESSAGE} = $logStruct{LOG_MESSAGE};
						if(notify(\%notStruct) == $SUCCESS) {
							next;
						}
						exit(130);
					}
					next;
				}
				exit(129);
			}
			next;
		}
		$msg = "Done";
		info_debug_message($msg);
		exit(0);
	}
	exit(128);
}

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
		'manual' => \$man) or pod2usage(2);
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
