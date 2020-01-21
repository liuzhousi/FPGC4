from PIL import Image
from math import sqrt

COLORS = [
(5, 6, 10),
(17, 6, 87),
(26, 1, 205),
(26, 1, 214),
(33, 113, 68),
(36, 114, 111),
(39, 100, 227),
(45, 95, 255),
(19, 57, 43),
(22, 48, 128),
(35, 23, 253),
(43, 38, 255),
(65, 214, 124),
(61, 217, 150),
(61, 209, 245),
(72, 207, 255),
(17, 36, 42),
(27, 16, 162),
(38, 5, 255),
(36, 20, 255),
(57, 204, 119),
(54, 202, 158),
(51, 179, 255),
(59, 180, 255),
(32, 121, 74),
(33, 116, 145),
(43, 78, 255),
(46, 84, 255),
(79, 238, 140),
(74, 235, 156),
(61, 216, 222),
(68, 204, 255),
(110, 31, 36),
(109, 30, 108),
(105, 26, 237),
(102, 12, 252),
(97, 105, 67),
(90, 98, 101),
(83, 84, 197),
(85, 59, 255),
(82, 38, 30),
(85, 39, 84),
(84, 37, 195),
(85, 28, 246),
(84, 165, 100),
(88, 175, 122),
(78, 172, 202),
(81, 157, 255),
(108, 35, 37),
(116, 33, 114),
(115, 34, 249),
(121, 29, 255),
(107, 172, 102),
(106, 176, 134),
(97, 161, 251),
(104, 172, 255),
(130, 111, 77),
(126, 107, 136),
(120, 93, 255),
(117, 107, 255),
(120, 242, 152),
(118, 244, 168),
(116, 236, 231),
(114, 230, 255),
(67, 27, 42),
(64, 23, 151),
(70, 1, 255),
(65, 1, 255),
(55, 135, 81),
(51, 128, 126),
(50, 98, 246),
(52, 82, 255),
(46, 51, 44),
(41, 42, 105),
(49, 21, 225),
(50, 21, 255),
(54, 174, 104),
(55, 168, 120),
(49, 147, 198),
(53, 115, 255),
(35, 16, 19),
(37, 17, 81),
(47, 3, 202),
(50, 4, 232),
(47, 136, 81),
(47, 146, 117),
(45, 137, 213),
(57, 123, 255),
(48, 94, 62),
(44, 93, 114),
(48, 64, 246),
(56, 68, 255),
(81, 235, 140),
(76, 236, 155),
(75, 230, 228),
(92, 227, 255),
(203, 53, 44),
(213, 52, 134),
(203, 66, 255),
(196, 83, 255),
(207, 137, 88),
(209, 135, 127),
(188, 124, 255),
(171, 140, 255),
(215, 74, 53),
(208, 67, 117),
(192, 70, 252),
(176, 82, 255),
(168, 189, 115),
(158, 183, 128),
(145, 174, 213),
(133, 150, 255),
(170, 46, 37),
(172, 42, 101),
(154, 48, 212),
(155, 53, 252),
(143, 126, 80),
(130, 114, 93),
(130, 114, 179),
(123, 95, 255),
(136, 66, 43),
(134, 62, 74),
(131, 64, 173),
(136, 67, 254),
(135, 187, 112),
(132, 186, 123),
(130, 188, 195),
(125, 184, 255)
]

def closest_color(rgb):
    r, g, b = rgb
    color_diffs = []
    for color in COLORS:
        cr, cg, cb = color
        color_diff = sqrt(abs(r - cr)**2 + abs(g - cg)**2 + abs(b - cb)**2)
        color_diffs.append((color_diff, color))
    return min(color_diffs)[1]

def createPalette(color):
    if color[3] == 0:
        return "00000000"
    else:
        bestColor = closest_color((color[0], color[1], color[2]))
        colorID = COLORS.index(bestColor)
        colorString = format(colorID, '08b')

        print()
        print(color)
        print(bestColor)
        print(colorID)
        
        return colorString

#img: image to process
#x: starting x position
#y: starting y position
#idx: index of pattern table, corresponding to index of tiles
def createPattern(img, x, y, idx):
    tile = []
    for a in range(8):
        tileLine = []
        for b in range(8):
            pixel = px[x*8+b, y*8+a]
            tileLine.append(pixel)
        tile.append(tileLine)

    colorList = []

    for a in range(8):
        for b in range(8):
            if tile[a][b] not in colorList:
                colorList.append(tile[a][b])

    if len(colorList) > 4:
        print("tile ", idx, " has more than 4 colors")

    paletteList = []

    for i in range(4):
        if i < len(colorList):
            paletteList.append(createPalette(colorList[i]))

    paletteString = "".join(paletteList)

    print (paletteString.ljust(32, "0"), " ;", idx)




    


im = Image.open('tiles.png')
width, height = im.size
px = im.load()

#print(px[0,0])
print("Width:", width, "px")
print("Height:", height, "px")

if (width%8 != 0):
    print("Width not dividable by 8")
    exit(1)

if (height%8 != 0):
    print("Height not dividable by 8")
    exit(1)

htiles = int(width / 8)
vtiles = int(height / 8)
tiles = htiles * vtiles

print("Horizontal tiles:", htiles)
print("Vertical tiles:", vtiles)
print("Total number of tiles:", tiles)

print("Index of tiles:")
tile_i = 0
for y in range(vtiles):
    for x in range(htiles):
        print (str(tile_i) + "\t", end = '')
        tile_i = tile_i + 1
        #function: create pattern of tile
    print()

print()
print()

tile_i = 0
for y in range(vtiles):
    for x in range(htiles):
        #createPattern(px, x, y, tile_i)
        tile_i = tile_i + 1
        
createPattern(px, 0, 0, 0)

"""
def readChar(startx, starty):
    for y in range (8):
        for x in range (8):
            r, g, b = (px[startx*8 + x, starty*8 + y])
            if r == 0 and g == 0 and b == 0:
                print("00", end = '')
            if r == 0 and g == 255 and b == 0:
                print("01", end = '')
            if r == 255 and g == 0 and b == 0:
                print("10", end = '')
            if r == 255 and g == 255 and b == 255:
                print("11", end = '')
        if y % 1 == 0:
            print()


readChar(0, 0)
"""