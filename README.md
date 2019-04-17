# Fastdfs-Docker

## 声明
本教程是基于[原作者fastdfs中的docker](https://github.com/happyfish100/fastdfs/tree/master/docker) 做了一些修改以便适合本人的一些习惯，另外修正了几处部署过程中出现错误的地方，主要是编译fastdfs_niginx_module时出现的错误。本教程假设你已经对fastdfs有所了解。


## 目录介绍
### conf 
所有需要的配置文件

### Dockerfile 
制作docker映像的文件

当然你也可以对这些文件进行一些修改  比如 storage.conf 里面的 bast_path 等相关。

## 使用方法
创建映像:
```
docker build -t fdfs .
```

启动tracker:
```
docker run -d --name tracker fdfs /home/tracker.sh
```

执行:
```
docker exec -it tracker /bin/bash
```

在tracker容器中使用ifconfig查看tracker容器的ip地址，例如: 172.17.0.2，然后启动storage容器，在容器入口处会启动storage和nginx进程
```
docker run -d -e FASTDFS_TRACKER=172.17.0.2 -e FASTDFS_GROUP=group1 -p 8000:8888 --name group1 fdfs /home/storage.sh
```
此时在宿主机上的浏览器里面输入localhost:8000应该能看到nginx的欢迎页面。

执行:
```
docker exec -it group1 /bin/bash
```
进入storage容器
```
echo 'Hello FastDFS!' > test.txt
/usr/bin/fdfs_test /etc/fdfs/client.conf upload ./test.txt
```

上传成功后终端会提示保存的文件id，例如:http://172.17.0.4/group1/M00/00/00/rBEABFy2q3iAJzVbAAAADwtTC5E026_big.txt

然后在宿主机的浏览器中把group1开始的路径拼接在localhost:8000后面，就可以看到刚才上传的文件内容: 'Hello FastDFS!'
```
http://localhost:8000/group1/M00/00/00/rBEAA1y2oTCAA5PtAAAADPb1YLU499_big.txt
```