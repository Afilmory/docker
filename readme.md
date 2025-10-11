# Afilmory Docker Deployment

<p align="center">
  🌐
  <a href="readme.md">English</a>
  ·
  <a href="readme.zh-CN.md">简体中文</a>
</p>

A [Afilmory](https://github.com/Afilmory/Afilmory) deployment solution based on Docker that allows you to quickly set up a modern photo gallery website.

## 🚀 Quick Start

### Requirements

* Docker
* Docker Compose (optional)

### 1. Edit Configuration Files

**`config.json`**

```json
{
  "name": "Your Photo Gallery", // Website name
  "title": "Your Photo Gallery", // Page title
  "description": "Capturing beautiful moments in life", // Website description
  "url": "https://", // Personal URL
  "accentColor": "#fb7185", // Theme color
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
  "repo": { // Use remote repository as manifest and thumbnail cache
    "enable": false,
    "url": "https://github.com/username/gallery-public"
  },
  "storage": { // Storage configuration
    "provider": "s3",
    "bucket": "your-photos-bucket",
    "region": "us-east-1",
    "prefix": "photos/",
    "customDomain": "cdn.yourdomain.com"
  }
}
```

**`.env`**

* S3 storage configuration:

```
S3_ACCESS_KEY_ID=your_access_key_id
S3_SECRET_ACCESS_KEY=your_secret_access_key
```

* PG (optional):

```
PG_CONNECTION_STRING=
```

* GIT (optional):

```
GIT_TOKEN=
```

### 2. Build Docker Image

```bash
docker build -t afilmory .
```

### 3. Run the Container

```bash
docker run -p 3000:3000 afilmory
```

Or use Docker Compose:

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

## 📄 License

MIT License © 2025
