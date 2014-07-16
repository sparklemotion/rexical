#
# eooro1.rex
# lexical definition sample for rex
#

class Error1
macro
  BLANK         [\ \t]+
rule
  {BLANK}       # no action
  \d+           { [:digit, text.to_i] }
  \w+           { [:word, text] }
  \n
#  .             { [text, text] }
end
