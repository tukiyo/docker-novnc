# privileged を付けないと、google-chromeが一般ユーザーで起動ができない。 /dev/fd/4 への書き込みが失敗などとでた。

docker stop novnc
docker rm novnc

docker run -d \
 --privileged -it \
 --name=novnc \
 --hostname=novnc \
 --restart=always \
 -w /home/docker \
 -p 80:80 \
 -v $(pwd)/files/supervisord.conf:/etc/supervisor/conf.d/supervisord.conf \
 --name=novnc tukiyo3/novnc:latest
 
