#!/usr/bin/perl
#
# @brief    Ping operation and logging statistics
# @version  ver.1.0
# @date     Sun Oct 25 11:15:32 2015
# @company  Frobas IT Department, www.frobas.com 2015
# @author   Vladimir Roncevic <vladimir.roncevic@frobas.com>
#
use strict;
use warnings;
use Sys::Hostname;
use Getopt::Long;
use Pod::Usage;
use File::Basename qw(dirname);
use Cwd qw(abs_path);
use lib dirname(dirname(abs_path($0))) . '/../../lib/perl5';
use Logging;
use Configuration;
use Notification;
use Status;

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
	my $fcaller = (caller(0))[3];
	my $host = hostname();
	my %preferences;
	my $preferences_ref = \%preferences;
	my $status = 1;
	$status = readpref($cfg, $preferences_ref);
	if($status == $NOT_SUCCESS) {
		exit(128);
	}
	my $ping_cmd = "ping -c5 " . $preferences{TARGET_HOST};
	my %notification;
	my $notification_ref=\%notification;
	$notification{ADMIN_EMAIL}=$preferences{ADMIN_EMAIL};
	$notification{EMAIL_FROM}="pinger\@$host";
	my %logger;
	my $logger_ref = \%logger;
	$logger{LOG_FILE_PATH}=$log;
	open(PING_STUFF,"$ping_cmd|");
	while (my $lyne = <PING_STUFF>) {
		if ($lyne =~ /time=(\S+)/) {
		    my $elt = $1;
		    my $log_line = "ping to $preferences{TARGET_HOST}";
			$logger{LOG_MESSAGE}="$log_line $elt ms";
			$status = logging($logger_ref);
			if($status == $NOT_SUCCESS) {
				exit(129);
			}
		    if ($elt > 300) {
		        $notification{MESSAGE}=$logger{LOG_MESSAGE};
		        $status = notify($notification_ref);
		        if($status == $NOT_SUCCESS) {
					exit(130);
		        }
		    } 
		}
	}
	my $msg = "Done";
	if($TOOL_DBG eq "true") {
		print("[Info] " . $fcaller . " " . $msg . "\n");
	}
	exit(0);
}

#
# @brief   Main entry point
# @param   Value optional help | manual
# @exitval Script tool pinger exit with integer value
#			0   - success operation 
# 			127 - run as root user
# 			128 - failed to load Configuration
# 			129 - failed to write log message 
# 			130 - failed to send email
#
my $help = 0;
my $man = 0;

if (@ARGV > 0) {
	GetOptions(
		'help|?' => \$help,
		'manual' => \$man) or pod2usage(2);
}

if ($man || $help) {
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

    progen help

    progen man

    #	Ping operation and logging statistics

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

Ullrich Nake, E<lt>ullrich.nake@frobas.comE<gt>.
Vladimir Roncevic, E<lt>vladimir.roncevic@frobas.comE<gt>.

=head1 COPYRIGHT

This program is distributed under the Frobas License.

=head1 DATE

23-Oct-2014

=cut

################################ POD pinger.pl #################################
