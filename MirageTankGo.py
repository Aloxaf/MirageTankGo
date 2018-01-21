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
    MirageTankGo.py -o ouput.png bili.jpg beauty.jpg

"""

from PIL import Image
from PIL import ImageEnhance
from docopt import docopt


# 感谢老司机
# https://zhuanlan.zhihu.com/p/31164700
def grayCar(whiteImg, blackImg, light=0.3):
    'img1:亮的 img2:暗的'
    im1 = Image.open(whiteImg)
    im2 = Image.open(blackImg)

    # 保证生成的图像够大
    width = max(im1.size[0], im2.size[0])
    height = max(im1.size[1], im2.size[1])

    im3 = Image.new('RGBA', (width, height))

    # 转成灰度图像
    pix1 = im1.convert('L').load()
    pix2 = im2.convert('L').load()

    for i in range(width):
        for j in range(height):
            # 超出范围的部分用白色/黑色填充
            p1 = pix1[i, j] if i < im1.size[0] and j < im1.size[1] else 255
            p2 = (pix2[i, j] if i < im2.size[0] and j <
                  im2.size[1] else 0) * float(light)
            a = 1 - p1 / 255 + p2 / 255
            r = int(p2 / a if not a == 0 else 255)
            im3.putpixel((i, j), (r, r, r, int(a * 255)))

    return im3


# https://zhuanlan.zhihu.com/p/32532733
def colorfulCar(whiteImg, blackImg, light, m_colorWhite, m_colorBlack):
    'img1:亮的 img2:暗的'
    im1 = Image.open(whiteImg)
    im2 = Image.open(blackImg)

    im2 = ImageEnhance.Brightness(im2).enhance(light)

    # debug 暂时调整为最小简化代码
    width = max(im1.size[0], im2.size[0])
    height = max(im1.size[1], im2.size[1])

    im3 = Image.new('RGBA', (width, height))

    pix1 = im1.convert('RGB').load()
    pix2 = im2.convert('RGB').load()

    for i in range(width):
        for j in range(height):

            if i < im1.size[0] and j < im1.size[1]:
                r1, g1, b1 = [x / 255 for x in pix1[i, j]]
            else:
                r1 = g1 = b1 = 255

            if i < im2.size[0] and j < im2.size[1]:
                r2, g2, b2 = [x / 255 for x in pix2[i, j]]
            else:
                r2 = g2 = b2 = 0

            gray1 = min((r1 * 0.334 + g1 * 0.333 + b1 * 0.333), 1)
            r1 = r1 * m_colorWhite + gray1 * (1 - m_colorWhite)
            g1 = g1 * m_colorWhite + gray1 * (1 - m_colorWhite)
            b1 = b1 * m_colorWhite + gray1 * (1 - m_colorWhite)
            gray1 = min((r1 * 0.334 + g1 * 0.333 + b1 * 0.333), 1)

            gray2 = min((r2 * 0.334 + g2 * 0.333 + b2 * 0.333), 1)
            r2 = r2 * m_colorBlack + gray2 * (1 - m_colorBlack)
            g2 = g2 * m_colorBlack + gray2 * (1 - m_colorBlack)
            b2 = b2 * m_colorBlack + gray2 * (1 - m_colorBlack)
            gray2 = min((r2 * 0.334 + g2 * 0.333 + b2 * 0.333), 1)

            dr = 1 - r1 + r2
            dg = 1 - g1 + g2
            db = 1 - b1 + b2

            maxc = max(r2, g2, b2)
            a = min(max(dr * 0.222 + dg * 0.707 + db * 0.071, maxc), 1)

            r = min(r2 / a, 1)
            g = min(g2 / a, 1)
            b = min(b2 / a, 1)

            im3.putpixel((i, j), (int(r * 255), int(g * 255),
                                  int(b * 255), int(a * 255)))

    return im3


# colorfulCar('white.jpg', 'black.jpg', 'output.png', 0.18, 0.5, 0.7)

if __name__ == '__main__':
    argv = docopt(__doc__, version='0.2')
    if argv['--gui']:
        import MainWindow
        MainWindow.vp_start_gui()
    elif argv['-c']:
        colorfulCar(argv['<whiteImg>'], argv['<blackImg>'], float(argv['<rat>']),
         float(argv['<whiteLight>']),float(argv['<blackLight>'])).save(argv['<outputfile>'])
    else:
        grayCar(argv['<whiteImg>'], argv['<blackImg>'],
                float(argv['--ratio'])).save(argv['<outputfile>'])
    # print(arguments)
    # main(*sys.argv[1:])
# colorfulCar('white.jpg', 'black.jpg', 'output.png', 0, 0.5, 0.7)
