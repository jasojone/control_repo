class minecraft (
  $url = 'https://s3.amazonaws.com/Minecraft.Download/versions/1.12.2/minecraft_server.1.12.2.jar', #url to download minecraft server,  default is 1.12.2
  $install_dir = '/opt/minecraft' # directory to install minecraft server 
) {
  file { $install_dir:
    ensure => directory,
  }
  file { "${ install_dir}/minecraft_server.jar":
    ensure => file,
    source => $url,
    before => Service['minecraft'], # minecraft_server.jar must be downloaded before minecraft service is started
  }
  package { 'java':
    ensure => present, # java is required to run minecraft
  }
  file { "${install_dir}/eula.txt":
    ensure  => file, # eula.txt must be created before minecraft service is started
    content => 'eula=true', # minecraft EULA must be accepted before minecraft service is started
  }
  file { '/etc/systemd/system/minecraft.service':
    ensure  => file, # minecraft service must be created before minecraft service is started
    content => epp('minecraft/minecraft.service', {
        install_dir => $install_dir,
    })
  }
  service { 'minecraft':
    ensure => running, # minecraft service must be started before minecraft service is started
    enable => true, # minecraft service must be enabled before minecraft service is started
    reqire => [package['java'], File["${install_dir}/eula.txt"], file['/etc/systemd/system/minecraft.service']], # minecraft service must be started before minecraft service is started
  }
}
