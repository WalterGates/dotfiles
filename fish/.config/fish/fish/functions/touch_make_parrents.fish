function touch_make_parrents --wraps=touch --description 'touch with -p flag'
  # echo $argv[(count $argv)]
  command mkdir -p $(dirname $argv[(count $argv)])
  command touch $argv
end
