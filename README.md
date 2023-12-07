# nagios_check_northernlights
NRPE Plugin for monitoring aurora / northern lights activity

```bash
# mv check_northern_lights /usr/lib/nagios/plugins/
# chmod +x /usr/lib/nagios/plugins/check_northern_lights

# cd /etc/nagios4/conf.d/
```

to commands file, add: 

```
define command {
        command_name check_northern_lights
        command_line $USER1$/check_northern_lights -c 6 -w 4
}
```

to Services file, add: 
```
define service {
        use generic-service
        name                    Northern Lights
        host                    localhost
        notification_options    w,c,r
        service_description     Aurora Status
        check_command           check_northern_lights
}

```

```bash
# service nagios4 reload
```
wait - and see 
![image](https://github.com/edguy3/nagios_check_northernlights/assets/4311096/8862c6ae-45b1-47d4-b4ac-63178949e422)
