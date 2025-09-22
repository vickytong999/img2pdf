let selectedFiles = [];

document.addEventListener('DOMContentLoaded', function() {
    const imageFilesInput = document.getElementById('imageFiles');
    const fileList = document.getElementById('fileList');
    const convertBtn = document.getElementById('convertBtn');
    const clearBtn = document.getElementById('clearBtn');
    const outputNameInput = document.getElementById('outputName');
    const statusMessage = document.getElementById('statusMessage');
    
    imageFilesInput.addEventListener('change', handleFileSelect);
    convertBtn.addEventListener('click', handleConvert);
    clearBtn.addEventListener('click', handleClear);
    
    function handleFileSelect(event) {
        const files = Array.from(event.target.files);
        files.forEach(file => {
            if (file.type.startsWith('image/')) {
                if (!selectedFiles.some(f => f.name === file.name)) {
                    selectedFiles.push(file);
                }
            }
        });
        updateFileList();
        updateConvertButton();
    }
    
    function updateFileList() {
        if (selectedFiles.length === 0) {
            fileList.innerHTML = '<div class="empty-state">还没有选择文件</div>';
        } else {
            fileList.innerHTML = selectedFiles.map((file, index) => `
                <div class="file-item">
                    <span class="file-name">${file.name}</span>
                    <button class="remove-btn" onclick="removeFile(${index})">删除</button>
                </div>
            `).join('');
        }
    }
    
    function updateConvertButton() {
        convertBtn.disabled = selectedFiles.length === 0;
    }
    
    window.removeFile = function(index) {
        selectedFiles.splice(index, 1);
        updateFileList();
        updateConvertButton();
    };
    
    async function handleConvert() {
        if (selectedFiles.length === 0) {
            showStatus('请先选择图片文件', 'error');
            return;
        }
        
        const outputName = outputNameInput.value.trim();
        if (!outputName) {
            showStatus('请输入输出文件名', 'error');
            return;
        }
        
        if (!outputName.endsWith('.pdf')) {
            outputNameInput.value = outputName + '.pdf';
        }
        
        convertBtn.disabled = true;
        convertBtn.innerHTML = '转换中<span class="spinner"></span>';
        
        const formData = new FormData();
        selectedFiles.forEach(file => {
            formData.append('images', file);
        });
        formData.append('outputName', outputNameInput.value);
        
        try {
            const response = await fetch('http://localhost:3000/convert', {
                method: 'POST',
                body: formData
            });
            
            if (response.ok) {
                const blob = await response.blob();
                const url = window.URL.createObjectURL(blob);
                const a = document.createElement('a');
                a.href = url;
                a.download = outputNameInput.value;
                document.body.appendChild(a);
                a.click();
                document.body.removeChild(a);
                window.URL.revokeObjectURL(url);
                
                showStatus('PDF文件已成功生成并下载！', 'success');
                setTimeout(() => {
                    handleClear();
                }, 2000);
            } else {
                const error = await response.text();
                showStatus(`转换失败: ${error}`, 'error');
            }
        } catch (error) {
            showStatus(`连接服务器失败: ${error.message}`, 'error');
        } finally {
            convertBtn.disabled = false;
            convertBtn.innerHTML = '转换为PDF';
            updateConvertButton();
        }
    }
    
    function handleClear() {
        selectedFiles = [];
        imageFilesInput.value = '';
        outputNameInput.value = 'output.pdf';
        updateFileList();
        updateConvertButton();
        statusMessage.innerHTML = '';
    }
    
    function showStatus(message, type) {
        statusMessage.className = `status-message ${type}`;
        statusMessage.textContent = message;
        
        if (type !== 'error') {
            setTimeout(() => {
                statusMessage.innerHTML = '';
            }, 5000);
        }
    }
});