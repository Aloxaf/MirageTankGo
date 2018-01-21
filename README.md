# 幻影坦克快速发车工具(带图形界面)

# 简介

生成一张点开后不一样的图片

## 原理:

[幻影坦克架构指南(一)](https://zhuanlan.zhihu.com/p/31164700)

[幻影坦克架构指南(三)](https://zhuanlan.zhihu.com/p/32532733)


## 举例:

    python MirageTankGo.py -o reimu.png -b black.png white.jpg -c

白底图

![](https://github.com/YinTianliang/MirageTankGo/blob/master/white.jpg)


黑底图

![](https://github.com/YinTianliang/MirageTankGo/blob/master/black.jpg)


合成图

![](https://github.com/YinTianliang/MirageTankGo/blob/master/reimu.png)

(在白色背景和黑色背景下的样子不同)

# GUI截图 (linux下)
![](https://github.com/YinTianliang/MirageTankGo/blob/master/screenshot.png)

# 依赖
+ python3
+ docopt
+ Pillow
+ tkinter (可选, windows下自带)
