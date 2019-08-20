#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""幻影坦克快速发车工具

Usage:
    MirageTankGo.py --gui
    MirageTankGo.py -h
    MirageTankGo.py -o OUTPUT BLACKIMG WHITEIMG [-e] [--scale=SCALE] [--light=LIGHT] [--color=COLOR]
    MirageTankGo.py -v

Arguments:
    OUTPUT          输出文件, PNG格式
    BLACKIMG        黑底下显示的图片
    WHITEIMG        白底下显示的图片
    SCALE           图片缩放比例, 格式 白底比例-黑底比例
    LIGHT           图片的亮度, 格式 白底亮度-黑底亮度
    COLOR           色彩保留比例, 格式 白底色彩-黑底色彩

Options:
    --gui           以GUI模式启动(需要tkinter支持, Win下自带)
    -h, --help      显示本帮助
    -o              输出文件(png格式)
    -e              使用棋盘格
    -s              缩放比例
    -l              黑底和白底的亮度, 取值0~1.
    -c              彩色车的黑底白底色彩保留比例, 取值0~1
    -v, --version   显示版本号

Examples:
    python MirageTankGo.py -o remu.png black.jpg white.jpg --scale=1-1 --light=1-0.18 --color=0.5-0.7

"""

from docopt import docopt
from PIL import Image
from MTCore import MTCore


if __name__ == '__main__':
    argv = docopt(__doc__, version='1.4')
    # print(argv)

    kwargs = {}

    if argv['--gui']:
        from GUI import MainWindow
        MainWindow.vp_start_gui()
    else:
        whiteImg = Image.open(argv['WHITEIMG'])
        blackImg = Image.open(argv['BLACKIMG'])

        if argv['--scale']:
            whiteScale, blackScale = argv['--scale'].split('-')
            whiteImg = whiteImg.resize((round(x * float(whiteScale))
                                        for x in whiteImg.size), Image.ANTIALIAS)
            blackImg = blackImg.resize((round(x * float(blackScale))
                                        for x in blackImg.size), Image.ANTIALIAS)
        if argv['--light']:
            light = argv['--light'].split('-')
            kwargs['whiteLight'] = float(light[0])
            kwargs['blackLight'] = float(light[1])

        if argv['-e']:
            kwargs['chess'] = True

        if argv['--color']:
            color = argv['--color'].split('-')
            kwargs['whiteColor'] = float(color[0])
            kwargs['blackColor'] = float(color[1])
            MTCore.color_car(whiteImg, blackImg, **kwargs).save(argv['OUTPUT'], 'PNG')
        else:
            MTCore.gray_car(whiteImg, blackImg, **kwargs).save(argv['OUTPUT'], 'PNG')
