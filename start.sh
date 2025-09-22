#!/bin/bash

echo "======================================="
echo "    Starting Image to PDF Web Tool    "
echo "======================================="
echo ""

check_command() {
    if command -v $1 &> /dev/null; then
        return 0
    else
        return 1
    fi
}

if ! check_command node; then
    echo "❌ Node.js 未安装"
    echo "请先运行: ./install.sh"
    exit 1
fi

if ! check_command img2pdf; then
    echo "❌ img2pdf 未安装"
    echo "请先运行: ./install.sh"
    exit 1
fi

if [ ! -d "node_modules" ]; then
    echo "📦 检测到依赖包未安装，正在安装..."
    npm install
    if [ $? -ne 0 ]; then
        echo "❌ 依赖包安装失败"
        exit 1
    fi
fi

echo "✅ 所有依赖已就绪"
echo ""
echo "🚀 正在启动服务器..."
echo ""

if command -v open &> /dev/null; then
    (sleep 2 && open http://localhost:3000) &
elif command -v xdg-open &> /dev/null; then
    (sleep 2 && xdg-open http://localhost:3000) &
fi

npm start