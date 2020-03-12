# privileged を付けないと、google-chromeが一般ユーザーで起動ができない。 /dev/fd/4 への書き込みが失敗などとでた。

docker run --privileged -it --rm -p 80:80 --name=novnc tukiyo3/novnc:latest
# docker run --privileged -it --rm -p 80:80 --name=novnc tukiyo3/novnc:latest
# docker run -it --rm -p 5900:5900 --name=novnc tukiyo3/novnc
