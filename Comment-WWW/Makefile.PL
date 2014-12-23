use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
    VERSION   => '0.01',
    PREREQ_PM => {
        'Mojolicious'                           => '5.47',
        'Mojolicious::Plugin::Authentication'   => 0,
    },
    test      => {TESTS => 't/*.t'}
);
