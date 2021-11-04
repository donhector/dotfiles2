# Windows Subsystem for Linux specific stuff
if [ -n "${WSL_DISTRO_NAME}" ]; then

  # Function to resolve Windows variables. Removes the CR windows binaries spit out
  get_win_var () { cmd.exe /c "echo ${1}" 2> /dev/null | sed -e 's/\r//g'; }

  # Since systemd is not enabled in WSL2, we need to start any services manually
  services=( docker cron )
  for service in "${services[@]}"; do
    sudo service ${service} status 2>&1 >/dev/null || sudo service ${service} start
  done

fi
