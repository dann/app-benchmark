use inc::Module::Install;
include 'Module::AutoInstall';

name 'App-Benchmark';
all_from 'lib/App/Benchmark.pm';
perl_version '5.006';

requires 'Benchmark';
requires 'IO::Capture::Stdout';

recommends 'Test::Pod';
recommends 'Test::Pod::Coverage';

test_requires 'Test::More' => '0.70';
test_requires 'Test::Compile';

auto_install;
auto_include;
WriteAll;
