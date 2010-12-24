use strict;
use warnings;
use Test::More tests => 4;
use Test::AutoName;

sub capture (&) {
    my $block = shift;

    my $output = '';

    my $original_fh = Test::More->builder->output;
    Test::More->builder->output(\$output);

    local $Test::Builder::Level = $Test::Builder::Level + 3;
    eval { $block->() };

    print $original_fh $output;
    Test::More->builder->output($original_fh);

    die if $@;

    chomp  $output;
    return $output;
}

my $foo = 1;

my $unnamed_test =
    capture { is $foo, 1 };

is $unnamed_test, q(ok 1 - L29: capture { is $foo, 1 };);

my $named_test =
    capture { is $foo, 1, 'named test' };

is $named_test, q(ok 3 - named test);
