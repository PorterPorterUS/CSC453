#!/usr/bin/env ruby

# Attention! This is required for the extconf.rb file
require 'mkmf'

# optional.
create_header

# create a Makefile
create_makefile("CFixedArray")