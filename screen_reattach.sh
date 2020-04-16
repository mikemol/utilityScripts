# Attaches to a running screen session, if we're not already in a screen session.
if [[ -z ${STY+x} ]] && ! [[ ${TERM} =~ ^screen ]] ; then
  screen -xURR
fi

