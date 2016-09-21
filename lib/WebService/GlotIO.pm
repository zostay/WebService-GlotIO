package WebService::GlotIO;

use v5.14;
use warnings;

use JSON;
use LWP::UserAgent;

use WebService::GlotIO::Run;

sub new {
    my ($class, %o) = @_;
    bless \%o, $class;
}

sub ua {
    my ($self) = @_;
    return $self->{ua} //= LWP::UserAgent->new;
}

sub _auth {
    my ($self) = @_;
    if ($self->{token}) {
        return (Authorization => "Token $self->{token}");
    }
    return ();
}

sub runner {
    my ($self) = @_;
    return $self->{runner} //= WebService::GlotIO::Run->new($self);
}

sub get {
    my ($self, $url) = @_;
    my $r = $self->ua->get($url, $self->_auth);
    say $r->as_string;
    return decode_json($r->content);
}

sub post {
    my ($self, $url, $payload) = @_;
    use DDP;
    p $url;
    p $payload;
    say encode_json($payload);
    my $r = $self->ua->post($url,
        $self->_auth,
        Content_Type => 'application/json',
        Content => encode_json($payload),
    );
    p $r->as_string;
    return decode_json($r->content);
}

1;
