# shortcuts
alias t='which'
alias m='less'
alias gi='grep -i'

alias l='ls -FG'
alias la='l -a'
alias lla='l -la'
alias ll='l -l'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

alias wwdjango='workon udemy-django;cd ~/udemy-django'

#alias rs='source ~/.bash_profile'
#alias ers='e ~/.bash_profile'
alias rs='~/.dotfiles/dotsync/bin/dotsync -L && source ~/.aliases.sh'
alias ers='e ~/.dotfiles/zsh/aliases.sh'

alias g='git'
alias st='git status'
alias bell='echo "\x07"'
function bell_status {(
    ret="$?"
    if [ $ret -eq 0 ]; then
        bell;sleep .2;bell
    else
        bell;sleep .2;bell;sleep .2;bell
        return $ret
    fi
)}
alias groot='echo $(git rev-parse --show-toplevel 2> /dev/null)'
#alias cdg='cd `groot`'
function cdg {
    if [ -n "$(groot)" ]; then
        cd "$(groot)"
    else
        cd ~/udemy-django/
    fi
}
alias gbranch='g branch|grep \*|awk "{print \$2}"'
function parentbranch {
    echo "origin/master"
}
alias gmerge='g merge `parentbranch` && udemy_req_dev'
alias pushcurr='g pull origin `gbranch` && g push origin `gbranch`;bell_status'

function udemy_push_fe {(
    commands='handlebars'
    if [ -n "$1" ]; then
        commands=$*
    fi
    (cd `groot`/static;`npm bin`/grunt $commands) && fab rsync
    bell_status
)}
function grunt {(
    cd `groot`/static
    `npm bin`/grunt $*
    bell_status
)}

function npm {(
    if [ -n "$(groot)" ]; then
        cd "$(groot)/static"
    fi
    `/usr/bin/which npm` $*
)}

function fab {(
    deactivate 2> /dev/null
    cdg
    echo "*not in virtual env*"
    `/usr/bin/which fab` $*
    bell_status
)}

# figure out automatic isort...
function isort {(
    wwdjango
    `/usr/bin/which isort` $*
)}

function psg {
    ps aux | grep $* | grep -v grep
}

function psk {
    psg $* | awk '{print $2}' | xargs kill -9
}

# alias e='open -a /Applications/IntelliJ\ IDEA\ 14.app'
unalias e
function e {(
    file="${@: -1}"
    touch $file
    open -a /Applications/IntelliJ\ IDEA\ 14.app $*
)}

#export WORKON_HOME=$HOME/.virtualenvs
#export PROJECT_HOME=$HOME/Devel
#source /usr/local/bin/virtualenvwrapper.sh

# udemy django setup
# export DJANGO_SETTINGS_MODULE=udemy.settings.local

# alias env_website_django='source ~/.virtualenvs/website_django_env/bin/activate'
#sshuser=murataydos

alias db_tunnel='ssh -fNg -p2022 -L 3333:vm1:3306 bahaddin@infra1.udemy.com'
alias db_tunnel_kill='kill $(sudo lsof -t -i:3333)'
alias db_tunnel4='ssh -fNg -p2022 -L 3334:localhost:3306 bahaddin@infra1.udemy.com'
alias db_tunnel4_kill='kill $(sudo lsof -t -i:3334)'
alias udemy_test_unit='./manage.py test --settings=udemy.settings.test_unit --processes=8'
alias udemy_test_integration='./manage.py test --settings=udemy.settings.test_integration --processes=8'
alias udemy_test_cover='./manage.py test --settings=udemy.settings.test_coverage'
alias udemy_shell_plus='./manage.py shell_plus --settings=udemy.settings.local'
alias udemy_runserver='./manage.py runserver 8000'
alias udemy_killserver='kill $(sudo lsof -t -i:8000)'
alias elastic_tunnel='ssh -fNg -p2022 -L 9200:10.1.0.104:9200 murataydos@infra1.udemy.com'
alias elastic_tunnel_kill='kill $(sudo lsof -t -i:9200)'

alias udemy_req_dev='(wwdjango;pip install -r requirements/dev.txt)'
alias flake='(wwdjango; flake8 --max-line-length=100 --max-complexity 14 --jobs=auto udemy)'

#source ~/bin/git-completion.bash
# get shell completion for all aliases
#complete -a t
#alias rsc='. ~/bin/alias_completion.sh'
