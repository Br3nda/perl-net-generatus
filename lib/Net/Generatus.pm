package Net::Twitter::Search;

use warnings;
use strict;
use base qw/Net/;
use URI::Escape;

our $VERSION = '0.20';
#http://search.twitter.com/search.json?q=<query>

sub search {
    my $self = shift;
	$self->set_user_agent("Net::Generatus-$VERSION (PERL)");

    my $query = shift;
    my $params = shift || {};

    #grab the params
    my $rpp = $params->{'rpp'} || 10;
    my $page = $params->{'page'} || 1;

    my $lang = $params->{'lang'} || undef;
    my $since_id = $params->{'since'} || undef;
    my $geocode = $params->{'since'} || undef;

    #build URL
    my $url = 'http://search.twitter.com/search.json?q=' . URI::Escape::uri_escape($query) .'&page='. $page;

    $url .= '&lang=' . URI::Escape::uri_escape($lang) if ($lang);
    $url .= '&since_id=' . URI::Escape::uri_escape($since_id) if ($since_id);
    $url .= '&geocode=' . URI::Escape::uri_escape($geocode) if ($geocode);

    #do request
    my $req = $self->{ua}->get($url);
	my $response = $ua->post('http://www.generatus.com/AJAXStatus.asp?N=&G=' . $gender . '&k=');

	if ($response->is_success) {
    	 $raw = $response->decoded_content;  # or whatever
 	}
 	else {
     	die $response->status_line;
 	}

	my @bits = split(/\#\#\#/, $raw);
	my $status = $bits[0];
	chomp $status;	
	return $status;	
}

# sub set_user_agent {
# 	my $self = shift;
# 	my $agent = shift;
# 	$self->{ua}->agent($agent);
# }

1;

=head1 NAME

Net::Generatus

=head1 SYNOPSYS

  use Net::Generatus;

  my $gen = Net::Generatus->new();


    
=head1 DESCRIPTION

For searching twitter - handy for bots

=head1 METHODS

=head2 search 

required parameter: query

returns: hash

=head2 SEARCH EXAMPLES

Find tweets containing a word

  $results = $twitter->search('word');

Find tweets from a user:

  $results = $twitter->search('from:br3nda');

Find tweets to a user:

  $results = $twitter->search('to:serenecloud');

Find tweets referencing a user:

  $results = $twitter->search('@br3ndabot');

Find tweets containing a hashtag:

  $results = $twitter->search('#perl');

Combine any of the operators together:

  $results = $twitter->search('solaris anger from:br3nda');

 
=head2 SEARCH ADDITIONAL PARAMETERS 

  The search method also supports the following optional URL parameters:
 
=head3 lang

Restricts tweets to the given language, given by an ISO 639-1 code.

  $results = $twitter->search('hello', {lang=>'en'});
  #search for hello in maori
  $results = $twitter->search('kiaora', {lang=>'mi'});


=head3 rpp

The number of tweets to return per page, up to a max of 100.

  $results = $twitter->search('love', {rpp=>'10'});

=head3 page

The page number to return, up to a max of roughly 1500 results (based on rpp * page)

  #get page 3
  $results = $twitter->search('love', {page=>'3'});

=head3 since_id

Returns tweets with status ids greater than the given id.

  $results = $twitter->search('love', {since_id=>'1021356410'});

=head3 geocode

returns tweets by users located within a given radius of the given latitude/longitude, where the user's location is taken from their Twitter profile. The parameter value is specified by "latitide,longitude,radius", where radius units must be specified as either "mi" (miles) or "km" (kilometers).

 $results = $twitter->search('coffee', {geocode=> '40.757929,-73.985506,25km'});

Note that you cannot use the near operator via the API to geocode arbitrary locations; however you can use this geocode parameter to search near geocodes directly.

=head2 treads

Returns the top ten queries that are currently trending on Twitter.  The response includes the time of the request, the name of each trending topic, and the url to the Twitter Search results page for that topic.

=head3 TRENDS EXAMPLES

  my $results = $twitter->trends();
  foreach my $trend(@{ $results }) {
    print $trend->{name} .' '. $trend->{url} ."\n";
  }

=head2 set_user_agent
The search.twitter.com terms of service request that you set the user agent of the request to something meaningful. This helps us answer any questions about your use of the API.


=head1 SEE ALSO

L<Net::Twitter>

=head1 AUTHOR

Brenda Wallace <shiny@cpan.org>

=cut
