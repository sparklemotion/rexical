#
# sample1.rex
# lexical definition sample for rex
#
# usage
#  rex  sample1.rex  --stub
#  ruby sample1.rex.rb  sample1.c
#

class Sample1
macro
  BLANK         \s+
  REM_IN        \/\*
  REM_OUT       \*\/
  REM           \/\/

rule

# [:state]  pattern  [actions]

# remark
                {REM_IN}        { state = :REMS; [:rem_in, text] }
  :REMS         {REM_OUT}       { state = nil;   [:rem_out, text] }
  :REMS         .*(?={REM_OUT}) {                [:remark, text] }
                {REM}           { state = :REM;  [:rem_in, text] }
  :REM          \n              { state = nil;   [:rem_out, text] }
  :REM          .*(?=$)         {                [:remark, text] }

# literal
                \"[^"]*\"       { [:string, text] } # "
                \'[^']\'        { [:character, text] } # '

# skip
                {BLANK}         # no action

# numeric
                \d+             { [:digit, text.to_i] }

# identifier
                \w+             { [:word, text] }
                .               { [text, text] }

end
