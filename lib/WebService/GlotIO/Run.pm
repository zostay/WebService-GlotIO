package WebService::GlotIO::Run;

use v5.14;
use warnings;

use constant DEFAULT_BASE => 'https://run.glot.io';

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

sub list_languages {
    my ($self) = @_;
    $self->get('/languages');
}

sub list_versions {
    my ($self, %o) = @_;
    $self->get("/languages/$o{language}");
}

sub run {
    my ($self, %o) = @_;
    use DDP;
    p %o;
    $o{version} //= 'latest';
    $self->post("/languages/$o{language}/$o{version}", $o{program});
}

1;
