from PIL import Image
from PIL import ImageEnhance


# 感谢老司机
# https://zhuanlan.zhihu.com/p/31164700
def grayCar(whiteImg, blackImg, float light=0.3):
    """发黑白车"""
    im1 = Image.open(whiteImg)
    im2 = Image.open(blackImg)

    # 保证生成的图像够大
    cdef int whiteWidth, whiteHeight, blackWidth, blackHeight
    whiteWidth, whiteHeight = im1.size
    blackWidth, blackHeight = im2.size
    cdef int width = max(whiteWidth, blackWidth)
    cdef int height = max(whiteHeight, blackHeight)

    im3 = Image.new('RGBA', (width, height))

    # 转成灰度图像
    pix1 = im1.convert('L').load()
    pix2 = im2.convert('L').load()

    cdef int p1, p2, r
    cdef float a
    for i in range(width):
        for j in range(height):
            # 超出范围的部分用白色/黑色填充

            p1 = pix1[i, j] if i < whiteWidth and j < whiteHeight else 255
            p2 = (pix2[i, j] if i < blackWidth and j <
                  blackHeight else 0) * light
            a = 1 - p1 / 255 + p2 / 255
            r = <int > (p2 / a if not a == 0 else 255)
            im3.putpixel((i, j), (r, r, r, < int > (a * 255)))

    return im3


# https://zhuanlan.zhihu.com/p/32532733
def colorfulCar(whiteImg, blackImg, float light, float m_colorWhite, float m_colorBlack):
    """发彩色车"""
    im1 = Image.open(whiteImg)
    im2 = Image.open(blackImg)

    im2 = ImageEnhance.Brightness(im2).enhance(light)

    cdef int whiteWidth, whiteHeight, blackWidth, blackHeight
    whiteWidth, whiteHeight = im1.size
    blackWidth, blackHeight = im2.size
    cdef int width = max(whiteWidth, blackWidth)
    cdef int height = max(whiteHeight, blackHeight)

    im3 = Image.new('RGBA', (width, height))

    pix1 = im1.convert('RGB').load()
    pix2 = im2.convert('RGB').load()

    cdef float r1, g1, b1, r2, g2, b2, r, g, b, a
    cdef float gray1, gray2, dr, dg, db, maxc
    for i in range(width):
        for j in range(height):

            if i < whiteWidth and j < whiteHeight:
                r1, g1, b1 = [x / 255 for x in pix1[i, j]]
            else:
                r1 = g1 = b1 = 255

            if i < blackWidth and j < blackHeight:
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

            im3.putpixel((i, j), (< int > (r * 255), < int > (g * 255),
                                   < int > (b * 255), < int > (a * 255)))

    return im3
