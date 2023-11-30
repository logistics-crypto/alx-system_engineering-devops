# Puppet manifest to kill a process named "killmenow"

# Define the exec resource to kill the process
exec { 'killmenow':
  command     => '/usr/bin/pkill killmenow',
  path        => '/usr/bin',
  logoutput   => true,
  refreshonly => true,
}

# Notify the user when the process is killed
notify { 'Process killed':
  subscribe => Exec['killmenow'],
}