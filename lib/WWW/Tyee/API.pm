package WWW::Tyee::API;

use 5.006;
use strict;
use warnings;

use Carp;
use JSON;
use Try::Tiny;
use HTTP::Tiny;
use URI::Escape 'uri_escape';

use Data::Dump qw(dump);

=head1 NAME

WWW::Tyee::API - The great new WWW::Tyee::API!

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

Quick summary of what the module does.

Perhaps a little code snippet.

    use WWW::Tyee::API;

    my $foo = WWW::Tyee::API->new();
    ...

=head1 EXPORT

A list of functions that can be exported.  You can delete this section
if you don't export anything, such as for a purely object-oriented module.

=head1 SUBROUTINES/METHODS

=head2 get_latest_grouped 

=cut

sub get_latest_grouped {
        my $response = HTTP::Tiny->new->get('http://preview.api.thetyee.ca/v1/latest/grouped');
        croak "Problem with response" unless $response->{'success'};

        my $results = decode_result( $response->{'content'} );
        my $stories = $results->{'hits'}{'hits'};
        $stories = unfuck( $stories );
        return $stories
}

sub get_topic {
        my ( $self, $topic ) = @_;
        my $response = HTTP::Tiny->new->get('http://preview.api.thetyee.ca/v1/topic/' . $topic );
        croak "Problem with response" unless $response->{'success'};

        my $results = decode_result( $response->{'content'} );
        my $stories = $results->{'hits'}{'hits'};
        $stories = unfuck( $stories );
        return $stories
}

sub get_story {
        my ($self, $path) = @_;
        my $response = HTTP::Tiny->new->get('http://preview.api.thetyee.ca/v1/search/path/' . $path );
        croak "Problem with response" unless $response->{'success'};

        my $stories = [];
        my $results = decode_result( $response->{'content'} );
        $stories = $results->{'hits'}{'hits'};
        $stories = unfuck( $stories );
        my $story   = @$stories[0];
        return $story;
}

sub get_query {
        my ( $self, $query ) = @_;
        my $response = HTTP::Tiny->new->get('http://preview.api.thetyee.ca/v1/search/' . $query );
        croak "Problem with response" unless $response->{'success'};

        my $results = decode_result( $response->{'content'} );
        my $stories = $results->{'hits'}{'hits'};
        $stories = unfuck( $stories );
        return $stories
}

=head2 decode_result

=cut

sub decode_result {
    my $content = shift;
    my $decoded_result;
    try   { $decoded_result = decode_json $content  }
    catch { croak "Couldn't decode '$content': $_" };
    return $decoded_result
}

=head2 unfuck

=cut

sub unfuck {
    my $old_array = shift;
    my $new_array = [];
    my $new_object = {};
    foreach my $old_object ( @$old_array ) {
       my $new_object = $old_object->{'_source'};
       push @$new_array, $new_object; 
    }
    return $new_array;
}

=head1 AUTHOR

Phillip Smith, C<< <ps at phillipadsmith.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-www-tyee-api at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=WWW-Tyee-API>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc WWW::Tyee::API


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=WWW-Tyee-API>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/WWW-Tyee-API>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/WWW-Tyee-API>

=item * Search CPAN

L<http://search.cpan.org/dist/WWW-Tyee-API/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2011 Phillip Smith.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut

1; # End of WWW::Tyee::API
