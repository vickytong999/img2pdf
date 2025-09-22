#!/bin/bash

echo "======================================="
echo "   Image to PDF Web Tool Installer    "
echo "======================================="
echo ""

OS_TYPE=$(uname -s)

check_command() {
    if command -v $1 &> /dev/null; then
        echo "✅ $1 已安装"
        return 0
    else
        echo "❌ $1 未安装"
        return 1
    fi
}

install_nodejs() {
    echo "正在检查 Node.js..."
    if check_command node; then
        NODE_VERSION=$(node -v | cut -d'v' -f2 | cut -d'.' -f1)
        if [ "$NODE_VERSION" -ge 14 ]; then
            echo "✅ Node.js 版本满足要求 (v$(node -v | cut -d'v' -f2))"
        else
            echo "⚠️  Node.js 版本过低，建议升级到 14.0.0 或更高版本"
        fi
    else
        echo "📦 正在安装 Node.js..."
        
        if [[ "$OS_TYPE" == "Darwin" ]]; then
            if check_command brew; then
                brew install node
            else
                echo "请先安装 Homebrew 或手动安装 Node.js"
                echo "访问: https://nodejs.org/"
                exit 1
            fi
        elif [[ "$OS_TYPE" == "Linux" ]]; then
            if check_command apt-get; then
                curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
                sudo apt-get install -y nodejs
            elif check_command yum; then
                curl -fsSL https://rpm.nodesource.com/setup_lts.x | sudo bash -
                sudo yum install -y nodejs
            else
                echo "请手动安装 Node.js"
                echo "访问: https://nodejs.org/"
                exit 1
            fi
        fi
    fi
}

install_img2pdf() {
    echo ""
    echo "正在检查 img2pdf..."
    
    if check_command img2pdf; then
        echo "✅ img2pdf 版本: $(img2pdf --version)"
    else
        echo "📦 正在安装 img2pdf..."
        
        if [[ "$OS_TYPE" == "Darwin" ]]; then
            if check_command brew; then
                echo "使用 Homebrew 安装..."
                brew install img2pdf
            elif check_command pip3; then
                echo "使用 pip3 安装..."
                pip3 install img2pdf
            elif check_command pip; then
                echo "使用 pip 安装..."
                pip install img2pdf
            else
                echo "❌ 无法自动安装 img2pdf"
                echo "请手动安装："
                echo "  macOS: brew install img2pdf"
                echo "  或: pip install img2pdf"
                exit 1
            fi
        elif [[ "$OS_TYPE" == "Linux" ]]; then
            if check_command apt-get; then
                echo "使用 apt-get 安装..."
                sudo apt-get update
                sudo apt-get install -y img2pdf
            elif check_command yum; then
                echo "使用 pip 安装..."
                if check_command pip3; then
                    pip3 install img2pdf
                elif check_command pip; then
                    pip install img2pdf
                else
                    echo "请先安装 pip"
                    exit 1
                fi
            elif check_command pip3; then
                echo "使用 pip3 安装..."
                pip3 install img2pdf
            elif check_command pip; then
                echo "使用 pip 安装..."
                pip install img2pdf
            else
                echo "❌ 无法自动安装 img2pdf"
                echo "请手动安装：sudo apt-get install img2pdf 或 pip install img2pdf"
                exit 1
            fi
        fi
        
        if check_command img2pdf; then
            echo "✅ img2pdf 安装成功！"
        else
            echo "❌ img2pdf 安装失败，请手动安装"
            exit 1
        fi
    fi
}

install_npm_packages() {
    echo ""
    echo "正在安装 Node.js 依赖包..."
    
    if [ -f "package.json" ]; then
        npm install
        if [ $? -eq 0 ]; then
            echo "✅ 依赖包安装成功！"
        else
            echo "❌ 依赖包安装失败"
            exit 1
        fi
    else
        echo "❌ 未找到 package.json 文件"
        exit 1
    fi
}

echo "🔍 检测操作系统: $OS_TYPE"
echo ""

install_nodejs
install_img2pdf
install_npm_packages

echo ""
echo "======================================="
echo "        🎉 安装完成！                   "
echo "======================================="
echo ""
echo "启动方法："
echo "  1. 运行: npm start"
echo "  2. 或运行: ./start.sh"
echo "  3. 在浏览器中访问: http://localhost:3000"
echo ""
echo "祝您使用愉快！😊"