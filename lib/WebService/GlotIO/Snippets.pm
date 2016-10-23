package WebService::GlotIO::Snippets;

use v5.14;
use warnings;

use constant DEFAULT_BASE => 'https://snippets.glot.io';

sub new {
    my ($class, $api) = @_;
    bless {
        api  => $api,
        base => DEFAULT_BASE,
    }, $class;
}

sub api  { shift->{api} }
sub base { shift->{base} }

sub get {
    my $self = shift;
    my $url = shift;
    $self->api->get($self->base . $url);
}

sub post {
    my $self = shift;
    my $url = shift;
    $self->api->post($self->base . $url, @_);
}

sub list_snippets {
    my ($self) = @_;
    $self->get('/snippets');
}


1;
