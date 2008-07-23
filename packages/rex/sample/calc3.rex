#
# calc3.rex
# lexical scanner definition for rex
#

class Calculator3
macro
  BLANK         \s+
  DIGIT         \d+
rule
  {BLANK}
  {DIGIT}       { [:NUMBER, text.to_i] }
  .|\n          { [text, text] }
inner
end
