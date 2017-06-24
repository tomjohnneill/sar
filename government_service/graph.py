import sys, csv
from PIL import Image

def chunks(l, n):
    """Yield successive n-sized chunks from l."""
    for i in xrange(0, len(l), n):
        yield l[i:i + n]

def linspace(low, up, leng):
    step = (up-low) * 1.0 / (leng - 1)
    return [low+i*step for i in xrange(leng)]

def closest_point(line, x_find):
    for i, (x, y) in enumerate(line):
        if x == x_find:
            return y
        if x_find < x:
            _, y_prev = line[i - 1]
            return (y + y_prev) / 2.0

brmas = {row['BRMAno']: row for row in csv.DictReader(open('brma.csv'))}

for brma_id in sys.argv[1:]:
    brma = brmas[brma_id]

    im = Image.open('graphs/BRMA_%s_beds_0.gif' % brma_id)
    pixels = im.load()
    width, height = im.size

    palette = list(chunks(im.getpalette(), 3))
    orange = palette.index([255, 102, 0])
    gray = palette.index([128, 128, 128])

    def is_x_axis(x):
        col = chunks([pixels[x,y] for y in xrange(height)], 10)
        return any(all(pixel == gray for pixel in col_chunk) for col_chunk in col)

    x_origin, x_last = [x for x in xrange(width) if is_x_axis(x)]

    line = []
    # get orange line, x shifted by x_origin and y inveresed
    for x in xrange(x_last):
        for y in xrange(height):
            if pixels[x, y] == orange:
                line.append((x - x_origin, height - y))
                break

    x_first, y_first = line[0]
    x_last, y_last = line[-1]

    x_range = x_last - x_first
    y_range = y_last - y_first

    min_rent = float(brma['minRent'])
    max_rent = float(brma['maxRent'])
    num_rents = float(brma['nRents'])

    x_step = num_rents / x_range
    y_step = (max_rent - min_rent) / y_range

    for x in linspace(x_first, x_last, 100):
        y = closest_point(line, x)
        print x * x_step, (y - y_first) * y_step + min_rent
