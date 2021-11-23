# Windows Subsystem for Linux specific stuff
if [ -n "${WSL_DISTRO_NAME}" ]; then

  # Function to resolve Windows variables. Removes the CR windows binaries spit out
  get_win_var () { cmd.exe /c "echo ${1}" 2> /dev/null | sed -e 's/\r//g'; }

  wslshutdown () { cmd.exe /C wsl --shutdown -d ${WSL_DISTRO_NAME}; }

  ### Workarounds for the lack of SYSTEMD support in Microsoft's WSL distros

  # Since systemd is not enabled in WSL2, we need to start any services manually
  services=( docker cron )
  for service in "${services[@]}"; do
    sudo service ${service} status 2>&1 >/dev/null || sudo service ${service} start
  done

  # This solves issues with docker containers that rely on systemd
  [ -d "/sys/fs/cgroup/systemd" ] || sudo mkdir "/sys/fs/cgroup/systemd"
  mount | grep 'name=systemd' || sudo mount -t cgroup -o none,name=systemd cgroup /sys/fs/cgroup/systemd

fi
