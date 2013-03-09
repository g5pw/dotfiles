## set options (setopt) ####
############################
# In the following list, options set by default in all emulations are marked
# <D>; those set by default only in csh, ksh, sh, or zsh emulations are marked
# <C>, <K>, <S>, <Z> as appropriate.  When listing options 
# (by `setopt', `unsetopt', `set -o' or `set +o'), those turned on by default
# appear in the list prefixed with `no'. Hence (unless KSH_OPTION_PRINT is set),
# `setopt' shows all options whose settings
# are changed from the default.
# Default options are commented, uncomment them if you want
# to be diferent from default

# Insert all filenames that match the glob pattern
setopt glob_complete

# Enable PCRE
setopt re_match_pcre

# ALWAYS_LAST_PROMPT <D>
# If unset, key functions that list completions try to return to the last
# prompt if given a numeric argument. If set these functions try to
# return to the last prompt if given no numeric argument.
# setopt NO_always_last_prompt

# ALWAYS_TO_END
# If a completion is performed with the cursor within a word, and a
# full completion is inserted, the cursor is moved to the end of the
# word.  That is, the cursor is moved to the end of the word if either
# a single match is inserted or menu completion is performed.
setopt always_to_end

# AUTO_CD (-J)
# If a command is issued that can't be executed as a normal command,
# and the command is the name of a directory, perform the cd
# command to that directory.
setopt auto_cd

# AUTO_NAME_DIRS
# Any parameter that is set to the absolute name of a directory
# immediately becomes a name for that directory, that will be used
# by the `%~'
# and related prompt sequences, and will be available when completion
# is performed on a word starting with `~'.
# (Otherwise, the parameter must be used in the form `~param' first.)
setopt auto_name_dirs

# AUTO_PARAM_SLASH <D>
# If a parameter is completed whose content is the name of a directory,
# then add a trailing slash instead of a space.
#setopt NO_auto_param_slash

# AUTO_PUSHD (-N)
# Make cd push the old directory onto the directory stack.
setopt	 auto_pushd

# AUTO_RESUME (-W)
# Treat single word simple commands without redirection
# as candidates for resumption of an existing job.
setopt auto_resume

# BARE_GLOB_QUAL <Z>
# In a glob pattern, treat a trailing set of parentheses as a qualifier
# list, if it contains no `|', `(' or (if special) `~'
# characters.  See section Filename Generation.
#setopt NO_bare_glob_qual

# BASH_AUTO_LIST
# On an ambiguous completion, automatically list choices when the
# completion function is called twice in succession.  This takes
# precedence over AUTO_LIST.  The setting of LIST_AMBIGUOUS is
# respected.  If AUTO_MENU is set, the menu behaviour will then start
# with the third press.  Note that this will not work with
# MENU_COMPLETE, since repeated completion calls immediately cycle
# through the list in that case.
#setopt bash_auto_list

# BEEP (+B) <D>
# Beep on error in ZLE.
# setopt NO_beep

# BG_NICE (-6) <C> <Z>
# Run all background jobs at a lower priority.  This option
# is set by default.
#setopt NO_bg_nice

# BSD_ECHO <S>
# Make the echo builtin compatible with the BSD man page echo(1) command.
# This disables backslashed escape sequences in echo strings unless the
# -e option is specified.
#setopt bsd_echo

# C_BASES
# Output hexadecimal numbers in the standard C format, for example `0xFF'
# instead of the usual `16#FF'.  If the option OCTAL_ZEROES is also
# set (it is not by default), octal numbers will be treated similarly and
# hence appear as `077' instead of `8#77'.  This option has no effect
# on the choice of the output base, nor on the output of bases other than
# hexadecimal and octal.  Note that these formats will be understood on input
# irrespective of the setting of C_BASES.
setopt NO_c_bases

# CHASE_DOTS
# When changing to a directory containing a path segment `..' which would
# otherwise be treated as canceling the previous segment in the path (in
# other words, `foo/..' would be removed from the path, or if `..' is
# the first part of the path, the last part of $PWD would be deleted),
# instead resolve the path to the physical directory.  This option is
# overridden by CHASE_LINKS.
# For example, suppose /foo/bar is a link to the directory /alt/rod.
# Without this option set, `cd /foo/bar/..' changes to /foo; with it
# set, it changes to /alt.  The same applies if the current directory
# is /foo/bar and `cd ..' is used.  Note that all other symbolic
# links in the path will also be resolved.
setopt NO_chase_dots

# CHECK_JOBS <Z>
# Report the status of background and suspended jobs before exiting a shell
# with job control; a second attempt to exit the shell will succeed.
# NO_CHECK_JOBS is best used only in combination with NO_HUP, else
# such jobs will be killed automatically.
#setopt NO_check_jobs

# CLOBBER (+C, ksh: +C) <D>
# Allows `>' redirection to truncate existing files,
# and `>>' to create files.
# Otherwise `>!' or `>|' must be used to truncate a file,
# and `>>!' or `>>|' to create a file.
setopt clobber

# COMPLETE_ALIASES
# Prevents aliases on the command line from being internally substituted
# before completion is attempted.  The effect is to make the alias a
# distinct command for completion purposes.
setopt complete_aliases

# CORRECT (-0)
# Try to correct the spelling of commands.
setopt correct

# CORRECT_ALL (-O)
# Try to correct the spelling of all arguments in a line.
setopt NO_correct_all

# ERR_EXIT (-e, ksh: -e)
# If a command has a non-zero exit status, execute the ZERR
# trap, if set, and exit.  This is disabled while running initialization
# scripts.
#setopt err_exit

# EXTENDED_HISTORY <C>
# Save each command's beginning timestamp (in seconds since the epoch)
# and the duration (in seconds) to the history file.  The format of
# this prefixed data is:
# `:<beginning time>:<elapsed seconds>:<command>'.
#setopt extended_history

# FLOW_CONTROL <D>
# If this option is unset,
# output flow control via start/stop characters (usually assigned to
# ^S/^Q) is disabled in the shell's editor.
#setopt NO_flow_control

# GLOBAL_EXPORT (<Z>)
# If this option is set, passing the -x flag to the builtins declare,
# float, integer, readonly and typeset (but not local)
# will also set the -g flag;  hence parameters exported to
# the environment will not be made local to the enclosing function, unless
# they were already or the flag +g is given explicitly.  If the option is
# unset, exported parameters will be made local in just the same way as any
# other parameter.
# This option is set by default for backward compatibility; it is not
# recommended that its behaviour be relied upon.  Note that the builtin
# export always sets both the -x and -g flags, and hence its
# effect extends beyond the scope of the enclosing function; this is the
# most portable way to achieve this behaviour.
#setopt NO_global_export


# GLOBAL_RCS (-d) <D>
# If this option is unset, the startup files /etc/zprofile,
# /etc/zshrc, /etc/zlogin and /etc/zlogout will not be run. It
# can be disabled and re-enabled at any time, including inside local startup
# files (.zshrc, etc.).
#setopt NO_global_rcs

# HIST_ALLOW_CLOBBER
# Add `|' to output redirections in the history.  This allows history
# references to clobber files even when CLOBBER is unset.
setopt NO_hist_allow_clobber

# HIST_EXPIRE_DUPS_FIRST
# If the internal history needs to be trimmed to add the current command line,
# setting this option will cause the oldest history event that has a duplicate
# to be lost before losing a unique event from the list.
# You should be sure to set the value of HISTSIZE to a larger number
# than SAVEHIST in order to give you some room for the duplicated
# events, otherwise this option will behave just like HIST_IGNORE_ALL_DUPS
# once the history fills up with unique events.
setopt hist_expire_dups_first

# HIST_FIND_NO_DUPS
# When searching for history entries in the line editor, do not display
# duplicates of a line previously found, even if the duplicates are not
# contiguous.
setopt hist_find_no_dups

# HIST_IGNORE_ALL_DUPS
# If a new command line being added to the history list duplicates an
# older one, the older command is removed from the list (even if it is
# not the previous event).
setopt hist_ignore_all_dups

# HIST_IGNORE_DUPS (-h)
# Do not enter command lines into the history list
# if they are duplicates of the previous event.
setopt hist_ignore_dups

# HIST_IGNORE_SPACE (-g)
# Remove command lines from the history list when the first character on
# the line is a space, or when one of the expanded aliases contains a
# leading space.
# Note that the command lingers in the internal history until the next
# command is entered before it vanishes, allowing you to briefly reuse
# or edit the line.  If you want to make it vanish right away without
# entering another command, type a space and press return.
setopt hist_ignore_space

# HIST_NO_FUNCTIONS
# Remove function definitions from the history list.
# Note that the function lingers in the internal history until the next
# command is entered before it vanishes, allowing you to briefly reuse
# or edit the definition.
setopt hist_no_functions

# HIST_NO_STORE
# Remove the history (fc -l) command from the history list
# when invoked.
# Note that the command lingers in the internal history until the next
# command is entered before it vanishes, allowing you to briefly reuse
# or edit the line.
setopt hist_no_store

# HIST_SAVE_NO_DUPS
# When writing out the history file, older commands that duplicate
# newer ones are omitted.
setopt hist_save_no_dups

# HIST_VERIFY
# Whenever the user enters a line with history expansion,
# don't execute the line directly; instead, perform
# history expansion and reload the line into the editing buffer.
# setopt hist_verify

# HUP <Z>
# Send the HUP signal to running jobs when the
# shell exits.
setopt hup

# INC_APPEND_HISTORY
# This options works like APPEND_HISTORY except that new history lines
# are added to the $HISTFILE incrementally (as soon as they are
# entered), rather than waiting until the shell is killed.
# The file is periodically trimmed to the number of lines specified by
# $SAVEHIST, but can exceed this value between trimmings.
setopt inc_append_history

# LIST_BEEP <D>
# Beep on an ambiguous completion.  More accurately, this forces the
# completion widgets to return status 1 on an ambiguous completion, which
# causes the shell to beep if the option BEEP is also set; this may
# be modified if completion is called from a user-defined widget.
setopt NO_list_beep

# LIST_PACKED
# Try to make the completion list smaller (occupying less lines) by
# printing the matches in columns with different widths.
setopt list_packed

# LIST_ROWS_FIRST
# Lay out the matches in completion lists sorted horizontally, that is,
# the second match is to the right of the first one, not under it as
# usual.
setopt NO_list_rows_first

# LOCAL_OPTIONS <K>
# If this option is set at the point of return from a shell function,
# all the options (including this one) which were in force upon entry to
# the function are restored.  Otherwise, only this option and the XTRACE
# and PRINT_EXIT_VALUE options are restored.  Hence
# if this is explicitly unset by a shell function the other options in
# force at the point of return will remain so.
# A shell function can also guarantee itself a known shell configuration
# with a formulation like `emulate -L zsh'; the -L activates LOCAL_OPTIONS.
#setopt local_options

# LOCAL_TRAPS <K>
# If this option is set when a signal trap is set inside a function, then the
# previous status of the trap for that signal will be restored when the
# function exits.  Note that this option must be set prior to altering the
# trap behaviour in a function; unlike LOCAL_OPTIONS, the value on exit
# from the function is irrelevant.  However, it does not need to be set
# before any global trap for that to be correctly restored by a function.
# For example,
# unsetopt localtraps
# trap - INT
# fn() { setopt localtraps; trap '{}' INT; sleep 3; }
# will restore normally handling of SIGINT after the function exits.
#setopt local_traps

# MARK_DIRS (-8, ksh: -X)
# Append a trailing `/' to all directory
# names resulting from filename generation (globbing).
setopt mark_dirs

# MENU_COMPLETE (-Y)
# On an ambiguous completion, instead of listing possibilities or beeping,
# insert the first match immediately.  Then when completion is requested
# again, remove the first match and insert the second match, etc.
# When there are no more matches, go back to the first one again.
# reverse-menu-complete may be used to loop through the list
# in the other direction. This option overrides AUTO_MENU.
#setopt menu_complete

# MONITOR (-m, ksh: -m)
# Allow job control.  Set by default in interactive shells.
#setopt NO_monitor

# NUMERIC_GLOB_SORT
# If numeric filenames are matched by a filename generation pattern,
# sort the filenames numerically rather than lexicographically.
setopt NO_numeric_glob_sort

# OCTAL_ZEROES <S>
# Interpret any integer constant beginning with a 0 as octal, per IEEE Std
# 1003.2-1992 (ISO 9945-2:1993).  This is not enabled by default as it
# causes problems with parsing of, for example, date and time strings with
# leading zeroes.
#setopt octal_zeroes

# OVERSTRIKE
# Start up the line editor in overstrike mode.
#setopt overstrike

# PRINT_EIGHT_BIT
# Print eight bit characters literally in completion lists, etc.
# This option is not necessary if your system correctly returns the
# printability of eight bit characters (see man page ctype(3)).
setopt print_eight_bit

# PRIVILEGED (-p, ksh: -p)
# Turn on privileged mode. This is enabled automatically on startup if the
# effective user (group) ID is not equal to the real user (group) ID.  Turning
# this option off causes the effective user and group IDs to be set to the
# real user and group IDs. This option disables sourcing user startup files.
# If zsh is invoked as `sh' or `ksh' with this option set,
# /etc/suid_profile is sourced (after /etc/profile on interactive
# shells). Sourcing ~/.profile is disabled and the contents of the
# ENV variable is ignored. This option cannot be changed using the
# -m option of setopt and unsetopt, and changing it inside a
#  function always changes it globally regardless of the LOCAL_OPTIONS
# option.
#setopt privileged

# PROMPT_BANG <K>
# If set, `!' is treated specially in prompt expansion.
# See section Prompt Expansion.
#setopt prompt_bang

# PROMPT_CR (+V) <D>
# Print a carriage return just before printing
# a prompt in the line editor.  This is on by default as multi-line editing
# is only possible if the editor knows where the start of the line appears.
#setopt NO_prompt_cr

# PROMPT_PERCENT <C> <Z>
# If set, `%' is treated specially in prompt expansion.
# See section Prompt Expansion.
#setopt NO_prompt_percent

# PROMPT_SUBST <K>
# If set, parameter expansion, command substitution and
# arithmetic expansion are performed in prompts.
setopt prompt_subst

# PUSHD_SILENT (-E)
# Do not print the directory stack after pushd or popd.
setopt pushd_silent

# REC_EXACT (-S)
# In completion, recognize exact matches even
# if they are ambiguous.
#setopt rec_exact

# RM_STAR_WAIT
# If querying the user before executing `rm *' or `rm path/*',
# first wait ten seconds and ignore anything typed in that time.
# This avoids the problem of reflexively answering `yes' to the query
# when one didn't really mean it.  The wait and query can always be
# avoided by expanding the `*' in ZLE (with tab).
setopt rm_star_wait

# SH_GLOB <K> <S>
# Disables the special meaning of `(', `|', `)'
# and '<' for globbing the result of parameter and command substitutions,
# and in some other places where
# the shell accepts patterns.  This option is set by default if zsh is
# invoked as sh or ksh.
#setopt sh_glob

# SHIN_STDIN (-s, ksh: -s)
# Commands are being read from the standard input.
# Commands are read from standard input if no command is specified with
# -c and no file of commands is specified.  If SHIN_STDIN
# is set explicitly on the command line,
# any argument that would otherwise have been
# taken as a file to run will instead be treated as a normal positional
# parameter.
# Note that setting or unsetting this option on the command line does not
# necessarily affect the state the option will have while the shell is
# running - that is purely an indicator of whether on not commands are
# actually being read from standard input. The value of this option
# cannot be changed anywhere other 
# than the command line.
#setopt shin_stdin

# SH_NULLCMD <K> <S>
# Do not use the values of NULLCMD and READNULLCMD
# when doing redirections, use `:' instead (see section Redirection).
#setopt sh_nullcmd

# SH_OPTION_LETTERS <K> <S>
# If this option is set the shell tries to interpret single letter options
# (which are used with set and setopt) like ksh does.
# This also affects the value of the - special parameter.
#setopt sh_option_letters

# SH_WORD_SPLIT (-y) <K> <S>
# Causes field splitting to be performed on unquoted parameter expansions.
# Note that this option has nothing to do with word splitting.
# XTRACE (-x, ksh: -x)
# Print commands and their arguments as they are executed.
#setopt xtrace

setopt hist_reduce_blanks
setopt complete_in_word
setopt ignoreeof
setopt long_list_jobs
setopt magic_equal_subst
setopt pushd_ignore_dups
setopt pushd_to_home
setopt share_history
setopt null_glob
