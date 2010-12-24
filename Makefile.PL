use inc::Module::Install;

name 'Test-AutoName';
all_from 'lib/Test/AutoName.pm';

requires 'Test::Builder';

tests 't/*.t';
author_tests 'xt';

test_requires 'Test::More';
auto_set_repository;
auto_include;

WriteAll;
