# Afilmory Docker 部署

<p align="center">
  🌐
  <a href="readme.md">English</a>
  ·
  <a href="readme.zh-CN.md">简体中文</a>
</p>

一个基于 Docker 的 [Afilmory](https://github.com/Afilmory/Afilmory) 部署方案，让您能够快速部署现代化的照片画廊网站。

## 🚀 快速开始

### 环境要求

- Docker
- Docker Compose (可选)

### 1. 修改配置文件

**`config.json`**

```json
{
  "name": "Your Photo Gallery", // 网站名称
  "title": "Your Photo Gallery", // 页面标题
  "description": "Capturing beautiful moments in life", // 网站描述
  "url": "https://", // 个人 URL
  "accentColor": "#fb7185", // 主题色
  "author": {
    "name": "Your Name",
    "url": "https://your-website.com",
    "avatar": "https://your-avatar-url.com/avatar.png"
  },
  "social": {
    "twitter": "@yourusername"
  },
  "extra": {
    "accessRepo": true
  }
}
```

**`builder.config.json`**

```json
{
  "repo": { // 使用远端仓库作为 manifest 和 thumbnail 缓存
    "enable": false,
    "url": "https://github.com/username/gallery-public"
  },
  "storage": { // 存储配置
    "provider": "s3",
    "bucket": "your-photos-bucket",
    "region": "us-east-1",
    "prefix": "photos/",
    "customDomain": "cdn.yourdomain.com"
  }
}
```

**`.env`**

- S3 存储配置

```
S3_ACCESS_KEY_ID=your_access_key_id
S3_SECRET_ACCESS_KEY=your_secret_access_key
```

- PG (可选)

```
PG_CONNECTION_STRING=
```

- GIT （可选）

```
GIT_TOKEN=
```

### 2. 构建 Docker 镜像

> 大陆服务器可能会遇到 Alpine 内部安装 Perl 失败，打包失败的情况，可在 apk update 命令前插入下属指令，替换源
> ```
> sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories
> ```
> 之后再继续执行 build 指令

```bash
docker build -t afilmory .
```

### 3. 运行容器

```bash
docker run -p 3000:3000 afilmory
```

或者使用 Docker Compose:

```yaml
services:
  afilmory:
    build: .
    ports:
      - '3000:3000'
    environment:
      - NODE_ENV=production
    volumes:
      - ./config.json:/app/config.json
      - ./builder.config.json:/app/builder.config.json
      - ./.env:/app/.env
```


## 📄 许可证

MIT License © 2025
