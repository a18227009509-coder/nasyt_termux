#!/bin/bash
# 由HA制作的nasyt_termux
# NAS油条工具箱（Termux版本）
#赤石/BUG反馈群号:610699712


#🤓变量部分------------------
time_date="2025/11/30"
version="ter v1.0.0"
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
            echo -e "安装失败 $red" #这里你可以设置成红色
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
    clear
}

#介绍
shell_head() {
    br #分割线函数
    get_greeting #调用问候语。
    echo "欢迎使用Termux版本的NAS油条工具箱！"
    neofetch -l
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

basic_tools(){
    system_choice=$(dialog --title "系统菜单" \
    --menu "请选择" 0 0 10 \
    1 "机器人部署" \
    2 "机器人启动" \
    3 "石山代码" \
    4 "不要选择" \
    0 "←返回" \
    2>&1 1>/dev/tty)
}

bot_mannage(){
    bot_mannage_xz=$(dialog --title "BOT部署" \
    --menu "请选择" 0 0 10 \
    1 "推荐部署方案AstrBot|NapCat🤓" \
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

test_proot(){
    if command -v proot-distro >/dev/null 2>&1; then
        echo -e "$green ◉proot-distro已安装,跳过安装$color"
    else
        echo -e "正在安装proot-distro"
        pkg install proot-distro -y
    fi
    #这里的if对齐的话好辨认点。
}

astrbot_napcat(){
    clear
    echo "正在检查proot-distro状态"
    test_proot
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
                esc
                #后面的自己写。
                ;;
            2)
                echo "基础菜单"
                while true
                do #开始循环。
                    basic_tools 
                    case $system_choice in #
                        1)
                            echo "机器人部署"
                            bot_mannage #调用bot部署菜单。
                            case $bot_mannage_xz in #读取选择
                                1)
                                    bash <(curl -sSL https://raw.githubusercontent.com/zhende1113/Antlia/refs/heads/main/Script/AstrBot/Antlia.sh)
                                    esc
                                    curl -o napcat.termux.sh https://nclatest.znin.net/NapNeko/NapCat-Installer/main/script/install.termux.sh && bash napcat.termux.sh
                                    logout
                                    ;; # 这里要用;;结尾，case命令必须要。
                                2)
                                    bash <(curl -sSL https://raw.githubusercontent.com/zhende1113/Antlia/refs/heads/main/Script/AstrBot/Antlia.sh)
                                    esc
                                    ;;
                                3)
                                    curl -o napcat.termux.sh https://nclatest.znin.net/NapNeko/NapCat-Installer/main/script/install.termux.sh && bash napcat.termux.sh
                                    esc
                                    ;;
                                4)
                                    bash <(curl -L gitee.com/TimeRainStarSky/TRSS_OneBot/raw/main/Install.sh)
                                    esc
                                    ;;
                                0)
                                    break #返回
                                    ;;
                                *)
                                    break
                                    ;;
                            esac
                            ;;
                        2)
                            echo "机器人启动"
                            bot_mannage_start
                            case $bot_mannage_start_xz in
                                1)
                                   cd AstrBot
                                   bash astrbot.sh
                                   esc
                                   ;;
                                2)
                                   proot-distro login napcat
                                   xvfb-run -a /root/Napcat/opt/QQ/qq --no-sandbox
                                   esc
                                   ;;
                            esac
                            ;;
                        3)
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
                        4)
                            clear
                            echo "你竟然选了😨"
                            sleep 1
                            echo "那我帮你退出吧🤓"
                            sleep 1
                            exit
                            ;;
                        0)
                            break #返回
                            ;;
                    esac
                done #循环结束。
                ;;
            3)
                echo "其他脚本"
                esc
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
