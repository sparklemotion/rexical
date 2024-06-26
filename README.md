# Rexical

* http://github.com/sparklemotion/rexical

## DESCRIPTION

Rexical is a lexical scanner generator that is used with Racc to generate Ruby programs. Rexical is
written in Ruby.


## SYNOPSIS

Several examples of Rexical grammar files are provided in the sample directory.

Here is an example of a lexical definition:

    class Sample
    macro
      BLANK         [\ \t]+
    rule
      {BLANK}       # no action
      \d+           { [:digit, text.to_i] }
      \w+           { [:word, text] }
      \n
      .             { [text, text] }
    end

Here are examples of the command line usage:

    $ rex  sample1.rex  --stub
    $ ruby sample1.rex.rb  sample1.c

    $ rex  sample2.rex  --stub
    $ ruby sample2.rex.rb  sample2.bas

    $ racc calc3.racc
    $ rex  calc3.rex
    $ ruby calc3.tab.rb

The description files for lexical analysis in the sample directory are the files ending with the
.rex extension.

## REQUIREMENTS

*  ruby version 1.8.x or later.

## INSTALL

* sudo gem install rexical

## LICENSE

Rexical is distributed under the terms of the GNU Lesser General Public License version 2. Note that
you do NOT need to follow LGPL for your own parser (Rexical outputs). You can provide those files
under any licenses you want.

See COPYING for more details.
