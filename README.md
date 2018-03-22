# Live
a live program


16年底, 跟着学习小码哥的直播, 实操一遍

* 自己搭建 Nginx 服务器推流本地桌面
* Nginx 安装
```
$ brew install nginx
```

* 启动即可:
*  $ nginx
*  在浏览器输入地址验证: http://localhost:8080

* 安装配置文件的路径(/usr/local/etc/nginx/nginx.conf)
* 配置Nginx，支持http协议拉流
```
location /hls {
    #Serve HLS config
    types {
        application/vnd.apple.mpegurl    m3u8;
        video/mp2t ts;
    }
    root /usr/local/var/www;
    add_header Cache-Control    no-cache;
}
```
* 配置Nginx，支持rtmp协议推流
```
rtmp {
    server {
        listen 1935;
            application rtmplive {
            live on;
            max_connections 1024;
        }
        application hls{
            live on;
            hls on;
            hls_path /usr/local/var/www/hls;
            hls_fragment 1s;
        }
    }
}
```
* 重启Nginx: nginx -s reload
