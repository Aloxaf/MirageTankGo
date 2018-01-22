#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""幻影坦克快速发车工具

Usage:
    MirageTankGo.py --gui
    MirageTankGo.py -h
    MirageTankGo.py -o <outputfile> -b <blackImg> <whiteImg> [-s <scale>] ([-l <lit>] [-e]|[-c <lit> <whiteLight> <blackLight>])
    MirageTankGo.py -v

Options:
    --gui                       以GUI模式启动(需要tkinter支持, Win下自带)
    -h, --help                  显示本帮助
    -o                          输出文件(png格式)
    -s, --scale=<scale>         缩放比例 [default: 1.0]
    -b                          黑底下显示的图片
    -l <lit>, --light=<lit>     黑底图片亮度, 取值0~1, 越低越难发现 [default: 0.3].
    -c                          发彩色车
    -e                          使用棋盘格
    -v, --version               显示版本号

Examples:
    python MirageTankGo.py -o remu.png -b black.png white.jpg -c 0.18 0.5 0.7

"""


from docopt import docopt
from PIL import Image

try:
    import CMTCore as MTCore
except ImportError:
    import MTCore

# colorfulCar('white.jpg', 'black.jpg', 'output.png', 0.18, 0.5, 0.7)

if __name__ == '__main__':
    argv = docopt(__doc__, version='1.2')
    # print(argv)
    if argv['--gui']:
        import MainWindow
        MainWindow.vp_start_gui()

    whiteImg = Image.open(argv['<whiteImg>'])
    blackImg = Image.open(argv['<blackImg>'])

    if argv['-s']:
        scale = float(['<scale>'])
        whiteImg = whiteImg.resize((round(x * scale) for x in whiteImg.size), Image.ANTIALIAS)
        blackImg = blackImg.resize((round(x * scale) for x in blackImg.size), Image.ANTIALIAS)

    if argv['-c']:
        MTCore.colorfulCar(whiteImg, blackImg, float(argv['<lit>']),
                    float(argv['<whiteLight>']), float(argv['<blackLight>'])).save(argv['<outputfile>'], 'PNG')
    else:
        MTCore.grayCar(whiteImg, blackImg, float(argv['--light']), argv['-e']).save(argv['<outputfile>'], 'PNG')

