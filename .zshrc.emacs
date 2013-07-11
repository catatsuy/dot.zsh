if [ -d ${HOME}/.emacs.d/inits ] ; then
  perl -wle \
    'do { print qq/(setenv "$_" "$ENV{$_}")/ if exists $ENV{$_} } for @ARGV' \
    PATH > ~/.emacs.d/inits/40-shellenv.el

  echo "\n(dolist (path (reverse (split-string (getenv \"PATH\") \":\")))\n (add-to-list 'exec-path path))" >> ~/.emacs.d/inits/40-shellenv.el
fi
