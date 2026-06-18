# 🚀 Railway VPS

> Create SSH-accessible Linux environments on Railway in minutes.

Deploy an Ubuntu-based SSH-enabled environment on Railway directly from Termux.

## ✨ Features

- 🔐 SSH Access
- 🐧 Ubuntu Based
- 🚀 Deploy from Termux
- 🌐 Public Network Access
- ⚡ Lightweight & Fast
- 🛠️ Easy Configuration
- 📦 Docker Support

---

## 📋 Requirements

- Railway Account
- Termux
- Internet Connection

---

## 📱 Deploy from Termux

### 1. Update Packages

```bash
pkg update -y && pkg upgrade -y
```

### 2. Install Railway CLI

```bash
pkg install -y railway-cli
```

### 3. Login to Railway

```bash
railway login
```

### 5. Clone Repository

```bash
cd && rm -rf railway-vps && git clone https://github.com/viratsingh51188/vps.git && cd vps
```

### 6. Create New Project

```bash
railway init
```

### 7. Deploy

```bash
railway up
```

### 8. Exit Railway
Press CTRL + C

## 🔐 SSH Connection

After deployment, connect using:

```bash
ssh root@YOUR_IP -p PORT 
```

## ⚠️ Disclaimer

This project is intended for educational, development and testing purposes.

Railway usage is subject to Railway's limits, pricing, and policies.

---

## ❤️ Credits

Built with:

- Ubuntu
- OpenSSH
- Docker
- Railway
- Termux

---

## ⭐ Support

If you found this project useful:

- Star the repository
- Fork the repository
- Share it with others

Happy Deploying! 🚀
