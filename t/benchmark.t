#!/usr/bin/env perl

use warnings;
use strict;
use App::Benchmark ':all';

benchmark_diag(2_000_000, {
    sqrt => sub { sqrt(2) },
    log  => sub { log(2) },
});

