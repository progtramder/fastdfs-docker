# FastDFS Dockerfile

## 声明
本教程是基于[fastdfs中的docker](https://github.com/happyfish100/fastdfs/tree/master/docker) 做了一些修改以便适合本人的一些习惯，另外修正了几处部署过程中出现错误的地方，主要是编译fastdfs_niginx_module时出现的错误。


## 目录介绍
### conf 
Dockerfile 所需要的一些配置文件
当然你也可以对这些文件进行一些修改  比如 storage.conf 里面的 bast_path 等相关

## 使用方法
创建映像:
```
docker build -t fdfs .
```

启动tracker:
```
docker run -it --name tracker fdfs /bin/bash
```

在tracker容器中启动trakcer进程:
```
/home/tracker.sh
```

用ifconfig查看tracker容器的ip地址，例如: 172.17.0.2，然后启动storage容器，在容器入口处会启动storage和nginx进程
```
docker run -d -e FASTDFS_TRACKER=172.17.0.2 -e FASTDFS_GROUP=group1 -p 8888:8888 -p 8080:80  fdfs  /home/storage.sh
```
