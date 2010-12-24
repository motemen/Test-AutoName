package Test::AutoName;
use strict;
use warnings;
use Test::Builder;

our $VERSION = '0.01';

our $ORIGINAL_ok = \&Test::Builder::ok;
our %FileCache;

no warnings 'redefine';

*Test::Builder::ok = sub {
	$_[2] ||= do {
		my ($package, $filename, $lnum) = caller($Test::Builder::Level);
		my $file = $FileCache{$filename} ||= do {
            open my $fh, '<', $filename;
            [ <$fh> ];
        };
		my $line = $file->[$lnum-1];
		$line =~ s{^\s+|\s+$}{}g;
		"L$lnum: $line";
	};
	goto &$ORIGINAL_ok;
};

1;

__END__

=head1 NAME

Test::AutoName - Name unnamed tests automatically

=head1 SYNOPSIS

  use Test::AutoName;

=head1 DESCRIPTION

Test::AutoName helps your testing by blah blah

=head1 AUTHOR

motemen E<lt>motemen {at} gmail.comE<gt>

cho45

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
