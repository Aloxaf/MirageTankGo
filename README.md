# 幻影坦克快速发车工具

# 简介
生成一张点开后不一样的图片

原理: [幻影坦克架构指南(一)](https://zhuanlan.zhihu.com/p/31164700)


举例:\
    python MirageTankGo.py -o test.png -i bili.png beauty.jpg 

![](https://github.com/YinTianliang/MirageTankGo/blob/master/beauty.jpg)\
**+**\
![](https://github.com/YinTianliang/MirageTankGo/blob/master/bili.jpg)\
**=**\
![](https://github.com/YinTianliang/MirageTankGo/blob/master/test.png)\
(在白色背景和黑色背景下的样子不同)

# 依赖
+ python3
+ docopt
+ Pillow
+ tkinter (可选, windows下自带)
