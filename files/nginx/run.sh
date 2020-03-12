docker run -it \
 --restart=always \
 -p 80:80 \
 -v $(pwd)/htpasswd:/etc/nginx/htpasswd \
 -v $(pwd)/proxy:/etc/nginx/conf.d/default.conf \
 nginx
