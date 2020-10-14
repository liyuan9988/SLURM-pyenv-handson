git clone https://github.com/yyuu/pyenv.git ~/.pyenv
git clone https://github.com/yyuu/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv
echo "export PYENV_ROOT=\"\$HOME/.pyenv\"" >> $HOME/.bash_profile
echo "export PATH=\"\$PYENV_ROOT/bin:\$PATH\"" >> $HOME/.bash_profile
echo "eval \"\$(pyenv init -)\"" >> $HOME/.bash_profile
echo "eval \"\$(pyenv virtualenv-init -)\"" >> $HOME/.bash_profile
source $HOME/.bash_profile