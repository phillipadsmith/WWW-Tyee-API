#!/usr/bin/perl 
#===============================================================================
#
#         FILE:  test.pl
#
#        USAGE:  ./test.pl  
#
#  DESCRIPTION:  
#
#      OPTIONS:  ---
# REQUIREMENTS:  ---
#         BUGS:  ---
#        NOTES:  ---
#       AUTHOR:  YOUR NAME (), 
#      COMPANY:  
#      VERSION:  1.0
#      CREATED:  11/09/2011 13:57:59
#     REVISION:  ---
#===============================================================================

use strict;
use warnings;

use FindBin;
use lib "$FindBin::Bin/../lib";

use WWW::Tyee::API; 
use Data::Dump qw( dump );

my $latest = WWW::Tyee::API->get_latest_grouped();

# dump( $latest );

my $story = WWW::Tyee::API->get_story('Life/2011/09/10/Worlds-Ground-Zeroes/');

dump ( $story );

