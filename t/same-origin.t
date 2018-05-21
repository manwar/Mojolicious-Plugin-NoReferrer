use Mojo::Base -strict;

use Test::More;
use Mojolicious::Lite;
use Test::Mojo;

plugin 'NoReferrer' => { content => 'same-origin' };

get '/' => sub {
    my $c = shift;
    $c->render( 'index' );
};

my $t = Test::Mojo->new;
$t->get_ok('/')->status_is(200)->content_like( qr{<meta name="referrer" content="same-origin">} );

done_testing();

__DATA__
@@ index.html.ep
% layout 'default';

@@ layouts/default.html.ep
<html>
  <head>
  </head>
</html>