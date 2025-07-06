#!/bin/bash

echo "📥 در حال کلون ابزار از گیت‌هاب..."
git clone https://github.com/YOUR_USERNAME/BluMirror.git /opt/BluMirror

cd /opt/BluMirror
chmod +x switch.sh

echo "✅ نصب کامل شد!"
echo "برای اجرا بنویسید: sudo /opt/BluMirror/switch.sh"
