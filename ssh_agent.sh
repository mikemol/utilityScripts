#  vim: set ai ts=8 sw=2 st=2 bg=dark softtabstop=2

# This scriptlet has a simple purpose: Use an SSH agent if one is available, start one otherwise.
#
# It can be configured by pre-defining variables to control certain behaviors.

# Limitations: It does not (currently) support forwarded SSH agents. This is trivial to add, however; simply run check_ssh_agent, and don't bother looking for an agent file if there's already a working agent.

# Configuration items:
#
# SSH_AGENT_FILE:
# 
#   Where to store the current spawned SSH agent configuration.
#
#   Default: ~/.ssh_agent.sh


SSH_AGENT_FILE=${SSH_AGENT_FILE:-~/.ssh_agent.sh}

function spawn_ssh_agent () {
  ssh-agent -s > "${SSH_AGENT_FILE}"
  . "${SSH_AGENT_FILE}"
}

function check_ssh_agent () {
  ssh_add_res=0
  key_list=$(ssh-add -L 2>/dev/null) || ssh_add_res=$?

  # Comment out if you don't want to be presented with the key list.
  printf '%s\n' "${key_list}"

  if [[ $ssh_add_res -ne 0 && $ssh_add_res -ne 1 ]] ; then 
    return 1
  else
    return 0
  fi
}

if [[ ! -f ${SSH_AGENT_FILE} ]] ; then
  spawn_ssh_agent
else
  . "${SSH_AGENT_FILE}"

  if ! check_ssh_agent ; then
    spawn_ssh_agent
  fi
 
fi

