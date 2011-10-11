#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'WWW::Tyee::API' ) || print "Bail out!\n";
}

diag( "Testing WWW::Tyee::API $WWW::Tyee::API::VERSION, Perl $], $^X" );
