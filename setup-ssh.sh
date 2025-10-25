#!/bin/bash

echo "======================================="
echo "     GitHub SSH 配置助手"
echo "======================================="
echo ""

# 检查是否已有 SSH 密钥
if [ -f ~/.ssh/id_ed25519.pub ] || [ -f ~/.ssh/id_rsa.pub ]; then
    echo "✅ 检测到已有 SSH 密钥"
    echo ""
    echo "请选择操作："
    echo "1) 使用现有密钥"
    echo "2) 生成新的密钥"
    read -p "选择 (1 或 2): " choice
else
    echo "❌ 未检测到 SSH 密钥"
    choice="2"
fi

if [ "$choice" = "2" ]; then
    echo ""
    echo "正在生成新的 SSH 密钥..."
    read -p "请输入你的 GitHub 邮箱: " email
    
    # 生成 ED25519 密钥（更安全）
    ssh-keygen -t ed25519 -C "$email" -f ~/.ssh/id_ed25519
    
    echo ""
    echo "✅ SSH 密钥生成成功！"
fi

# 启动 ssh-agent
echo ""
echo "启动 SSH 代理..."
eval "$(ssh-agent -s)"

# 添加密钥到 ssh-agent
if [ -f ~/.ssh/id_ed25519 ]; then
    ssh-add ~/.ssh/id_ed25519
elif [ -f ~/.ssh/id_rsa ]; then
    ssh-add ~/.ssh/id_rsa
fi

echo ""
echo "======================================="
echo "     请将以下公钥添加到 GitHub"
echo "======================================="
echo ""

# 显示公钥
if [ -f ~/.ssh/id_ed25519.pub ]; then
    echo "你的 SSH 公钥内容："
    echo "-----------------------------------"
    cat ~/.ssh/id_ed25519.pub
    echo "-----------------------------------"
    
    # 尝试复制到剪贴板
    if command -v pbcopy &> /dev/null; then
        cat ~/.ssh/id_ed25519.pub | pbcopy
        echo ""
        echo "✅ 公钥已复制到剪贴板！"
    fi
elif [ -f ~/.ssh/id_rsa.pub ]; then
    echo "你的 SSH 公钥内容："
    echo "-----------------------------------"
    cat ~/.ssh/id_rsa.pub
    echo "-----------------------------------"
    
    # 尝试复制到剪贴板
    if command -v pbcopy &> /dev/null; then
        cat ~/.ssh/id_rsa.pub | pbcopy
        echo ""
        echo "✅ 公钥已复制到剪贴板！"
    fi
fi

echo ""
echo "📝 添加到 GitHub 的步骤："
echo "1. 打开 https://github.com/settings/keys"
echo "2. 点击 'New SSH key'"
echo "3. Title: 输入描述 (如: MacBook Pro)"
echo "4. Key: 粘贴上面的公钥内容"
echo "5. 点击 'Add SSH key'"
echo ""
echo "添加完成后，按回车继续..."
read

# 测试 SSH 连接
echo ""
echo "测试 GitHub SSH 连接..."
ssh -T git@github.com

echo ""
echo "======================================="
echo "     配置 Git 仓库使用 SSH"
echo "======================================="
echo ""

# 切换远程仓库到 SSH
echo "正在将远程仓库切换到 SSH..."
git remote set-url origin git@github.com:vickytong999/img2pdf.git

echo "✅ 远程仓库已切换到 SSH"
echo ""
git remote -v

echo ""
echo "======================================="
echo "     现在可以推送代码了！"
echo "======================================="
echo ""
echo "运行以下命令推送代码："
echo "git push -u origin main"
echo ""