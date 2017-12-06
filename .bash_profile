export PATH="/usr/local/bin:$PATH"
export PATH="$PATH: `yarn global bin`"
eval "$(rbenv init -)";
export NVM_DIR="/Users/joshrosen/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
# Aliases
alias resque='TERM_CHILD=1 QUEUE=* COUNT=2 bundle exec rake resque:workers —trace'
alias emailresque='TERM_CHILD=1 QUEUE=procore_email_queue COUNT=1 bundle exec rake resque:workers -trace'
alias vim='/usr/local/bin/vim'
alias reload="source ~/.bashrc"
alias bullet="tail -f log/bullet.log"
alias puma="bin/rails s puma"
alias wrench="HOST=localhost PORT=8080 yarn run dev"
alias spec="bundle exec rspec"
alias remigrate="bundle exec rake db:make_clean_structure"
# mailcatcher will start mailcatcher server and user in directory needs to be set to recieve email

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Append to the Bash history file, rather than overwriting it
shopt -s histappend;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
    shopt -s "$option" 2> /dev/null;
done;

# Add tab completion for many Bash commands
if which brew > /dev/null && [ -f "$(brew --prefix)/share/bash-completion/bash_completion" ]; then
    source "$(brew --prefix)/share/bash-completion/bash_completion";
elif [ -f /etc/bash_completion ]; then
    source /etc/bash_completion;
fi;

if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi;

# Enable tab completion for `g` by marking it as an alias for `git`
if type _git &> /dev/null && [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
    complete -o default -o nospace -F _git g;
fi;

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;
