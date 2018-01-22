from PIL import Image
from PIL import ImageEnhance

# 感谢老司机
# https://zhuanlan.zhihu.com/p/31164700
def grayCar(whiteImg, blackImg, light=0.3, chess=False):
    """发黑白车"""
    # 加载图像, 转成灰度图
    _im1 = whiteImg.convert('L')
    _im2 = blackImg.convert('L')

    # 保证生成的图像够大
    whiteWidth, whiteHeight = _im1.size
    blackWidth, blackHeight = _im2.size

    width = max(whiteWidth, blackWidth)
    height = max(whiteHeight, blackHeight)


    # 建立新的, 大小合适图片
    im3 = Image.new('RGBA', (width, height))
    im1 = Image.new('L', (width, height), 255)
    im2 = Image.new('L', (width, height), 0)

    # 将原图复制到新图像里面
    im1.paste(_im1, ((width - whiteWidth) // 2, (height - whiteHeight) // 2))
    im2.paste(_im2, ((width - blackWidth) // 2, (height - blackHeight) // 2))

    # 根据官方文档的说法, getpixel和putpixel效率太低, 换用getdata和putdata
    pix1 = list(im1.getdata())
    pix2 = list(im2.getdata())
    pix3 = []

    # 棋盘格化
    if chess:
        for i in range(width * height):
            x = i // whiteWidth
            y = i % whiteWidth
            if (x + y) % 2 == 0:
                pix1[i] = 255
            else:
                pix2[i] = 0

    for i in range(width * height):

        p1 = pix1[i]
        p2 = pix2[i] * light

        a = 1 - p1 / 255.0 + p2 / 255.0
        r = round(p2 / a if not a == 0 else 255)

        pix3.append((r, r, r, int(a * 255)))

    im3.putdata(pix3)

    return im3


# https://zhuanlan.zhihu.com/p/32532733
def colorfulCar(whiteImg, blackImg, light, m_colorWhite, m_colorBlack):
    """发彩色车"""
    _im1 = whiteImg.convert('RGB')
    _im2 = blackImg.convert('RGB')

    _im2 = ImageEnhance.Brightness(_im2).enhance(light)

    # 将长宽提取提取出来, 提高后面访问的速度
    whiteWidth, whiteHeight = _im1.size
    blackWidth, blackHeight = _im2.size
    width = max(whiteWidth, blackWidth)
    height = max(whiteHeight, blackHeight)

    # 建立新的, 大小合适图片
    im3 = Image.new('RGBA', (width, height))
    im1 = Image.new('RGB', (width, height), (255, 255, 255))
    im2 = Image.new('RGB', (width, height), (0, 0, 0))

    # 将原图复制到新图像里面
    im1.paste(_im1, ((width - whiteWidth) // 2, (height - whiteHeight) // 2))
    im2.paste(_im2, ((width - blackWidth) // 2, (height - blackHeight) // 2))

    # 根据官方文档的说法, getpixel和putpixel效率太低, 换用getdata和putdata
    pix1 = im1.getdata()
    pix2 = im2.getdata()
    pix3 = []

    for i in range(width * height):

        r1, g1, b1 = [x / 255 for x in pix1[i]]
        r2, g2, b2 = [x / 255 for x in pix2[i]]

        gray1 = min((r1 * 0.334 + g1 * 0.333 + b1 * 0.333), 1)
        r1 = r1 * m_colorWhite + gray1 * (1 - m_colorWhite)
        g1 = g1 * m_colorWhite + gray1 * (1 - m_colorWhite)
        b1 = b1 * m_colorWhite + gray1 * (1 - m_colorWhite)
        # gray1 = min((r1 * 0.334 + g1 * 0.333 + b1 * 0.333), 1)

        gray2 = min((r2 * 0.334 + g2 * 0.333 + b2 * 0.333), 1)
        r2 = r2 * m_colorBlack + gray2 * (1 - m_colorBlack)
        g2 = g2 * m_colorBlack + gray2 * (1 - m_colorBlack)
        b2 = b2 * m_colorBlack + gray2 * (1 - m_colorBlack)
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

        pix3.append((round(r * 255), round(g * 255), round(b * 255), round(a * 255)))

    im3.putdata(pix3)

    return im3