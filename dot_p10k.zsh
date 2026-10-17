# Powerlevel10k configuration — Tokyo Night theme
# Generated to match previous Starship config.

'builtin' 'local' '-a' 'p10k_config_opts'
[[ ! -o 'aliases'         ]] || p10k_config_opts+=('aliases')
[[ ! -o 'sh_glob'         ]] || p10k_config_opts+=('sh_glob')
[[ ! -o 'no_brace_expand' ]] || p10k_config_opts+=('no_brace_expand')
'builtin' 'setopt' 'no_aliases' 'no_sh_glob' 'brace_expand'

() {
  emulate -L zsh -o extended_glob

  # Unset all configuration options.
  unset -m '(POWERLEVEL9K_*|DEFAULT_USER)~POWERLEVEL9K_GITSTATUS_DIR'

  # Prompt stays put when terminal resizes, avoids cursor glitches.
  typeset -g POWERLEVEL9K_SHOW_RULER=false

  ##############################################################################
  # Left / right segment lists
  ##############################################################################

  # Line 1: dir + git (left), languages (right)
  # Line 2: prompt character (left), nothing (right)
  typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
    context
    dir
    vcs
    newline
    prompt_char
  )

  typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
    node_version
    pyenv
    anaconda
    rust_version
  )

  ##############################################################################
  # General
  ##############################################################################

  typeset -g POWERLEVEL9K_MODE='nerdfont-v3'
  typeset -g POWERLEVEL9K_ICON_PADDING=moderate
  typeset -g ZLE_RPROMPT_INDENT=0

  # No background on segments — transparent/clean look.
  typeset -g POWERLEVEL9K_BACKGROUND=
  typeset -g POWERLEVEL9K_{LEFT,RIGHT}_{LEFT,RIGHT}_WHITESPACE=
  typeset -g POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR=' '
  typeset -g POWERLEVEL9K_RIGHT_SUBSEGMENT_SEPARATOR=' '
  typeset -g POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR=''
  typeset -g POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR=''
  typeset -g POWERLEVEL9K_LEFT_PROMPT_LAST_SEGMENT_END_SYMBOL=''
  typeset -g POWERLEVEL9K_RIGHT_PROMPT_FIRST_SEGMENT_START_SYMBOL=''

  # Put right prompt on line 1 (not line 2).
  typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS_ON_FIRST_LINE=true

  # Dotted fill between left and right.
  typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_GAP_CHAR='·'
  typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_GAP_FOREGROUND='#3b4261'

  # No prefix/suffix decorators.
  typeset -g POWERLEVEL9K_LEFT_PROMPT_FIRST_SEGMENT_START_SYMBOL=''
  typeset -g POWERLEVEL9K_RIGHT_PROMPT_LAST_SEGMENT_END_SYMBOL=''
  typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=''
  typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_SUFFIX=''
  typeset -g POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX=''
  typeset -g POWERLEVEL9K_MULTILINE_LAST_PROMPT_SUFFIX=''

  # Add a blank line before each prompt.
  typeset -g POWERLEVEL9K_PROMPT_ADD_NEWLINE=true

  ##############################################################################
  # Hostname (context) — Tokyo Night cyan, hostname only
  ##############################################################################

  typeset -g POWERLEVEL9K_CONTEXT_FOREGROUND='#7dcfff'
  typeset -g POWERLEVEL9K_CONTEXT_{DEFAULT,SUDO}_CONTENT_EXPANSION='%m'
  typeset -g POWERLEVEL9K_ALWAYS_SHOW_CONTEXT=true

  ##############################################################################
  # Directory — bold Tokyo Night blue
  ##############################################################################

  typeset -g POWERLEVEL9K_DIR_FOREGROUND='#7aa2f7'
  typeset -g POWERLEVEL9K_DIR_ANCHOR_BOLD=true
  typeset -g POWERLEVEL9K_DIR_TRUNCATE_BEFORE_MARKER=false
  typeset -g POWERLEVEL9K_SHORTEN_STRATEGY=truncate_to_last
  typeset -g POWERLEVEL9K_SHORTEN_DIR_LENGTH=3
  typeset -g POWERLEVEL9K_DIR_SHOW_WRITABLE=v3

  ##############################################################################
  # Git (VCS) — Tokyo Night purple branch, yellow status
  ##############################################################################

  typeset -g POWERLEVEL9K_VCS_BRANCH_ICON=' '
  typeset -g POWERLEVEL9K_VCS_CLEAN_FOREGROUND='#bb9af7'
  typeset -g POWERLEVEL9K_VCS_MODIFIED_FOREGROUND='#e0af68'
  typeset -g POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND='#e0af68'
  typeset -g POWERLEVEL9K_VCS_CONFLICTED_FOREGROUND='#f7768e'
  typeset -g POWERLEVEL9K_VCS_LOADING_FOREGROUND='#3b4261'

  ##############################################################################
  # Prompt character — green >, red > on error
  ##############################################################################

  typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_{VIINS,VICMD,VIVIS,VIOWR}_FOREGROUND='#9ece6a'
  typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_{VIINS,VICMD,VIVIS,VIOWR}_FOREGROUND='#f7768e'
  typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIINS_CONTENT_EXPANSION='>'
  typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VICMD_CONTENT_EXPANSION='>'
  typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIVIS_CONTENT_EXPANSION='>'
  typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIOWR_CONTENT_EXPANSION='>'

  ##############################################################################
  # Language versions — only show when relevant files are present
  ##############################################################################

  # Node — Tokyo Night green, only in project dirs
  typeset -g POWERLEVEL9K_NODE_VERSION_FOREGROUND='#9ece6a'
  typeset -g POWERLEVEL9K_NODE_VERSION_PROJECT_ONLY=true

  # Python (pyenv) — Tokyo Night yellow, only show non-system versions
  typeset -g POWERLEVEL9K_PYENV_FOREGROUND='#e0af68'
  typeset -g POWERLEVEL9K_PYENV_PROMPT_ALWAYS_SHOW=false
  typeset -g POWERLEVEL9K_PYENV_SHOW_SYSTEM=false

  # Conda — Tokyo Night cyan
  typeset -g POWERLEVEL9K_ANACONDA_FOREGROUND='#7dcfff'
  typeset -g POWERLEVEL9K_ANACONDA_SHOW_BASE=true

  # Rust — Tokyo Night red, only in project dirs
  typeset -g POWERLEVEL9K_RUST_VERSION_FOREGROUND='#f7768e'
  typeset -g POWERLEVEL9K_RUST_VERSION_PROJECT_ONLY=true

  ##############################################################################
  # Transient prompt — collapse previous prompts to just >
  ##############################################################################

  typeset -g POWERLEVEL9K_TRANSIENT_PROMPT=same-dir

  ##############################################################################
  # Instant prompt — render prompt before plugins finish loading
  ##############################################################################

  typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

  # Reload
  (( ${#p10k_config_opts} )) && setopt ${p10k_config_opts[@]}
  'builtin' 'unset' 'p10k_config_opts'
}
