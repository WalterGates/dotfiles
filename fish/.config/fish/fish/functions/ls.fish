function ls --wraps='exa --icons -a -group-directories-first --color=auto' --wraps='exa --icons -a -group-directories-first --color' --wraps='exa --icons -a --group-directories-first --color' --wraps='exa --icons -a --group-directories-first --color=auto' --description 'alias ls exa --icons -a --group-directories-first --color=auto'
  exa --icons -a --group-directories-first --color=always $argv
        
end
