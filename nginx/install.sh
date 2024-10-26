rm -f /etc/nginx/sites-enabled/stats-blog
rm -f /etc/nginx/sites-available/stats-blog

cp sites/* /etc/nginx/sites-available

ln -s  /etc/nginx/sites-available/stats-blog /etc/nginx/sites-enabled

systemctl restart nginx
