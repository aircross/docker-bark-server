# Bark Server Docker 运行环境
## 项目简介
 Bark server docker
本项目当前仅适配了amd64的运行环境

使用 Docker 部署
   4.1. 安装docker

```shell
curl -fsSL https://get.docker.com | sh
# 设置开机自启
sudo systemctl enable docker.service
# 根据实际需要保留参数start|restart|stop
sudo service docker start|restart|stop
```


Docker执行命令

docker run -dt --name bark -p 8080:8080  aircross/docker-bark-server
