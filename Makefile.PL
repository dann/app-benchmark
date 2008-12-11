use inc::Module::Install;
include 'Module::AutoInstall';

name 'App-Benchmark';
all_from 'lib/App/Benchmark.pm';
perl_version '5.008';

requires 'Benchmark';
requires 'IO::Capture::Stdout';

test_requires 'Test::More' => '0.70';
extra_tests;

auto_install;
auto_include;
WriteAll;
