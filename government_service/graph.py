import sys
from PIL import Image

im = Image.open(sys.argv[1])
pixels = im.load()
width, height = im.size

def chunks(l, n):
    """Yield successive n-sized chunks from l."""
    for i in xrange(0, len(l), n):
        yield l[i:i + n]

palette = list(chunks(im.getpalette(), 3))
orange = palette.index([255, 102, 0])
gray = palette.index([128, 128, 128])

line = []

x_origin = 0
gray_count = 0

for x in xrange(720): # TODO: check limit
    for y in xrange(height):
        pixel = pixels[x, y]
        if pixel == orange:
            line.append((x, y))
            break

        if pixel == gray and x_origin == 0:
            gray_count += 1
            if gray_count > 3:
                x_origin = x
        else:
            gray_count = 0

first_point = line[0]
last_point = line[-1]

print (x_origin, first_point[1])
print last_point
