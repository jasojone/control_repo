class profile::ssh_server {
  package {'openssh-server':
    ensure => present,
  }
  service { 'sshd':
    ensure => 'running',
    enable => 'true',
  }
  ssh_authorized_key { 'root@master.puppet.vm':
    ensure => present,
    user   => 'root',
    type   => 'ssh-rsa',
    key    => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDb60X067cH8NyxYRppb8Lp3c940/1AS1N09JwXJpLhqlyS6JSYdWPq7J6RYY9g6De1yiedEJqBYBjvU807gNMU0fiQ0UdQaR1Hbc8Dzco2l7uPRUXLFA5SxzMXMW5ipqiz/ygAN1DCAhE8EBZQYsD/gP5B/S1uMIliFW/dZojb61InCTe22NTjD+x+apVzlYX0TkQspu+0PazYocbIXKXDjzoX+Yx0tE79Xynf8gywDfb6PrJVWBcZvgCIouk4xjEb+oSvWF6Z1BfvfY1Lc4tagxBSQxUY2PK7NSdIOipN+gAwnbJCuaEZj6qrvfD1erfCmPh4jYL7MyJaOYKihS9x',
  }  
}
