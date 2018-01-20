"""幻影坦克快速发车工具

Usage:
    MirageTankGo.py -h
    MirageTankGo.py --gui
    MirageTankGo.py -o <outputfile> -i <filetohide> <filetoshow> [-r <rat>]
    MirageTankGo.py -v

Options:
    --gui                       以GUI模式启动(需要tkinter支持, Win下自带)
    -h, --help                  显示本帮助
    -o                          输出文件(png格式)
    -i                          要隐藏的图片
    -r <rat>, --ratio=<rat>     被隐藏图片保留比率, 取值0~1, 越低越难发现 [default: 0.3].
    -v, --version               显示版本号

Examples:
    MirageTankGo.py -o ouput.png bili.jpg beauty.jpg

"""

import sys
from PIL import Image
from docopt import docopt


# 感谢老司机
# https://zhuanlan.zhihu.com/p/31164700
def main(img1, img2, img3, xi=0.3):
    'img1:亮的 img2:暗的'
    im1 = Image.open(img1)
    im2 = Image.open(img2)

    width = max(im1.size[0], im2.size[0])
    height = max(im1.size[1], im2.size[1])

    im3 = Image.new('RGBA', (width, height))

    pix1 = im1.convert('L').load()
    pix2 = im2.convert('L').load()

    for i in range(width):
        for j in range(height):
            p1 = pix1[i, j] if i < im1.size[0] and j < im1.size[1] else 255
            p2 = (pix2[i, j] if i < im2.size[0] and j <
                  im2.size[1] else 0) * float(xi)
            a = 1 - p1 / 255 + p2 / 255
            r = int(p2 / a if not a == 0 else 255)
            im3.putpixel((i, j), (r, r, r, int(a * 255)))

    im3.save(img3)


if __name__ == '__main__':
    argv = docopt(__doc__, version='0.2')
    if argv['--gui']:
        import MainWindow
        MainWindow.vp_start_gui()
    else:
        main(argv['<filetoshow>'], argv['<filetohide>'], argv['<outputfile>'], argv['--ratio'])
    # print(arguments)
    # main(*sys.argv[1:])
