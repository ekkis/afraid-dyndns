#!/usr/bin/perl

$|++;
$\ = $/;

for (readfile("/etc/afraid-dyndns.conf")) {
	chomp;
	print "1 [$_]";
	s/#.*//; s/^\s*//; s/\s*$//;
	next if /^$/;
	split /\s*=\s*/;
	print "2 [" . $_[0] . "==" . $_[1] . "]";
	$ARGV{$_[0]} = $_[1];
	}

die "shite" unless $ARGV{AccountHash};

sub readfile {
    my $f = shift || $_;
    local $_ if defined wantarray();
    -f $f || die "failed -f: $!";
    open(F, $f) || die $!;
    wantarray() && (@_ = <F>) || (local $/ = undef, $_ = <F>);
    close(F);
    wantarray() ? @_ : $_;
    }

