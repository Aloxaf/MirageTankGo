# 幻影坦克快速发车工具(带图形界面)

## 简介

"幻影坦克", 是对指点开后不一样的图片的戏称.
实际上就是在黑底和白底下的显示不一样的图片.
常用于老司机发车.

本工具可以让您无论在Linux还是在Windows下都能快速发车

### 原理

[幻影坦克架构指南(一)](https://zhuanlan.zhihu.com/p/31164700)

[幻影坦克架构指南(三)](https://zhuanlan.zhihu.com/p/32532733)

[棋盘格与幻影坦克](https://zhuanlan.zhihu.com/p/33148445)

### 用法

    Usage:
        MirageTankGo.py --gui
        MirageTankGo.py -h
        MirageTankGo.py -o <outputfile> <blackImg> <whiteImg>
                        [-s <whiteScale> <blackScale>]
                        [-l <whiteLit> <blackLit>]
                        [-e | -c <whiteCol> <blackCol>]
        MirageTankGo.py -v
    
    Options:
        --gui                以GUI模式启动(需要tkinter支持, Win下自带)
        -h, --help           显示本帮助
        -o                   输出文件(png格式)
        -s                   缩放比例
        -l                   黑底和白底的亮度, 取值0~1.
        -e                   使用棋盘格(仅限灰度车)
        -c                   彩色车的黑底白底色彩保留比例, 取值0~1
        -v, --version        显示版本号
    
    Examples:
        python MirageTankGo.py -o remu.png black.jpg white.jpg -s 1 1 -l 1 0.18 -c 0.5 0.7

## 加速(推荐)

安装[cython](http://cython.org/).

可编译生成优化后的CMTCore, 大幅提高车速.


## 示例

白底图

<img src="https://github.com/YinTianliang/MirageTankGo/blob/master/white.jpg" width="272" height="550">


黑底图

<img src="https://github.com/YinTianliang/MirageTankGo/blob/master/black.jpg" width="272" height="550">


合成图

<img src="https://github.com/YinTianliang/MirageTankGo/blob/master/remu.png" width="272" height="550">

(在白色背景和黑色背景下的样子不同, 建议使用手机QQ发送以查看效果)


## GUI截图

![](https://github.com/YinTianliang/MirageTankGo/blob/master/screenshot.png)


![](https://github.com/YinTianliang/MirageTankGo/blob/master/screenshot2.png)

## 依赖

+ python3
+ docopt
+ Pillow
+ cython (可选, 可提高车速)
+ tkinter (可选, windows下自带)
