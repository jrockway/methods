use inc::Module::Install;

name 'methods';
all_from 'lib/methods.pm';

build_requires 'Test::More';
build_requires 'ok';

WriteAll();
