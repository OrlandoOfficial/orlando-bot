#!/bin/bash
clear
echo "╭────────────────────────────────────╮"
echo "│     ⫹⫺ INSTALLER ORLANDO BOT       │"
echo "╰────────────────────────────────────╯"

# Deteksi lingkungan
if [ -n "$PREFIX" ]; then
  echo "📱 Deteksi: Termux"
  pkg update -y && pkg upgrade -y
  pkg install -y nodejs git unzip ffmpeg imagemagick
else
  echo "🖥️ Deteksi: VPS / Linux"
  sudo apt update -y && sudo apt upgrade -y
  sudo apt install -y nodejs npm git unzip ffmpeg imagemagick
fi

# Unzip
echo "📦 Mengekstrak Orlando-BOT.zip..."
unzip Orlando-BOT.zip -d orlando-bot
cd orlando-bot || { echo '❌ Folder orlando-bot tidak ditemukan!'; exit 1; }

# Install dependensi nodejs
echo "📦 Menginstall module..."
npm install

# Jalankan langsung atau dengan PM2 jika VPS
if [ -n "$PREFIX" ]; then
  echo -e "\n✅ Instalasi selesai di Termux!"
  echo "📲 Jalankan dengan: node Main.js"
  read -p "Ingin langsung menjalankan bot? (y/n): " jawab
  if [ "$jawab" = "y" ] || [ "$jawab" = "Y" ]; then
    node Main.js
  else
    echo "💡 Ketik 'cd orlando-bot && node Main.js'"
  fi
else
  echo -e "\n🖥️ Menawarkan PM2 untuk VPS (opsional)"
  read -p "Ingin install PM2 dan menjalankan bot dengan PM2? (y/n): " pm2on
  if [ "$pm2on" = "y" ] || [ "$pm2on" = "Y" ]; then
    sudo npm install -g pm2
    pm2 start Main.js --name "OrlandoBot"
    pm2 save
    pm2 startup
    echo "✅ Bot dijalankan dengan PM2. Ketik: pm2 logs OrlandoBot"
  else
    echo "📲 Jalankan bot manual dengan: node Main.js"
  fi
fi
