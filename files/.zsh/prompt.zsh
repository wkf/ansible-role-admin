_vim_prompt_cmd='%F{blue}> %f%k'
_vim_prompt_ins='%F{green}> %f%k'
_vim_prompt=$_vim_prompt_ins

function zle-keymap-select {
  _vim_prompt="${${KEYMAP/vicmd/${_vim_prompt_cmd}}/(main|viins)/${_vim_prompt_ins}}";
  zle reset-prompt
}
zle -N zle-keymap-select

function zle-line-finish { _vim_prompt=$_vim_prompt_ins }
zle -N zle-line-finish

function _short_pwd {
  echo $PWD | sed                     \
    -e "s|${HOME}|~|"                 \
    -e "s|/\(.\)[^/]*|/\1|g"          \
    -e "s|/[^/]*$|/$(basename $PWD)|" \
    -e "s|//|/|g"
}

function _left_prompt { echo $_vim_prompt }
function _right_prompt { echo "%F{238}$(_short_pwd) %F{magenta}$(hostname)%f%k" }

PROMPT='$(_left_prompt)'
RPROMPT='$(_right_prompt)'
