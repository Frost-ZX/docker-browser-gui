# docker-browser-gui

## 简介

在 Docker 中安装 Google Chrome 或 Microsoft Edge 浏览器，并支持通过网页或 VNC 访问。

使用的项目：[jlesage / docker-baseimage-gui](https://github.com/jlesage/docker-baseimage-gui)

基础镜像：`jlesage/baseimage-gui:ubuntu-22.04-v4`

## 文件说明

- `google-chrome/`：用于创建 Google Chrome 镜像。
- `microsoft-edge/`：用于创建 Microsoft Edge 镜像。
- `.env`：执行 `docker run` 时传递的环境变量，可参考 [Public Environment Variables](https://github.com/jlesage/docker-baseimage-gui#public-environment-variables) 根据实际需要进行修改。
- `main-window-selection.xml`：原用于指定自动最大化的窗口（默认为 `<Type>normal</Type>`，自动最大化全部类型为 `normal` 的窗口），本仓库中将其设为 `<Name>application-name</Name>`，以取消自动最大化。若需要修改，可以参考 [Maximizing Only the Main Window](https://github.com/jlesage/docker-baseimage-gui#maximizing-only-the-main-window)。
- `startapp.sh`：容器中用于启动程序的脚本，可以根据实际需要进行修改。

## 容器

### Google Chrome

创建镜像

```bash
cd google-chrome
sudo docker build -t google-chrome-stable:latest .
```

创建容器

```bash
# 容器名称：google-chrome
# 宿主机端口：5801（HTTP）
# 宿主机映射目录：/opt/docker/chrome-data
sudo docker run --env-file=".env" --name="google-chrome" -d -p 5801:5800 -v /opt/docker/chrome-data:/config google-chrome-stable:latest
```

### Microsoft Edge

创建镜像

```bash
cd microsoft-edge
sudo docker build -t microsoft-edge-stable:latest .
```

创建容器

```bash
# 容器名称：microsoft-edge
# 宿主机端口：5802（HTTP）
# 宿主机映射目录：/opt/docker/edge-data
sudo docker run --env-file=".env" --name="microsoft-edge" -d -p 5802:5800 -v /opt/docker/edge-data:/config microsoft-edge-stable:latest
```

## 其他说明

### 解决浏览器无法启动，日志提示“Operation not permitted”的问题

```text
**Failed to move to new namespace: PID namespaces supported, Network namespace supported, but failed: errno = Operation not permitted**
```

参考信息

- [Failed to work with gitkraken · Issue #39 · jlesage/docker-baseimage-gui](https://github.com/jlesage/docker-baseimage-gui/issues/39#issuecomment-679496202)

解决方法

- 浏览器启动参数添加 `--no-sandbox`，禁用沙盒模式（目前没找到其他方法；程序启动脚本中已添加该参数）。

### 解决浏览器标签页崩溃，页面提示错误代码 SIGTRAP 的问题

```text
[0531/173150.456595:ERROR:file_io_posix.cc(144)] open /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq: No such file or directory (2)
```

参考信息

- [Headless Chromium on Docker fails - Stack Overflow](https://stackoverflow.com/questions/56218242/headless-chromium-on-docker-fails)
- [Ubuntu 20.04 安装谷歌浏览器 - 简书](https://www.jianshu.com/p/fc4e97c2e035)
- [When should I use /dev/shm/ and when should I use /tmp/? - Super User](https://superuser.com/questions/45342/when-should-i-use-dev-shm-and-when-should-i-use-tmp)

解决方法

- 方法一：浏览器启动参数添加 `--disable-dev-shm-usage`（程序启动脚本中已添加该参数）。
- 方法二：创建容器时添加参数 `--shm-size=`，设置一个合理的共享内存大小，例如 `docker run --shm-size=1g`。
