#!/bin/bash

set -e

# بررسی وجود gum
if ! command -v gum &> /dev/null; then
    echo "📦 نصب gum برای UI..."
    sudo apt update && sudo apt install -y wget
    wget https://github.com/charmbracelet/gum/releases/download/v0.13.0/gum_0.13.0_amd64.deb
    sudo dpkg -i gum_0.13.0_amd64.deb
    rm gum_0.13.0_amd64.deb
fi

# گرفتن نسخه Ubuntu
CODENAME=$(lsb_release -sc)

# انتخاب میرور با gum
CHOICE=$(gum choose "آروان" "شاتل" "رایان‌همراه")

# نگاشت به فایل
case $CHOICE in
  "آروان") MIRROR_FILE="mirrors/arvan.list" ;;
  "شاتل") MIRROR_FILE="mirrors/shatel.list" ;;
  "رایان‌همراه") MIRROR_FILE="mirrors/rayanhamrah.list" ;;
  *) echo "❌ میرور نامعتبر"; exit 1 ;;
esac

gum confirm "⛑ آیا می‌خواهید فایل sources.list فعلی بکاپ‌گیری و جایگزین شود؟" || exit 0

# بکاپ و جایگزینی
sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
sed "s/__CODENAME__/$CODENAME/g" "$MIRROR_FILE" | sudo tee /etc/apt/sources.list > /dev/null

# آپدیت
gum spin --title "در حال اجرای apt update..." -- sudo apt update

gum style --border double --margin "1" --padding "1 2" --foreground "#00FFAA" --bold "🎉 میرور $CHOICE با موفقیت فعال شد!"
