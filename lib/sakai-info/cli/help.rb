# sakai-info/cli/help.rb
#  - sakai-info command line help
#
# Created 2012-02-19 daveadams@gmail.com
# Last updated 2012-02-26 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

module SakaiInfo
  class CLI
    class Help
      STRINGS = {
        :default => <<EOF,
sakai-info #{VERSION}

  Usage: sakai-info <command> [<id>] [<options>]

  Object commands:
    user           User information
    site           Site information
    quiz           Quiz aka Assessment information, pending or published
    quiz-section   Quiz section information, pending or published
    quiz-item      Quiz item information, pending or published
    question-pool  Question Pool information

  Misc commands:
    test         Tests configured database connections
    help         Prints general help
    version      Prints version

  Options that apply globally:
    --database=<name>
        Connect to database instance <name> as defined in ~/.sakai-info instead
        of the default (which is typically the first entry)

    --log=<logfile>
        Log actual SQL statements to <logfile> as they are executed. Use "-"
        to log to STDOUT.

    --trace
        For development troubleshooting work, this outputs an extremely verbose
        trace log to STDOUT.

  Options that work on most object types:
    --dbrow-only
        Print only the raw database fields for the object requested.

    --mod
        Print creation and modification users and timestamps.

    --all
        Print all possible information (other than dbrow)

  Type 'sakai-info help <command>' for help on a specific command.
EOF

        "help" => <<EOF,
sakai-info help

  Usage: sakai-info help [<command>]

  Prints usage information for other sakai-info commands, or without an
  argument it prints a list of possible commands.
EOF

        "version" => <<EOF,
sakai-info version

  Usage: sakai-info version

  Prints the current version of sakai-info.
EOF

        "test" => <<EOF,
sakai-info test

  Usage: sakai-info test [<options>]

  Reads configuration and tests connecting to each database specified, or if
  a specific database is specified it will test only that connection.
EOF

        "user" => <<EOF,
sakai-info user

  Usage: sakai-info user <id> [<options>]

  Prints information about the user ID or EID specified. Additional options
  may be passed to include additional information:

    --sites    Print site membership information
    --pools    Print list of owned question pools
    --all      Print all possible details
EOF

        "site" => <<EOF,
sakai-info site

  Usage: sakai-info site <id> [<options>]

  Prints information about the site ID specified. Additional options may be
  passed to include additional information:

    --users        Print membership information
    --pages        Print page list with tools
    --groups       Print group information
    --quizzes      Print information about quizzes
    --disk         Print disk usage
    --assignments  Print assignment info
    --gradebook    Print gradebook item info
    --realm        Print site realm details
    --forums       Print forum details
    --all          Print all possible details
EOF

        "quiz" => <<EOF,
sakai-info quiz

  Usage: sakai-info quiz <id> [<options>]

  Prints information about the quiz ID specified. The quiz ID may represent
  a pending quiz or a published quiz. Additional options may be passed to
  include additional information:

    --sections   Print section summary list
    --mod        Print creation/modification info
    --all        Print all possible details
    --dbrow      Print the raw database fields

  Not yet implemented:
    --items      Print summary of items on the quiz
    --attempts   Print summary of user quiz attempts (for published quizzes)
EOF

        "quiz-section" => <<EOF,
sakai-info quiz-section

  Usage: sakai-info quiz-section <id> [<options>]

  Prints information about the quiz section ID specified. The ID may represent
  a pending quiz section or a published quiz section. Additional options may be
  passed to include additional information:

    --items      Print summary of items in the section
    --mod        Print creation/modification info
    --all        Print all possible details
    --dbrow      Print the raw database fields
EOF

        "quiz-item" => <<EOF,
sakai-info quiz-item

  Usage: sakai-info quiz-item <id> [<options>]

  Prints information about the quiz item ID specified. The ID may represent
  a pending quiz item or a published quiz item. Additional options may be
  passed to include additional information:

    --mod        Print creation/modification info
    --all        Print all possible details
    --dbrow      Print the raw database fields
EOF

        "question-pool" => <<EOF,
sakai-info question-pool

  Usage: sakai-info qpool <id> [<options>]
         sakai-info question-pool <id> [<options>]

  Prints information about the question pool ID specified. Additional options
  may be passed to include additional information:

    --mod      Print creation/modification info
    --dbrow    Print the raw database fields

  Not yet implemented:
    --items    Print summary of items in the pool
    --quizzes  Print summary of quizzes that link to this pool
    --all      Print all possible details
EOF

      }

      def self.help(topic = :default, io = STDOUT)
        topic ||= :default
        if STRINGS.has_key? topic
          io.puts STRINGS[topic]
        else
          STDERR.puts "ERROR: help topic '#{topic}' was unrecognized"
          STDERR.puts
          CLI::Help.help(:default, STDERR)
          exit 1
        end
      end
    end
  end
end

