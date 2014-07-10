package Test::mysqld::CopyDataDumper::CLI;
use strict;
use warnings;

use Getopt::Long;
use Test::mysqld::CopyDataDumper;

sub run {
    my ($class, @argv) = @_;

    my ($opt,) = $class->parse_options(@argv);
    Test::mysqld::CopyDataDumper->new($opt)->dump;
}

sub parse_options {
    my ($class, @argv) = @_;

    my $parser = Getopt::Long::Parser->new(
        config => [qw/posix_default no_ignore_case/],
    );
    local @ARGV = @argv;
    $parser->getoptions(\my %opt, qw/
        ddl_file=s
        datadir=s
        fixtures=s@
    /);

    if (exists $opt{fixtures}) {
        $opt{fixtures} = [
            map { split /,/, $_ } @{ $opt{fixtures} }
        ];
    }
    (\%opt, \@ARGV);
}

1;
