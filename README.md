# school-kotelnaya-monitor
Bash monitor



/etc/temploggerd.conf  ----- добавление и редактирование датчиков

rrdtool dump /var/www/html/temploggerd/rrd/temperature.rrd > /tmp/temperature.xml

vi /tmp/temperature.xml

28.2C7477910702    меняем на это  :%s/28.FF21B3941605/28.2C7477910702/
28.EE5318301601
28.FF6ABF361604
29.AFB504000000
28.E49277910802  --- новый меняем :%s/28.FF21B3941605/28.E49277910802/

rrdtool restore /tmp/temperature.xml /var/www/html/temploggerd/rrd/temperature.rrd.2022

mv /var/www/html/temploggerd/rrd/temperature.rrd.2022 /var/www/html/temploggerd/rrd/temperature.rrd

vi /var/www/html/cgi-bin/28.FF21B3941605.temperature.cgi  -- редактируем под наш датчик 

mv /var/www/html/cgi-bin/28.FF21B3941605.temperature.cgi  /var/www/html/cgi-bin/28.E49277910802.temperature.cgi  --- меняем
