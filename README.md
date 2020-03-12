## i3, chrome

https://i3wm.org/docs/userguide.html

* Chrome
    * Control + Num
* Workspace
    * Alt + Num
* Fullscreen
    * Alt + F

## 起動

```sh
docker run -p 8080:8080 -it tukiyo3/novnc
```

* http://localhost:8080/
* パスワードなし
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
 -p 127.0.0.1:5900:5900 \
 -e URL=file:///home/docker/index.html \
 -v $(pwd)/index.html:/home/docker/index.html \
 tukiyo3/novnc
```

```
vncviewer localhost
```
