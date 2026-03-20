# 1. 使用极简的 Alpine 镜像作为底盘
FROM alpine:3.18

# 2. Alpine 使用 apk 作为包管理器，安装 nginx
# --no-cache 表示不保存缓存文件，进一步缩小体积
RUN apk add --no-cache nginx

# 3. 准备 Nginx 运行需要的目录（Alpine 的 Nginx 不会自动创建这些）
RUN mkdir -p /var/www/localhost/htdocs

# 4. 替换网页文件
# 注意：Alpine 中 Nginx 默认网页路径可能与 Ubuntu 不同
# 通常在 /var/www/localhost/htdocs 或 /usr/share/nginx/html
COPY src/index.html /var/www/localhost/htdocs/index.html
COPY my-nginx.conf /etc/nginx/http.d/default.conf

EXPOSE 80

# 5. 覆盖 Nginx 配置或直接启动
# 为了简单起见，我们直接告诉 nginx 以前台模式启动
CMD ["nginx", "-g", "daemon off;"]