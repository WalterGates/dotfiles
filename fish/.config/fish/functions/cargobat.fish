function cargobat
    cargo --color=always $argv[1..-1] 2>&1 | bat --paging=always --plain
end
