function _git_prompt {
  local RED="\[\033[01;31m\]"
  local GREEN="\[\033[01;32m\]"
  local YELLOW="\[\033[01;33m\]"
  local BLUE="\[\033[01;34m\]"
  local WHITE="\[\033[00m\]"

  local PROMPT=""

  # hostname
  PROMPT=$PROMPT"$white\h@"

  # Working directory
  PROMPT=$PROMPT"$GREEN\w"


  # Git-specific
  local GIT_STATUS=$(git status 2> /dev/null)
  if [ -n "$GIT_STATUS" ] # Are we in a git directory?
  then
    # Open paren
    PROMPT=$PROMPT" $RED("

    # Branch
    PROMPT=$PROMPT$(git branch --no-color 2> /dev/null | sed -e "/^[^*]/d" -e "s/* \(.*\)/\1/")

    # Warnings
    PROMPT=$PROMPT$YELLOW

    # Merging
    echo $GIT_STATUS | grep "Unmerged paths" > /dev/null 2>&1
    if [ "$?" -eq "0" ]
    then
      PROMPT=$PROMPT"|MERGING"
    fi

    # Dirty flag
    echo $GIT_STATUS | grep "nothing to commit" > /dev/null 2>&1
    if [ "$?" -eq 0 ]
    then
      PROMPT=$PROMPT
    else
      PROMPT=$PROMPT"*"
    fi

    # Warning for no email setting
    git config user.email | grep @ > /dev/null 2>&1
    if [ "$?" -ne 0 ]
    then
      PROMPT=$PROMPT" !!! NO EMAIL SET !!!"
    fi

    # Closing paren
    PROMPT=$PROMPT"$RED)"
  fi

  # Final $ symbol
  PROMPT=$PROMPT"$BLUE\$$WHITE "

  # export and add timestamp abow the prompt
  export PS1="\t\n$PROMPT"
}

export PROMPT_COMMAND="_git_prompt"
