## icewm, brave

https://i3wm.org/docs/userguide.html

 
## 起動

```sh
docker run -p 6080:6080 -it tukiyo3/novnc
```

* http://localhost:6080/
    * user1 : password1
    * => nginx/htpasswd にて指定
* url
    * https://github.com/tukiyo/docker-novnc
    * https://hub.docker.com/repository/docker/tukiyo3/novnc


もしくは　VNCサーバーに直接接続

```sh
docker run -p 127.0.0.1:5900:5900 -it tukiyo3/novnc
```


## ローカルのファイルを起動時に表示する方法

```sh
docker run -it -d \
 --restart=always \
 -p 127.0.0.1:80:80 \
 -p 127.0.0.1:5900:5900 \
 -e URL=file:///home/docker/index.html \
 -v $(pwd)/index.html:/home/docker/index.html \
 tukiyo3/novnc
```

```
vncviewer localhost
```
