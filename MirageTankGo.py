#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""幻影坦克快速发车工具

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

"""


from docopt import docopt
from PIL import Image

try:
    import CMTCore as MTCore
except ImportError:
    import MTCore

# colorfulCar('white.jpg', 'black.jpg', 'output.png', 0.18, 0.5, 0.7)

if __name__ == '__main__':
    argv = docopt(__doc__, version='1.3')
    print(argv)
    if argv['--gui']:
        import MainWindow
        MainWindow.vp_start_gui()
    else:
        whiteImg = Image.open(argv['<whiteImg>'])
        blackImg = Image.open(argv['<blackImg>'])

        if argv['-s']:
            whiteImg = whiteImg.resize((round(x * float(argv['<whiteScale>']))
                                        for x in whiteImg.size), Image.ANTIALIAS)
            blackImg = blackImg.resize((round(x * float(argv['<blackScale>']))
                                        for x in blackImg.size), Image.ANTIALIAS)
        if argv['-l']:
            whiteLit = float(argv['<whiteLit>'])
            blackLit = float(argv['<blackLit>'])
        else:
            whiteLit = 1.0
            blackLit = 0.5

        if argv['-c']:
            MTCore.colorfulCar(whiteImg, blackImg, whiteLit, blackLit,
                               float(argv['<whiteCol>']), float(argv['<blackCol>'])).save(argv['<outputfile>'], 'PNG')
        else:
            MTCore.grayCar(whiteImg, blackImg, whiteLit, blackLit, argv['-e']).save(argv['<outputfile>'], 'PNG')
