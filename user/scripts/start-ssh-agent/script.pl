#!/usr/bin/env perl

use strict;
use warnings;

use Env qw(HOME);

exit 1 unless -d "$HOME/.ssh";

my $AGENT_SOCK_FILE = "$HOME/.ssh/agent_sock";
my $AGENT_PID_FILE = "$HOME/.ssh/agent_pid";

sub run {
	my $exe = $_[0];
	my $out = `$exe`;
	die "couldn't execute '$exe'" unless $? == 0;
	return $out;
}

sub killall {
	my $procname = $_[0];
	my $out = run("ps -A");
	foreach my $line (split(/\n/, $out)) {
		$_ = $line;
		if (/$procname$/) {
			my $pid = (split(" "))[0];
			kill("HUP", $pid);
		}
	}
}

sub slurp_file {
	my $filename = $_[0];
	open my $fh, "<", $filename or die "couldn't open '$filename'";
	read $fh, my $content, -s $fh;
	return $content;
}

sub write_file {
	my ($filename, $content) = @_;
	open my $fh, ">", $filename or die "couldn't open '$filename'";
	print $fh $content;
}

sub start_agent {
	my $ssh_agent_output = run("ssh-agent -c");
	my @split = split(/ /, $ssh_agent_output);
	my $agent_sock = substr($split[2], 0, index($split[2], ";"));
	my $agent_pid = substr($split[4], 0, index($split[4], ";"));
	write_file($AGENT_SOCK_FILE, $agent_sock);
	write_file($AGENT_PID_FILE, $agent_pid);
	print "$agent_sock:$agent_pid\n";
}

unless (-e $AGENT_PID_FILE && -e $AGENT_SOCK_FILE) {
	killall("ssh-agent");
	start_agent;
	exit 0;
} else {
	my $pid = slurp_file($AGENT_PID_FILE);
	my $sock = slurp_file($AGENT_SOCK_FILE);

	if (system("ps $pid > /dev/null") || !(-S $sock)) {
		unlink ($AGENT_SOCK_FILE, $AGENT_PID_FILE);
		start_agent;
		exit 0;
	}

	print "$sock:$pid\n";
}
