package App::Benchmark;

use strict;
use warnings;
use Test::More;
use Benchmark qw(cmpthese timethese :hireswallclock);
use IO::Capture::Stdout;


our $VERSION = '0.01';


use base 'Exporter';


our %EXPORT_TAGS = (
    util => [ qw/benchmark_diag/ ],
);

our @EXPORT_OK = @{ $EXPORT_TAGS{all} = [ map { @$_ } values %EXPORT_TAGS ] };


sub benchmark_diag {
    my ($iterations, $benchmark_hash) = @_;
    my $capture = IO::Capture::Stdout->new;

    $capture->start;
    cmpthese(timethese($iterations, $benchmark_hash));
    $capture->stop;

    {
        my $previous_default = select(STDOUT);
        $|++; # autoflush STDOUT
        select(STDERR);
        $|++; # autoflush STDERR
        select($previous_default);
    }

    chomp(my @lines = $capture->read);
    warn "# $_\n" for @lines;

    plan tests => 1;
    pass('benchmark');
}


1;


__END__

=head1 NAME

App::Benchmark - Output your benchmarks as test diagnostics

=head1 SYNOPSIS

    # This is t/benchmark.t:

    use App::Benchmark ':all';

    benchmark_diag(2_000_000, {
        sqrt => sub { sqrt(2) },
        log  => sub { log(2) },
    });

=head1 DESCRIPTION

This module makes it easy to run your benchmarks in a distribution's test
suite. This way you just have to look at the CPAN testers reports to see your
benchmarks being run on many different platforms using many different versions
of perl.

=head1 EXPORTS

Nothing is exported automatically. The function can be exported using its name
or the C<:all> tag.

=over 4

=item benchmark_diag

Takes a number of iterations and a benchmark definition hash, just like
C<timethese()> from the L<Benchmark> module. Runs the benchmarks and reports
them, each line prefixed by a hash sign so it doesn't mess up the TAP output.
Also, a pseudotest is being generated to keep the testing framework happy.

=back

=head1 BUGS AND LIMITATIONS

No bugs have been reported.

Please report any bugs or feature requests through the web interface at
L<http://rt.cpan.org>.

=head1 INSTALLATION

See perlmodinstall for information and options on installing Perl modules.

=head1 AVAILABILITY

The latest version of this module is available from the Comprehensive Perl
Archive Network (CPAN). Visit <http://www.perl.com/CPAN/> to find a CPAN
site near you. Or see <http://www.perl.com/CPAN/authors/id/M/MA/MARCEL/>.

=head1 AUTHORS

Marcel GrE<uuml>nauer, C<< <marcel@cpan.org> >>

=head1 COPYRIGHT AND LICENSE

Copyright 2008 by Marcel GrE<uuml>nauer

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

