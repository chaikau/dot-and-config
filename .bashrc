#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [ ${TERM} == "linux" ]; then
	echo -en "\e]P7ffffff"
	alias zhterm='fcitx-fbterm-helper -l'
	alias mfullplay='mplayer -vo fbdev2 -zoom -x 1366 -y 768 1> /dev/null'
	alias mtopplay='mplayer -vo fbdev2 -geometry 1366:1'
#	if test $( pgrep -f X | wc -l ) -eq 0; then
#		startx
#	fi

# Android SDK env
	export ANDROID_HOME=$HOME/.local/opt/android-sdk
	export ANDROID_SDK_ROOT=$HOME/.local/opt/android-sdk
	export ANDROID_SWT=$HOME/.local/opt/android-sdk/tools/lib/x86_64/
	export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/build-tools/android-M/:$ANDROID_HOME/platform-tools/
fi

export EDITOR="vim"
#export VDPAU_DRIVER="va_gl"
export HISTSIZE=2000
export PATH=$PATH:$HOME/.local/bin
export QT_SELECT=4

PS1='[\u@\h \A \W]\$ '
alias ls='ls --color=auto'
alias ll='ls -l'
alias lh='ll -h'
alias la='ls -a'
alias l='ls -F'
alias ucd='cd ..'
alias bcd='cd -'
alias grep='grep --color=auto'
alias mocp='mocp 2> /dev/null'
alias chromium='chromium --start-maximized'
alias mread16='avrdude -P usb -p m16 -c usbasp -t'
alias mburn16='avrdude -p m16 -c usbasp -e -U'
alias acm='gcc -static -w -O2 -DONLINE_JUDGE'
alias google-earth='env LANG=en_US.UTF-8 google-earth'
#alias wine='env LANG=zh_CN.utf8 wine'

