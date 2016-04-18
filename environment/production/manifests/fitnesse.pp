# Install FitNesse

class fitnesse {

  exec {"getfitnesse" :
    command => "wget -O /tmp/fitnesse-standalone.jar https://dl.dropboxusercontent.com/u/48553986/fitnesse-standalone.jar",
    timeout => 0,
    user => "fitnesse",
    creates => "/var/lib/fitnesse/fitnesse-standalone.jar",
	  require => [User["fitnesse"]]
  }

  user { "fitnesse" :
	  ensure => "present"
  }

  # create a directory  
  file { "/var/lib/fitnesse/FitNesseRoot":
	  ensure => "directory",
	  owner   => "fitnesse",
    group   => "fitnesse",
	  require => [File["/var/lib/fitnesse"]]
  }
    
  file { "/var/lib/fitnesse":
	  ensure => "directory",
	  owner   => "fitnesse",
    group   => "fitnesse",
	  require => [User["fitnesse"]]
  }

  exec { "fitnesse_install":
    command => "mv /tmp/fitnesse-standalone.jar /var/lib/fitnesse",
    user => "fitnesse",
    creates => "/var/lib/fitnesse/fitnesse-standalone.jar",
    require => [Exec["getfitnesse"], File["/var/lib/fitnesse"]]
  }

  exec { "fitnesse_start":
    command => "java -jar fitnesse-standalone.jar -p 1234 &",
    cwd => "/var/lib/fitnesse",
    user => "fitnesse",
    unless =>  "pgrep -f 'java'",
    require => [Exec["fitnesse_install"], Package['openjdk-7-jdk']]
  }	

  exec { "clear_firewall":
    command => "iptables -F",
    user => "root",
    require => [Exec["fitnesse_start"]]
  }


}
