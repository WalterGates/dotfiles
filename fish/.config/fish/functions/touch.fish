function touch
    command mkdir -p $(dirname $argv[(count $argv)])
    command touch $argv
end
