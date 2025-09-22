# 🖼️ Image to PDF Converter Web Tool

一个简单易用的网页版图片转PDF工具，可以批量将图片文件（PNG、JPG等）合并转换为PDF文档。

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Node](https://img.shields.io/badge/node-%3E%3D14.0.0-green.svg)
![Platform](https://img.shields.io/badge/platform-macOS%20%7C%20Linux%20%7C%20Windows-lightgrey.svg)

## ✨ 功能特点

- 🎯 简洁美观的网页界面
- 📁 支持批量选择多个图片文件
- 🔄 一键合并转换为PDF
- 💾 自动下载生成的PDF文件
- 🚀 本地运行，保护隐私安全
- 🎨 响应式设计，适配各种屏幕

## 📋 系统要求

- Node.js >= 14.0.0
- npm 或 yarn
- img2pdf 命令行工具

## 🚀 快速开始

### 方式一：使用自动安装脚本

#### macOS/Linux:
```bash
git clone https://github.com/yourusername/img2pdf-web.git
cd img2pdf-web
chmod +x install.sh
./install.sh
```

#### Windows:
```cmd
git clone https://github.com/yourusername/img2pdf-web.git
cd img2pdf-web
install.bat
```

### 方式二：手动安装

1. **克隆仓库**
```bash
git clone https://github.com/yourusername/img2pdf-web.git
cd img2pdf-web
```

2. **安装 img2pdf 工具**

macOS:
```bash
brew install img2pdf
```

Ubuntu/Debian:
```bash
sudo apt-get install img2pdf
```

使用 pip:
```bash
pip install img2pdf
```

Windows:
```bash
pip install img2pdf
```

3. **安装 Node.js 依赖**
```bash
npm install
```

4. **启动服务**
```bash
npm start
```

5. **打开浏览器访问**
```
http://localhost:3000
```

## 📖 使用说明

1. 启动服务后，在浏览器中打开 `http://localhost:3000`
2. 点击"选择图片文件"按钮，选择要转换的图片
3. 可以选择多个图片文件，支持 PNG、JPG、JPEG、GIF、BMP 等格式
4. 设置输出文件名（可选，默认为 output.pdf）
5. 点击"转换为PDF"按钮
6. 等待转换完成，PDF文件会自动下载

## 🛠️ 项目结构

```
img2pdf-web/
├── index.html          # 前端HTML页面
├── script.js           # 前端JavaScript逻辑
├── server.js           # Node.js后端服务
├── package.json        # 项目配置文件
├── install.sh          # macOS/Linux安装脚本
├── install.bat         # Windows安装脚本
├── start.sh            # macOS/Linux启动脚本
├── start.bat           # Windows启动脚本
└── README.md           # 项目说明文档
```

## 🔧 配置选项

可以在 `server.js` 中修改以下配置：

```javascript
const PORT = 3000;  // 服务器端口
```

## 🐛 常见问题

### Q: 提示 img2pdf 未安装
A: 请根据你的操作系统安装 img2pdf 工具：
- macOS: `brew install img2pdf`
- Linux: `sudo apt-get install img2pdf` 或 `pip install img2pdf`
- Windows: `pip install img2pdf`

### Q: 无法访问 localhost:3000
A: 
1. 确保服务已启动（终端显示"服务器已启动"）
2. 检查端口是否被占用：`lsof -i :3000` (macOS/Linux)
3. 尝试更换端口号

### Q: 转换失败
A: 
1. 确保选择的是有效的图片文件
2. 检查 img2pdf 是否正确安装：`img2pdf --version`
3. 查看终端错误信息

## 📝 开发

### 本地开发
```bash
npm run dev
```

### 添加新功能
欢迎提交 Pull Request！

## 🤝 贡献

欢迎贡献代码、报告问题或提出新功能建议！

1. Fork 本仓库
2. 创建你的功能分支 (`git checkout -b feature/AmazingFeature`)
3. 提交你的更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 开启一个 Pull Request

## 📄 许可证

本项目采用 MIT 许可证 - 查看 [LICENSE](LICENSE) 文件了解详情

## 👨‍💻 作者

- GitHub: [@yourusername](https://github.com/yourusername)

## 🌟 Star History

如果这个项目对你有帮助，请给个 ⭐ Star！

## 📧 联系方式

如有问题或建议，请提交 [Issue](https://github.com/yourusername/img2pdf-web/issues) 或发送邮件至 your.email@example.com

---

Made with ❤️ by [Your Name]