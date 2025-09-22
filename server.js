const express = require('express');
const multer = require('multer');
const cors = require('cors');
const path = require('path');
const fs = require('fs').promises;
const { exec } = require('child_process');
const { promisify } = require('util');

const execAsync = promisify(exec);
const app = express();
const PORT = 3000;

app.use(cors());
app.use(express.static('.'));

const storage = multer.diskStorage({
    destination: async (req, file, cb) => {
        const uploadDir = path.join(__dirname, 'uploads');
        await fs.mkdir(uploadDir, { recursive: true });
        cb(null, uploadDir);
    },
    filename: (req, file, cb) => {
        const uniqueName = `${Date.now()}-${Math.round(Math.random() * 1E9)}${path.extname(file.originalname)}`;
        cb(null, uniqueName);
    }
});

const upload = multer({ 
    storage: storage,
    fileFilter: (req, file, cb) => {
        if (file.mimetype.startsWith('image/')) {
            cb(null, true);
        } else {
            cb(new Error('只接受图片文件'), false);
        }
    }
});

app.post('/convert', upload.array('images', 100), async (req, res) => {
    try {
        if (!req.files || req.files.length === 0) {
            return res.status(400).send('没有上传文件');
        }

        const outputName = req.body.outputName || 'output.pdf';
        const outputPath = path.join(__dirname, 'outputs');
        await fs.mkdir(outputPath, { recursive: true });
        
        const outputFile = path.join(outputPath, outputName);
        
        const imagePaths = req.files.map(file => `"${file.path}"`).join(' ');
        
        const command = `img2pdf ${imagePaths} -o "${outputFile}"`;
        
        try {
            await execAsync(command);
            
            const pdfData = await fs.readFile(outputFile);
            
            res.setHeader('Content-Type', 'application/pdf');
            res.setHeader('Content-Disposition', `attachment; filename="${outputName}"`);
            res.send(pdfData);
            
            for (const file of req.files) {
                await fs.unlink(file.path).catch(() => {});
            }
            await fs.unlink(outputFile).catch(() => {});
            
        } catch (error) {
            console.error('转换失败:', error);
            
            for (const file of req.files) {
                await fs.unlink(file.path).catch(() => {});
            }
            
            res.status(500).send(`转换失败: ${error.message}`);
        }
        
    } catch (error) {
        console.error('处理请求失败:', error);
        res.status(500).send(`服务器错误: ${error.message}`);
    }
});

app.get('/health', (req, res) => {
    res.json({ status: 'ok', message: '服务器运行正常' });
});

async function checkImg2pdf() {
    try {
        await execAsync('which img2pdf');
        console.log('✅ img2pdf 工具已安装');
        return true;
    } catch {
        console.error('❌ img2pdf 工具未安装');
        console.log('请运行: brew install img2pdf (macOS) 或 pip install img2pdf');
        return false;
    }
}

async function cleanup() {
    try {
        const uploadsDir = path.join(__dirname, 'uploads');
        const outputsDir = path.join(__dirname, 'outputs');
        
        await fs.rm(uploadsDir, { recursive: true, force: true });
        await fs.rm(outputsDir, { recursive: true, force: true });
        
        await fs.mkdir(uploadsDir, { recursive: true });
        await fs.mkdir(outputsDir, { recursive: true });
        
        console.log('✅ 清理临时文件完成');
    } catch (error) {
        console.error('清理文件时出错:', error);
    }
}

async function startServer() {
    const hasImg2pdf = await checkImg2pdf();
    if (!hasImg2pdf) {
        process.exit(1);
    }
    
    await cleanup();
    
    app.listen(PORT, () => {
        console.log(`\n🚀 服务器已启动: http://localhost:${PORT}`);
        console.log('📁 请在浏览器中打开上述地址使用图片转PDF工具');
        console.log('\n按 Ctrl+C 停止服务器\n');
    });
}

process.on('SIGINT', async () => {
    console.log('\n正在关闭服务器...');
    await cleanup();
    process.exit(0);
});

startServer();