package Pinger;
#
# @brief    Ping operation and logging statistics
# @version  ver.1.0
# @date     Sun Oct 25 11:15:32 2015
# @company  Frobas IT Department, www.frobas.com 2015
# @author   Vladimir Roncevic <vladimir.roncevic@frobas.com>
#
use warnings FATAL => 'all';
use strict;
use Sys::Hostname;
use Cwd qw(abs_path);
use File::Basename qw(dirname);
use Exporter;
use vars qw($VERSION @ISA %EXPORT_TAGS @EXPORT_OK @EXPORT);
$VERSION = '1.0';
@ISA = qw(Exporter);
@EXPORT = qw();
%EXPORT_TAGS = ('all' => [qw(pinger)]);
@EXPORT_OK = (@{$EXPORT_TAGS{'all'}});

use lib '/usr/local/perl/lib/perl5';
use InfoDebugMessage qw(info_debug_message);
use Configuration qw(read_preference);
use Notification qw(notify);
use Logging qw(logging);
use Status qw(:all);

#
# @brief   Ping operation and logging statistics
# @param   None
# @retval  Success 1, else 0
#
# @usage
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
# use Pinger qw(pinger);
#
# ...
#
# if(pinger()) {
#    # true
#    # notify admin | user
# } else {
#    # false
#    # return NOT_SUCCESS
#    # or
#    # exit 128
# }
#
sub pinger {
    my ($host, $pingCmd, $msg, %prefStruct, %notStruct, %logStruct, $cfg, $log);
    $cfg = dirname(dirname(abs_path(__FILE__))) . "/conf/pinger.cfg";
    $log = dirname(dirname(abs_path(__FILE__))) . "/log/pinger.log";
    if(read_preference($cfg, \%prefStruct)) {
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
                if(logging(\%logStruct)) {
                    if($elt > 300) {
                        $notStruct{MESSAGE} = $logStruct{LOG_MESSAGE};
                        if(not notify(\%notStruct)) {
                            return (NOT_SUCCESS);
                        }
                    }
                } else {
                    return (NOT_SUCCESS);
                }
            }
        }
        $msg = "Done";
        close(PING_STUFF);
        info_debug_message($msg);
        return (SUCCESS);
    }
    return (NOT_SUCCESS);
}

1;
__END__

=head1 NAME

Pinger - Ping operation and logging statistics

=head1 SYNOPSIS

    use Pinger qw(pinger);

    ...

    if(pinger()) {
        # true
        # notify admin | user
    } else {
        # false
        # return NOT_SUCCESS
        # or
        # exit 128
    }

=head1 DESCRIPTION 

Ping operation and logging statistics

=head2 EXPORT

pinger - return 1 for success, else 0

=head1 AUTHORS

Ullrich Nake, E<lt>ullrich.nake@frobas.comE<gt>
Vladimir Roncevic, E<lt>vladimir.roncevic@frobas.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2016 by www.frobas.com

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.18.2 or,
at your option, any later version of Perl 5 you may have available.

=cut
