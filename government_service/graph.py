import sys, csv, json
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

def closest_point_y(line, y_find):
    for i, (x, y) in enumerate(line):
        if y == y_find:
            return x
        if y_find < y:
            x_prev, _ = line[i - 1]
            return (x + x_prev) / 2.0

brmas_out = {}

for brma in csv.DictReader(open('brma.csv')):
    brma_id = brma['BRMAno']

    print >> sys.stderr, brma['BRMAname']

    im = Image.open('graphs/BRMA_%s_beds_0.gif' % brma_id)
    pixels = im.load()
    width, height = im.size

    palette = list(chunks(im.getpalette(), 3))
    orange = palette.index([255, 102, 0])
    gray = palette.index([128, 128, 128])

    def is_x_axis(x):
        col = chunks([pixels[x,y] for y in xrange(height)], 10)
        return any(all(pixel == gray for pixel in col_chunk) for col_chunk in col)

    x_origin, x_end = [x for x in xrange(width) if is_x_axis(x)]

    line = []
    # get orange line, x shifted by x_origin and y inveresed
    for x in xrange(x_origin, x_end):
        for y in xrange(height):
            if pixels[x, y] == orange:
                line.append((x - x_origin, height - y))
                break

    x_first, y_first = line[0]
    x_last, y_last = line[-1]

    lha_rate = float(brma['LHArate'])
    min_rent_price = float(brma['minRent'])
    max_rent_price = float(brma['maxRent'])
    max_num_rents = float(brma['nRents'])

    x_step = max_num_rents / (x_last - x_first)
    y_step = (max_rent_price - min_rent_price) / (y_last - y_first)

    values = []
    for x in linspace(x_first, x_last, 100):
        y = closest_point(line, x)
        num_rents = x * x_step
        rent_price = round((y - y_first) * y_step + min_rent_price, 2)
        values.append((num_rents, rent_price))

    lha_x = closest_point_y(line, lha_rate / y_step)

    brmas_out[brma_id] = {
        'values': values,
        'lha_rate': [lha_x * x_step, lha_rate]
    }

print json.dumps(brmas_out)
