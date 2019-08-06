module A
module B
class C < SomethingElse

macro
  w         [\s\r\n\f]*

rule

# [:state]  pattern  [actions]

            {w}~={w}         { [:INCLUDES, text] }

end
end
end
