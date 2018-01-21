#!/usr/bin/env python
# -*- coding: utf8 -*-
"""幻影坦克快速发车工具

Usage:
    MirageTankGo.py -h
    MirageTankGo.py --gui
    MirageTankGo.py -o <outputfile> -b <blackImg> <whiteImg> ([-r <rat>]|[-c <rat> <whiteLight> <blackLight>])
    MirageTankGo.py -v

Options:
    --gui                       以GUI模式启动(需要tkinter支持, Win下自带)
    -h, --help                  显示本帮助
    -o                          输出文件(png格式)
    -i                          要隐藏的图片
    -r <rat>, --ratio=<rat>     被隐藏图片亮度, 取值0~1, 越低越难发现 [default: 0.3].
    -c                          发彩色车
    -v, --version               显示版本号

Examples:
    python MirageTankGo.py -o reimu.png -b black.png white.jpg -c 0.18 0.5 0.7

"""


from docopt import docopt

try:
    import CMTCore as MTCore
except ImportError:
    import MTCore

# colorfulCar('white.jpg', 'black.jpg', 'output.png', 0.18, 0.5, 0.7)

if __name__ == '__main__':
    argv = docopt(__doc__, version='1.0')

    if argv['--gui']:
        import MainWindow
        MainWindow.vp_start_gui()
    elif argv['-c']:
        MTCore.colorfulCar(argv['<whiteImg>'], argv['<blackImg>'], float(argv['<rat>']),
                    float(argv['<whiteLight>']), float(argv['<blackLight>'])).save(argv['<outputfile>'])
    else:
        MTCore.grayCar(argv['<whiteImg>'], argv['<blackImg>'],
                float(argv['--ratio'])).save(argv['<outputfile>'])

