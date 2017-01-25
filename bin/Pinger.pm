package Pinger;
#
# @brief    Ping operation and logging statistics
# @version  ver.1.0
# @date     Sun Oct 25 11:15:32 2015
# @company  Frobas IT Department, www.frobas.com 2015
# @author   Vladimir Roncevic <vladimir.roncevic@frobas.com>
#
use strict;
use warnings;
use Exporter;
use Sys::Hostname;
use Cwd qw(abs_path);
use File::Basename qw(dirname);
use lib dirname(dirname(abs_path($0))) . '/../../lib/perl5';
use InfoDebugMessage qw(info_debug_message);
use Configuration qw(read_preference);
use Notification qw(notify);
use Logging qw(logging);
use Status;
our @ISA = qw(Exporter);
our %EXPORT_TAGS = ('all' => [qw()]);
our @EXPORT_OK = (@{$EXPORT_TAGS{'all'}});
our @EXPORT = qw(pinger);
our $VERSION = '1.0';
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
	my ($host, $pingCmd, $msg, %prefStruct, %notStruct, %logStruct, $cfg, $log);
	$cfg = dirname(dirname(abs_path($0))) . "/conf/pinger.cfg";
	$log = dirname(dirname(abs_path($0))) . "/log/pinger.log";
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

1;
__END__

=head1 NAME

Pinger - Ping operation and logging statistics

=head1 SYNOPSIS

	use Pinger qw(pinger);

	...

	pinger();

=head1 DESCRIPTION 

Ping operation and logging statistics

=head2 EXPORT

pinger - None

=head1 AUTHORS

Ullrich Nake, E<lt>ullrich.nake@frobas.comE<gt>
Vladimir Roncevic, E<lt>vladimir.roncevic@frobas.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2016 by www.frobas.com

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.18.2 or,
at your option, any later version of Perl 5 you may have available.

=cut
