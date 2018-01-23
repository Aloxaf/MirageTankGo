from PIL import Image
from PIL import ImageEnhance
import cython
cimport cython


# 感谢老司机
# https://zhuanlan.zhihu.com/p/31164700

# TODO: 棋盘格化怎么翻译
@cython.boundscheck(False)
@cython.wraparound(False)
@cython.cdivision(True)
cpdef grayCar(whiteImg, blackImg, float whiteLight=1.0, float blackLight=0.3, bint chess=False):
    """发黑白车"""
    # 加载图像, 转成灰度图
    _im1 = whiteImg.convert('L')
    _im2 = blackImg.convert('L')

    # 保证生成的图像够大
    cdef int whiteWidth, whiteHeight, blackWidth, blackHeight

    whiteWidth, whiteHeight = _im1.size
    blackWidth, blackHeight = _im2.size

    cdef int width = max(whiteWidth, blackWidth)
    cdef int height = max(whiteHeight, blackHeight)

    # 建立新的, 大小合适图片
    im3 = Image.new('RGBA', (width, height))
    im1 = Image.new('L', (width, height), 255)
    im2 = Image.new('L', (width, height), 0)

    # 将原图复制到新图像里面
    im1.paste(_im1, ((width - whiteWidth) / 2, (height - whiteHeight) / 2))
    im2.paste(_im2, ((width - blackWidth) / 2, (height - blackHeight) / 2))

    # 根据官方文档的说法, getpixel和putpixel效率太低, 换用getdata和putdata
    pix1 = list(im1.getdata())
    pix2 = list(im2.getdata())
    pix3 = []

    # 棋盘格化
    cdef int x, y, i

    if chess:
        for i in range(width * height):
            x = i / whiteWidth
            y = i % whiteWidth
            if (x + y) % 2 == 0:
                pix1[i] = 255
            else:
                pix2[i] = 0

    cdef int r
    cdef float a, p1, p2
    for i in range(width * height):

        p1 = pix1[i] / 255 * whiteLight
        p2 = pix2[i] / 255 * blackLight

        a = 1 - p1 + p2
        r = <int>(p2 / a * 255 if not a == 0 else 255)

        pix3.append((r, r, r, <int>(a * 255)))

    im3.putdata(pix3)

    return im3

# https://zhuanlan.zhihu.com/p/32532733
@cython.boundscheck(False)
@cython.wraparound(False)
@cython.cdivision(True)
cpdef colorfulCar(whiteImg, blackImg, whiteLight=1.0, blackLight=0.18, float whiteColor=0.5, float blackColor=0.7, bint chess=False):
    """发彩色车"""
    # 加载图像, 转成RGB格式
    _im1 = whiteImg.convert('RGB')
    _im2 = blackImg.convert('RGB')

    _im1 = ImageEnhance.Brightness(_im1).enhance(whiteLight)
    _im2 = ImageEnhance.Brightness(_im2).enhance(blackLight)

    # 将长宽提取提取出来, 提高后面访问的速度
    cdef int whiteWidth, whiteHeight, blackWidth, blackHeight
    whiteWidth, whiteHeight = _im1.size
    blackWidth, blackHeight = _im2.size
    cdef int width = max(whiteWidth, blackWidth)
    cdef int height = max(whiteHeight, blackHeight)

    # 建立新的, 大小合适图片
    im3 = Image.new('RGBA', (width, height))
    im1 = Image.new('RGB', (width, height), (255, 255, 255))
    im2 = Image.new('RGB', (width, height), (0, 0, 0))

    # 将原图复制到新图像里面
    im1.paste(_im1, ((width - whiteWidth) / 2, (height - whiteHeight) / 2))
    im2.paste(_im2, ((width - blackWidth) / 2, (height - blackHeight) / 2))

    # 根据官方文档的说法, getpixel和putpixel效率太低, 换用getdata和putdata
    pix1 = list(im1.getdata())
    pix2 = list(im2.getdata())
    pix3 = []

    # 棋盘格化
    cdef int x, y, i

    if chess:
        for i in range(width * height):
            x = i / whiteWidth
            y = i % whiteWidth
            if (x + y) % 2 == 0:
                pix1[i] = (255, 255, 255)
            else:
                pix2[i] = (0, 0, 0)

    cdef float r1, g1, b1, r2, g2, b2, r, g, b, a
    cdef float gray1, gray2, dr, dg, db, maxc

    for i in range(width * height):

        r1, g1, b1 = [x / 255.0 for x in pix1[i]]
        r2, g2, b2 = [x / 255.0 for x in pix2[i]]

        gray1 = min((r1 * 0.334 + g1 * 0.333 + b1 * 0.333), 1)
        r1 = r1 * whiteColor + gray1 * (1 - whiteColor)
        g1 = g1 * whiteColor + gray1 * (1 - whiteColor)
        b1 = b1 * whiteColor + gray1 * (1 - whiteColor)
        # gray1 = min((r1 * 0.334 + g1 * 0.333 + b1 * 0.333), 1)

        gray2 = min((r2 * 0.334 + g2 * 0.333 + b2 * 0.333), 1)
        r2 = r2 * blackColor + gray2 * (1 - blackColor)
        g2 = g2 * blackColor + gray2 * (1 - blackColor)
        b2 = b2 * blackColor + gray2 * (1 - blackColor)
        # gray2 = min((r2 * 0.334 + g2 * 0.333 + b2 * 0.333), 1)

        dr = 1 - r1 + r2
        dg = 1 - g1 + g2
        db = 1 - b1 + b2

        maxc = max(r2, g2, b2)
        a = min(max(dr * 0.222 + dg * 0.707 + db * 0.071, maxc), 1)

        if a == 0:
            r = g = b = 1
        else:
            r = min(r2 / a, 1)
            g = min(g2 / a, 1)
            b = min(b2 / a, 1)


        pix3.append((<int>(r * 255), <int>(g * 255), <int>(b * 255), <int>(a * 255)))

    im3.putdata(pix3)

    return im3
