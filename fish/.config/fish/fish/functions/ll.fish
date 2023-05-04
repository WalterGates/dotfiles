function ll --wraps='ls -lah --color=auto' --wraps='ls -lh' --wraps='ls -lh --git' --description 'alias ll ls -lh --git'
  ls -lh --git $argv
        
end
