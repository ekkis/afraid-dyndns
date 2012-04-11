#!/usr/bin/perl

$|++;
$\=$/;

use LWP::Simple;
use XML::Simple;

$CONF = "/etc/afraid-dyndns.conf";
for (readfile($CONF)) {
	chomp; s/#.*//; split /\s*=\s*/;
	$ARGV{$_[0]} = $_[1];
	}
$ARGV{CacheFile} ||= "/var/cache/afraid-dyndns/IP";
$afraid = "http://freedns.afraid.org/api/?action=getdyndns&sha=%s&style=xml";
$url = sprintf($afraid, $ARGV{AccountHash});
# print $url;

$xml = get($url);
print "-" x 30;
print $xml;
print "-" x 30;
$o = XMLin($xml, ForceArray => ["item"]);
for (@{$o->{item}}) {
	print $_->{host};
}

sub readfile {
    my $f = shift || $_;
    local $_ if defined wantarray();
    -f $f || return;
    open(F, $f) || warn($!) && return;
    wantarray() && (@_ = <F>) || (local $/ = undef, $_ = <F>);
    close(F);
    wantarray() ? @_ : $_;
    }
