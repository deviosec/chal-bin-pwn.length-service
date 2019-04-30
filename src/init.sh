#!/bin/sh
# write correct settings to our f iles
sed -i "s/{{CHALTITLE}}/${CHALTITLE}/g" /var/www/html/index.html
sed -i "s/{{BINNAME}}/${BINNAME}/g" /var/www/html/index.html
sed -i "s/{{CHALPORT}}/${CHALPORT}/g" /var/www/html/index.html

sed -i "s/{{CHALPORT}}/${CHALPORT}/g" /etc/services
sed -i "s/{{BINNAME}}/${BINNAME}/g" /etc/inetd.conf

# plant our flag
printf "${FLAG}" >> /flag.txt

#start nginx
/usr/sbin/nginx
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start nginx: $status"
  exit $status
fi

# start inetd
/usr/sbin/inetd
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start inetd: $status"
  exit $status
fi

while sleep 60; do
  ps aux |grep nginx |grep -q -v grep
  NGINX_STATUS=$?
  ps aux |grep inetd |grep -q -v grep
  INETD_STATUS=$?

  # If the greps above find anything, they exit with 0 status
  # If they are not both 0, then something is wrong
  if [ $NGINX_STATUS -ne 0 -o $INETD_STATUS -ne 0 ]; then
    echo "Nginx or inetd has already exited."
    exit 1
  fi
done
