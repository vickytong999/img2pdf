#!/bin/bash

echo "GitHub Push Helper"
echo "=================="
echo ""
echo "请输入你的 GitHub Personal Access Token："
echo "（以 ghp_ 开头的字符串）"
read -s TOKEN
echo ""

if [[ -z "$TOKEN" ]]; then
    echo "❌ Token 不能为空"
    exit 1
fi

echo "正在推送代码到 GitHub..."
git push https://$TOKEN@github.com/vickytong999/img2pdf.git main

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ 代码推送成功！"
    echo "🔗 仓库地址: https://github.com/vickytong999/img2pdf"
else
    echo ""
    echo "❌ 推送失败，请检查："
    echo "1. Token 是否正确"
    echo "2. 是否有 repo 权限"
    echo "3. 仓库是否存在"
fi