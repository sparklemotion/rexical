#!C:/Program Files/ruby-1.8/bin/ruby
#
# rex
#
#   Copyright (c) 2005 ARIMA Yasuhiro <arima.yasuhiro@nifty.com>
#
#   This program is free software.
#   You can distribute/modify this program under the terms of
#   the GNU LGPL, Lesser General Public License version 2.1.
#   For details of LGPL, see the file "COPYING".
#

## ---------------------------------------------------------------------

REX_OPTIONS  =  <<-EOT

o -o --output-file <outfile>  file name of output [<filename>.rb]
o -s --stub             - append stub code for debug
o -i --ignorecase       - ignore char case
o -C --check-only       - syntax check only
o -  --independent      - independent mode
o -d --debug            - print debug information
o -h --help             - print this message and quit
o -  --version          - print version and quit
o -  --copyright        - print copyright and quit

EOT

## ---------------------------------------------------------------------

require 'getoptlong'
require 'rex/generator'
require 'rex/info'

## ---------------------------------------------------------------------

=begin
class Rex
  def initialize
  end
end
=end

def main
  $cmd  =  File.basename($0, ".rb")
  opt  =  get_options
  filename  =  ARGV[0]

  rex  =  Rex::Generator.new(opt)
  begin
    rex.grammar_file  =  filename
    rex.read_grammar
    rex.parse
    if opt['--check-only']
      $stderr.puts "syntax ok"
      return  0
    end
    rex.write_scanner

  rescue Rex::ParseError, Errno::ENOENT
    msg  =  $!.to_s
    unless /\A\d/ === msg
      msg[0,0]  =  ' '
    end
    $stderr.puts "#{$cmd}:#{rex.grammar_file}:#{rex.lineno}:#{msg}"
    return  1

  end
  return  0
end

## ---------------------------------------------------------------------
def get_options
  tmp  =  REX_OPTIONS.collect do |line|
      next if /\A\s*\z/ === line
      disp, sopt, lopt, takearg, doc  =  line.strip.split(/\s+/, 5)
      a  =  []
      a.push lopt    unless lopt == '-'
      a.push sopt    unless sopt == '-'
      a.push takearg == '-' ?
             GetoptLong::NO_ARGUMENT : GetoptLong::REQUIRED_ARGUMENT
      a
  end
  getopt  =  GetoptLong.new(*tmp.compact)
  getopt.quiet  =  true

  opt  =  {}
  begin
    getopt.each do |name, arg|
      raise GetoptLong::InvalidOption,
          "#{$cmd}: #{name} given twice" if opt.key? name
      opt[name]  =  arg.empty? ? true : arg
    end
  rescue GetoptLong::AmbigousOption, GetoptLong::InvalidOption,
         GetoptLong::MissingArgument, GetoptLong::NeedlessArgument
    usage 1, $!.message
  end

  usage    if opt['--help']

  if opt['--version']
    puts "#{$cmd} version #{Rex::VERSION}"
    exit 0
  end
  if opt['--copyright']
    puts "#{$cmd} version #{Rex::VERSION}"
    puts "#{Rex::Copyright} <#{Rex::Mailto}>"
    exit 0
  end

  usage(1, 'no grammar file given')    if ARGV.empty?
  usage(1, 'too many grammar files given')    if ARGV.size > 1

  opt
end

## ---------------------------------------------------------------------

def usage(status=0, msg=nil )
  f  =  (status == 0 ? $stdout : $stderr)
  f.puts "#{$cmd}: #{msg}"  if msg
  f.print <<-EOT
Usage: #{$cmd} [options] <grammar file>
Options:
  EOT

  REX_OPTIONS.each do |line|
    next if line.strip.empty?
    if /\A\s*\z/ === line
      f.puts
      next
    end

    disp, sopt, lopt, takearg, doc  =  line.strip.split(/\s+/, 5)
    if disp == 'o'
      sopt  =  nil if sopt == '-'
      lopt  =  nil if lopt == '-'
      opt  =  [sopt, lopt].compact.join(',')

      takearg  =  nil if takearg == '-'
      opt  =  [opt, takearg].compact.join(' ')

      f.printf "%-27s %s\n", opt, doc
    end
  end

  exit status
end

## ---------------------------------------------------------------------

main
