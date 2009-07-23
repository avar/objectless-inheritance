package Objectless::Inheritance;
no strict 'refs';

sub import
{

    my $caller = caller() . '::';
    *{"${caller}AUTOLOAD"} = \&AUTOLOAD;
}

sub AUTOLOAD
{
    our @ISA;
    our $AUTOLOAD;

    my ($pkg, $sub) = $AUTOLOAD =~ /^(.*?)::(.*)$/;

    for my $p (@{"${pkg}::ISA"})
    {
        no strict 'refs';
        if (ref *{"${p}::$sub"}{CODE}) {
            return *{"${p}::$sub"}{CODE}->(@_);
        }
    }

    die "Can't find sub $AUTOLOAD";
}

1;
