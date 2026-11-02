#
# ~/.zshrc - BerzeliusOS Zsh Configuration
#

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ll='ls -la'
alias beaker='berzelius-welcome'
alias calc='berzelius-calc'
alias titrate='berzelius-calc --titrate'
alias prep='berzelius-calc --prep'
alias install-os='sudo archinstall'
alias fetch='fastfetch -c /etc/fastfetch/config.jsonc'

PROMPT='%F{cyan}🧪 [Bz] %F{green}%n@berzelius %F{blue}%~ %F{cyan}$ %f'

if [ -f /etc/fastfetch/config.jsonc ] && [ -z "$FASTFETCH_RAN" ]; then
    export FASTFETCH_RAN=1
    fastfetch -c /etc/fastfetch/config.jsonc
fi
