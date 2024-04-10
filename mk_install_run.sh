set -o errexit #增加这句话，出错之后就会退出啦

echo "### date:2021年11月29日
### author: www.mrdoc.fun | jonnyan404
### 转载请保留来源
### update：2022年08月14日
version: '3.0'
services:
    ztncui:
        container_name: ztncui
        restart: always
        environment:
            - MYADDR=$1 #改成自己的服务器公网IP
            - HTTP_PORT=4000
            - HTTP_ALL_INTERFACES=yes
            - ZTNCUI_PASSWD=mrdoc.fun
        ports:
            - '4000:4000' # web控制台入口
            - '9993:9993'
            - '9993:9993/udp'
            - '3180:3180' # planet/moon文件在线下载入口，如不对外提供。可防火墙禁用此端口。
        volumes:
            - './zerotier-one:/var/lib/zerotier-one'
            - './ztncui/etc:/opt/key-networks/ztncui/etc'
            # 按实际路径挂载卷， 冒号前面是宿主机的， 支持相对路径
        image: keynetworks/ztncui
" > docker-compose.yml

docker-compose up -d
# 以下步骤为创建planet和moon
docker cp mkmoonworld-x86_64 ztncui:/tmp
docker cp patch.sh ztncui:/tmp
docker exec -it ztncui bash /tmp/patch.sh
docker restart ztncui
