#!/bin/bash
# 由HA制作的nasyt_termux
# NAS油条工具箱（Termux版本）
#赤石/BUG反馈群号:610699712


#🤓变量部分------------------
time_date="2025/11/30"
version="ter v2.0.0"
nasyt_dir="$HOME/.nasyt"
source $nasyt_dir/config.txt >/dev/null 2>&1 ;










#🤓函数部分------------------

#返回函数
esc() {
    echo -e "按$green回车键$color$blue返回$color,按$yellow Ctrl+C$color$red退出$color $*"
    read
}

#定义颜色函数
color_variable() {
    #其他的颜色自己查
    color='\033[0m'
    green='\033[0;32m'
    blue='\033[0;34m'
    red='\033[31m'
    yellow='\033[33m'
    grey='\e[37m'
    pink='\033[38;5;218m'
    cyan='\033[96m'
}

#分割线函数
br() {
    echo -e "\e[1;34m------------------------------------------------------\e[0m"
}

#检查安装函数
pkg_install() {
    pkg_install_app="$*" #读取要安装的软件包
    if command -v $pkg_install_app >/dev/null 2>&1; then
        echo -e "$green ◉ $pkg_install_app已经安装，跳过安装步骤。$color"
    else 
        echo "正在安装$pkg_install_app"
        pkg install $pkg_install_app
        if [ $? -ne 0 ]; then
            echo -e "$green 安装成功 $color" #显示绿色，没有echo -e参数是显示不了颜色的
        else
            echo -e "$red 安装失败 $color" #这里你可以设置成红色
        fi
    fi
}

# 根据时间返回问候语
get_greeting() {
    local hour=$(date +"%H")
    case $hour in
        05|06|07|08|09|10|11)
            echo "🌅 早上好！欢迎使用Termux工具箱"
            ;;
        12|13|14|15|16|17|18)
            echo "☀️ 下午好！欢迎使用Termux工具箱"
            ;;
        *)
            echo "🌙 晚上好！欢迎使用Termux工具箱"
            ;;
    esac
}

must_pkg_install() {
    echo "正在检查必备软件包安装"
    pkg_install curl -y
    pkg_install proot-distro -y
    pkg_install neofetch -y
    pkg_install figlet -y
    pkg_install dialog -y
    pkg_install wget -y
    pkg_install git -y
    pkg_install make -y
    pkg_install cmake -y
    pkg_install clang -y

    clear
}

#介绍
shell_head() {
    br #分割线函数
    get_greeting #调用问候语。
    echo "欢迎使用Termux版本的NAS油条工具箱！"
    echo -e "$pink$(figlet T E R M U X) $color"
    echo ">_ TERMUX VERSION >_"
    echo -e "$blue 这个脚本非常适合Termux新手使用，但是你要明白, $red 该项目不允许二次上传/盗用 $color （除nasyt之外）$red ！！！$color"
    echo -e "$red 再说一次！该项目不允许二次上传/盗用！！！"
    esc #这个esc只是演示
}

menu_main() {
    clear
    if command -v figlet >/dev/null 2>&1; then
        figlet N A S x H A
        warn
    fi
    br #分割
    echo "1) 启动nasyt-termux"
    echo "2) 更新nasyt-termux"
    echo "3) 卸载nasyt-termux"
    echo "0) 退出"
    br #分割
}

#主函数
main() {
    must_pkg_install #必备软件包安装
    shell_head
    
    while true #开启循环
    do
        menu_main #显示菜单文字
        read -p "请选择" menu_1_xz #read用于读取输入
        
        case $menu_1_xz in #case与esac一起使用
            1)
                echo 1
                index_main
                esc
                ;;  # 必须;;结尾，不让会报错
            2)
                echo 2
                esc
                ;;
            3)
                echo 3
                apt remove nasyt-termux.sh -y
                break
                ;;
            0)
                break
                exit
                #用于退出循环
                ;;
            *)
                echo "无效的输入"
                ;;
        esac #case与esac一起使用
    done #循环结束
}

warn(){
    echo -e "$red 注意！$color 请不要二次转发此项目！"
    echo -e "🤓脚本由$blue HA$color 和$blue NAS油条$color 制作"
}


main_home(){
    index_menu_xz=$(dialog --title "NAS油条Linux工具箱" \
    --menu "当前版本:$version $time_date\n本工具箱由NAS油条xHA制作\nQQ群:610699712\n请使用方向键+回车键进行操作\n请选择你要启动的项目：" 0 0 10 \
    1 "系统工具" \
    2 "基础菜单" \
    3 "其它脚本" \
    4 "更新脚本" \
    0 "退出脚本" \
    2>&1 1>/dev/tty) 

}

other_shell(){
    other_shell_xz=$(dialog --title "其他脚本" \
    --menu "请选择" 0 0 10 \
    1 "QEMU管理" \
    0 "←返回" \
    2>&1 1>/dev/tty)
}

system_tools(){
    system_choice=$(dialog --title "系统工具" \
    --menu "请选择" 0 0 10 \
    1 "查看本机logo" \
    2 "查看本机信息" \
    3 "查看termux信息" \
    4 "查询IP信息" \
    0 "←返回" \
    2>&1 1>/dev/tty)
    
}

basic_tools(){
    basic_choice=$(dialog --title "基础菜单" \
    --menu "请选择" 0 0 10 \
    1 "机器人部署" \
    2 "机器人启动" \
    3 "容器管理" \
    4 "Python指定版本安装" \
    5 "石山代码" \
    6 "不要选择" \
    0 "←返回" \
    2>&1 1>/dev/tty)
}

proot_mannage(){
    proot_xz=$(dialog --title "容器管理" \
    --menu "请选择" 0 0 10 \
    1 "下载容器" \
    2 "启动容器" \
    3 "卸载容器" \
    0 "←返回" \
    2>&1 1>/dev/tty)
}

download_proot(){
    download_proot_xz=$(dialog --title "容器下载" \
    --menu "请选择" 0 0 10 \
    1 "adelie" \
    2 "almalinux" \
    3 "alpine" \
    4 "archlinux" \
    5 "artix" \
    6 "chimera" \
    7 "debian" \
    8 "fedora" \
    9 "manjaro" \
    10 "opensuse" \
    11 "oracle" \
    12 "pardus" \
    13 "rockylinux" \
    14 "termux" \
    15 "trisquel" \
    16 "ubuntu " \
    17 "void" \
    0 "←返回" \
    2>&1 1>/dev/tty)
}

download_python(){
    echo "改功能为实验性功能，如有问题请反馈给我们！"
    read -p "请输入Python版本(x.x.x)(<=3.8.x):" version_python
    wget www.python.org/ftp/python/$version_python/Python-$version_python.tgz
    tar -xzf Python-$version_python.tgz && cd Python-$version_python
    export CC=clang
    export CXX=clang++
    export PATH=$PREFIX/bin:$PATH
    ./configure --prefix=$PREFIX CC=clang
    make -j2 && make install
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
    source ~/.bashrc
}

bot_mannage(){
    bot_mannage_xz=$(dialog --title "机器人部署" \
    --menu "请选择" 0 0 10 \
    1 "推荐部署方案AstrBot|NapCat🤓（基于容器）" \
    2 "安装AstrBot机器人" \
    3 "安装Napcat适配器" \
    4 "安装OneBot适配器" \
    0 "←返回" \
    2>&1 1>/dev/tty)
    #你这里忘记加\反斜杠了, 导致菜单显示不出来。
}
bot_mannage_start(){
    bot_mannage_start_xz=$(dialog --title "机器人部署" \
    --menu "请选择" 0 0 10 \
    1 "启动AstrBot" \
    2 "启动NapCat" \
    3 "启动OneBot" \
    0 "←返回" \
    2>&1 1>/dev/tty)
}

qemu_shell(){
qemu_shell_xz=$(dialog --title "QEMU管理" \
    --menu "安装RVNCViewer应用，连接到127.0.0.1:5903（根据-vnc参数中的端口号调整），即可看到界面" 0 0 10 \
    1 "安装系统(QEMU)" \
    2 "启动系统(QEMU)" \
    3 "扩展.img内存" \
    0 "←返回" \
    2>&1 1>/dev/tty)


}

astrbot_napcat(){
    clear
    echo "正在检查proot-distro状态"
    pkg_install proot-distro
    clear
}

index_main(){
    while true
    do
        clear
        main_home
        case $index_menu_xz in
            1)
                echo "系统工具"
                while true
                do
                    pkg_install neofetch
                    clear
                    system_tools
                    case $system_choice in
                        1) 
                            clear
                            neofetch -l
                            esc
                            clear
                            ;; 
                        2) 
                            clear
                            neofetch
                            esc
                            clear
                            ;;
                        3) 
                            clear
                            termux-info
                            esc
                            clear
                            ;;
                        4)  
                            clear
                            ifconfig -a
                            esc
                            clear
                            ;;
                        0) 
                            break
                            clear
                            ;;
                    esac
                done
                ;;
            2)
                echo "基础菜单"
                while true
                do #开始循环。
                    basic_tools 
                    case $basic_choice in #
                        1)
                            echo "机器人部署"
                            while true
                            do
                                bot_mannage #调用bot部署菜单。
                                case $bot_mannage_xz in #读取选择
                                    1)
                                        curl -o napcat.termux.sh https://nclatest.znin.net/NapNeko/NapCat-Installer/main/script/install.termux.sh && bash napcat.termux.sh
                                        proot-distro login napcat -- bash -c 'bash <(curl -sSL https://raw.githubusercontent.com/zhende1113/Antlia/refs/heads/main/Script/AstrBot/Antlia.sh)'
                                        proot-distro login napcat -- bash -c 'logout'
                                        esc
                                        clear
                                        ;; # 这里要用;;结尾，case命令必须要。
                                    2)
                                        proot-distro install debian
                                        proot-distro login debian -- bash -c 'bash <(curl -sSL https://raw.githubusercontent.com/zhende1113/Antlia/refs/heads/main/Script/AstrBot/Antlia.sh)'
                                        esc
                                        clear
                                        ;;
                                    3)
                                        curl -o napcat.termux.sh https://nclatest.znin.net/NapNeko/NapCat-Installer/main/script/install.termux.sh && bash napcat.termux.sh
                                        esc
                                        clear
                                        ;;
                                    4)
                                        bash <(curl -L gitee.com/TimeRainStarSky/TRSS_OneBot/raw/main/Install.sh)
                                        esc
                                        clear
                                        ;;
                                    0)
                                        break #返回
                                        ;;
                                    *)
                                        break
                                        ;;
                                esac
                            done
                            ;;
                        2)
                            echo "机器人启动"
                            while true
                            do
                                bot_mannage_start
                                case $bot_mannage_start_xz in
                                    1)
                                        proot-distro login debian -- bash -c 'cd AstrBot'
                                        proot-distro login debian -- bash -c 'bash astrbot.sh'
                                        esc
                                        ;;
                                    2)
                                        proot-distro login napcat -- bash -c 'xvfb-run -a /root/Napcat/opt/QQ/qq --no-sandbox'
                                        esc
                                        ;;
                                    0)
                                        break
                                        ;;
                                esac
                            done
                            ;;
                        3)
                            clear
                            echo "容器管理"
                            while true
                            do
                                proot_mannage
                                case $proot_xz in
                                    1)
                                        while true
                                        do
                                            download_proot
                                            case $download_proot_xz in
                                                1) 
                                                    clear
                                                    proot-distro install adelie
                                                    echo -e "请输入$blue proot-distro login adelie $color以启动adelie"
                                                    esc
                                                    break
                                                    ;;
                                                2)
                                                    clear
                                                    proot-distro install almalinux
                                                    echo -e "请输入$blue proot-distro login almalinux $color以启动almalinux"
                                                    esc
                                                    break
                                                    ;;
                                                3)
                                                    clear
                                                    proot-distro install alpine
                                                    echo -e "请输入$blue proot-distro login alpine $color以启动alpine"
                                                    esc
                                                    break
                                                    ;;
                                                4)
                                                    clear
                                                    proot-distro install archlinux
                                                    echo -e "请输入$blue proot-distro login archlinux $color以启动archlinux"
                                                    esc
                                                    break
                                                    ;;
                                                5)
                                                    clear
                                                    proot-distro install artix
                                                    echo -e "请输入$blue proot-distro login artix $color以启动artix"
                                                    esc
                                                    break
                                                    ;;
                                                6)
                                                    clear
                                                    proot-distro install chimera
                                                    echo -e "请输入$blue proot-distro login chimera $color以启动chimera"
                                                    esc
                                                    break
                                                    ;;
                                                7)
                                                    clear
                                                    proot-distro install debian
                                                    echo -e "请输入$blue proot-distro login debian $color以启动debian"
                                                    esc
                                                    break
                                                    ;;
                                                8)
                                                    clear
                                                    proot-distro install fedora
                                                    echo -e "请输入$blue proot-distro login fedora $color以启动fedora"
                                                    esc
                                                    break
                                                    ;;
                                                9)
                                                    clear
                                                    proot-distro install manjaro
                                                    echo -e "请输入$blue proot-distro login manjaro $color以启动manjaro"
                                                    esc
                                                    break
                                                    ;;
                                                10)
                                                    clear
                                                    proot-distro install opensuse
                                                    echo -e "请输入$blue proot-distro login opensuse $color以启动opensuse"
                                                    esc
                                                    break
                                                    ;;
                                                11)
                                                    clear
                                                    proot-distro install oracle
                                                    echo -e "请输入$blue proot-distro login oracle $color以启动oracle"
                                                    esc
                                                    break
                                                    ;;
                                                12)
                                                    clear
                                                    proot-distro install pardus
                                                    echo -e "请输入$blue proot-distro login pardus $color以启动pardus"
                                                    esc
                                                    break
                                                    ;;
                                                13)
                                                    clear
                                                    proot-distro install rockylinux
                                                    echo -e "请输入$blue proot-distro login rockylinux $color以启动rockylinux"
                                                    esc
                                                    break
                                                    ;;
                                                14)
                                                    clear
                                                    proot-distro install termux
                                                    echo -e "请输入$blue proot-distro login termux $color以启动termux"
                                                    esc
                                                    break
                                                    ;;
                                                15)
                                                    clear
                                                    proot-distro install trisquel
                                                    echo -e "请输入$blue proot-distro login trisquel $color以启动trisquel"
                                                    esc
                                                    break
                                                    ;;
                                                16)
                                                    clear
                                                    proot-distro install ubuntu
                                                    echo -e "请输入$blue proot-distro login ubuntu $color以启动ubuntu"
                                                    esc
                                                    break
                                                    ;;
                                                17)
                                                    clear
                                                    proot-distro install void
                                                    echo -e "请输入$blue proot-distro login void $color以启动void"
                                                    esc
                                                    break
                                                    ;;
                                                0)
                                                    break
                                                    ;;
                                            esac
                                        done
                                        ;;
                                    2)
                                        break
                                        ;;
                                    3)
                                        break
                                        ;;
                                    0)
                                        break
                                        ;;
                                esac
                            done
                            ;;
                        4)
                            clear
                            download_python
                            esc
                            ;;
                        5)
                            clear
                            echo "请输入你要下载的资源包🤓（比如sl）"
                            read -p "请输入:" package_shit
                            if command -v $package_shit >/dev/null 2>&1; then
                                echo "你似乎已经安装它了，不需要再次安装🙃"
                            else
                                echo "原来你还没安装啊🤓"
                                sleep 1
                                echo "那我帮你安装吧🤓"
                                pkg install $package_shit -y
                                echo "已完成操作🤓"
                            fi
                            esc
                            clear
                            ;;
                        6)
                            clear
                            echo "你竟然选了😨"
                            sleep 1
                            echo "那我帮你退出吧🤓"
                            sleep 1
                            echo "你想让我帮你退出吗？🤓"
                            echo "1.想让你帮我退出🤓"
                            echo "2.不想让你帮我退出🤓"
                            read -p "请输入🤓:" exit_exit
                            case $exit_exit in
                                1)
                                    echo "好的，帮你退出🤓"
                                    exit
                                    ;;
                                2)
                                    clear
                                    echo "你想让我帮你退出吗？🤓"
                                    echo "1.想让你帮我退出🤓"
                                    echo -e "$red ERROR $color"
                                    read -p "请选择🤓:" really_exit
                                        case $really_exit in
                                            1)
                                                exit
                                                ;;
                                            10086)
                                                echo "被你发现了😨"
                                                sleep 1
                                                echo "那给你返回吧😩"
                                                sleep 1
                                                esc
                                                ;;
                                            *)
                                                echo "不选择就帮你退出吧🤓"
                                                exit
                                                ;;
                                        esac
                                    ;;
                                10086)
                                    echo "被你发现了😨"
                                    sleep 1
                                    echo "那给你返回吧😩"
                                    sleep 1
                                    esc
                                    ;;
                                *)
                                    echo "不选择就帮你退出吧🤓"
                                    exit
                                    ;;
                            esac
                            ;;
                        0)
                            break #返回
                            ;;
                    esac
                done #循环结束。
                ;;
            3)
                echo "其他脚本"
                clear
                while true
                do
                    other_shell
                    case $other_shell_xz in
                        1)
                            while true
                            do
                                qemu_shell
                                case $qemu_shell_xz in
                                    1)
                                        clear
                                        echo -e "$green 正在下载QEMU以及相关工具🤓 $color"
                                        pkg update && pkg upgrade
                                        clear
                                        pkg_install qemu-system-x86-64-headless qemu-utils -y
                                        read -p "请输入ISO文件下载网址🤓：" iso_download_url
                                        read -p "请输入ISO文件名（无需输入后缀）🤓:" name_iso
                                        wget -O $name_iso.iso "$iso_download_url"
                                        clear
                                        read -p "磁盘名🤓(.img)（无需加后缀名）：" disk_name
                                        read -p "磁盘内存🤓(G)（只用输入数字）:" disk_size
                                        qemu-img create -f qcow2 $disk_name.img $disk_size
                                        clear
                                        echo "正在通过VNC查看安装界面..."
                                        sleep 1
                                        # 在QEMU启动时抑制特定警告
                                        qemu-system-x86_64 -msg timestamp=on 2>/dev/null
                                        qemu-system-x86_64 -boot menu=on,edd=off -m 2G -hda $disk_name.img
                                        qemu-system-x86_64 -m 2G -vga qxl -net user -net nic,model=virtio -vnc :3 -cpu Skylake-Server -smp 8 -drive file=$disk_name.img,format=qcow2 -cdrom $name_iso.iso
                                        esc
                                        ;;
                                    2)
                                        clear
                                        cd /data/data/com.termux/files/home
                                        read -p "请输入你已安装的.iso文件（无需加后缀名）：" finish_download_iso
                                        read -p "请输入磁盘名称：" disk_have
                                        qemu-system-x86_64 -msg timestamp=on 2>/dev/null
                                        qemu-system-x86_64 -boot menu=on,edd=off -m 2G -hda $disk_have.img
                                        qemu-system-x86_64 -m 2G -vga qxl -net user -net nic,model=virtio -vnc :3 -cpu Skylake-Server -smp 8 -drive file=$disk_have.img,format=qcow2 -cdrom $finish_download_iso.iso
                                        break
                                        ;;
                                    3)
                                        clear
                                        read -p "请输入你要扩展的.img文件（无需加后缀名）" input_img
                                        read -p "请输入你要加的内存（G）（只需输入数字）：" add_GB
                                        qemu-img resize $input_img.img +$add_GB G
                                        cfdisk /dev/sda
                                        resize2fs /dev/sda2
                                    0)
                                        break
                                        ;;
                                esac
                            done
                            ;;
                        0)
                            break
                            ;;
                    esac
                done
                ;;
            0)
                exit 0 #直接退出
                ;;
        esac
    done # 循环结束。
}

install_text(){
    br
    echo "Install programm"
    br
}

install_main(){
    while true
    do
        install_text
        echo "1.安装"
        echo "2.退出"
        read -p "请选择：" choose_main_xz
        case $choose_main_xz in
        1)
            clear
            must_pkg_install
            echo "启动脚本请输入nasyt_termux"
            sleep 1
            clear
            break
            ;;
        2)
            clear
            break
            ;;
        *)
            echo "无效的输入"
            sleep 1
            ;;
        esac
    done
}


#🤓运行部分-----------------
clear #清屏
cd $HOME #进入HOME目录
color_variable #加载颜色函数
main #加载主函数
