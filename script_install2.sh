#!/bin/bash

clear
printf "\n Sau khi cài đặt, mọi quyền hạn và tính năng của Termux sẽ thuộc về Huyền Thoại Hải Tặc\n Ví dụ như bạn không thể apt install bất kì cái gì, kể cả dpkg\n\n Nếu bạn muốn quay về ban đầu, hãy cài đặt lại Termux\n\n - Bạn có muốn tiếp tục? [Y/N]\n\n"
read -p "Lựa chọn: " yesorno

if [[ $yesorno == "Y" ]] || [[ $yesorno == "y" ]]; then
    printf "\n\n"
    echo "Y" | termux-setup-storage &> /dev/null
    url="https://raw.githubusercontent.com/Kiet2007318/Huyen_Thoai_Hai_Tac/main"  # Thay đổi URL ở đây nếu cần
    cpu="$(getprop ro.product.cpu.abi)"
    
    # Xác định kiến trúc CPU
    if [[ $cpu == "arm64-v8a" ]]; then
        archdeb="aarch64"
    elif [[ $cpu == "armeabi-v7a" ]] || [[ $cpu == "armeabi" ]]; then
        archdeb="arm"
    elif [[ $cpu == "x86_64" ]]; then
        archdeb="x64"
    else
        printf "\n Không hổ trợ x86 - 32bit!\n\n"
        exit 0
    fi
    
    clear
    printf "\nDownloading package....\n\n"
    # Thay đổi URL tải xuống gói
    curl -L --max-redirs 15 --progress-bar "https://github.com/Kiet2007318/Huyen_Thoai_Hai_Tac/releases/download/huyenthoaihaitac/huyenthoaihaitac_${archdeb}.deb" --output huyenthoaihaitac.deb || exit 0
    
    # Cài đặt gói
    echo "Y" | dpkg -i --force-overwrite huyenthoaihaitac.deb

    # Tải và chạy script cài đặt
    curl -L --max-redirs 15 --progress-bar "${url}/install.sh" --output install.sh || exit 0
    chmod 777 ./install.sh
    ./install.sh https://fb.me/khanh10a1
fi
