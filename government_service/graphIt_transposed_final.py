import sys, csv, json
from PIL import Image

def chunks(l, n):
    """Yield successive n-sized chunks from l."""
    for i in range(0, len(l), n):
        yield l[i:i + n]

def linspace(low, up, leng):
    step = (up-low) * 1.0 / (leng - 1)
    return [round(low+i*step, 10) for i in range(leng)] # quick fix for rounding error. Otherwise try Decimal()

def closest_point(line, x_find):
    for i, (x, y) in enumerate(line):
        if x == x_find:
            return y
        if x_find < x:
            _, y_prev = line[i - 1]
            return (y + y_prev) / 2.0 # what if x_find > x ?

def closest_point_y(line, y_find):
    for i, (x, y) in enumerate(line):
        if y == y_find:
            return x
        if y_find < y:
            x_prev, _ = line[i - 1]
            return (x + x_prev) / 2.0

brmas_out = []
x_header = ["percentile \ BRMA", 'BRMAname', 'nRents', 'LHArate', 'affPercent'] + list(range(1, 101))

brmas_out.append(x_header)

for brma in csv.DictReader(open('brma.csv')): # set to brma_test.csv to go straight to Plymouth (BRMA 4)
    brma_id = int(brma['BRMAno'])

    print(brma['BRMAname'], end = "", file = sys.stderr)

    try:
        im = Image.open('graphs/BRMA_%s_beds_0.gif' % brma_id) # change to property size
    except:
        brmas_out.append([brma_id] + [None] * 104)
        continue
    pixels = im.load()
    width, height = im.size

    palette = list(chunks(im.getpalette(), 3))
    orange = palette.index([255, 102, 0])
    gray = palette.index([128, 128, 128])

    def is_x_axis(x):
        col = chunks([pixels[x,y] for y in range(height)], 10)
        return any(all(pixel == gray for pixel in col_chunk) for col_chunk in col)

    x_origin, x_end = [x for x in range(width) if is_x_axis(x)]
    x_mid = x_origin + 10
    # x_mid = int((x_origin + x_end) / 2)

    line = []
    # raw_line = [] # for debugging
    # get orange line, x shifted by x_origin and y inveresed
    for x in range(x_origin, x_mid):
        for y in range(height - 1, 0, -1): # this goes from bottom to top
            if pixels[x, y] == orange:
                line.append((x - x_origin, height - y)) # +1 to adjust for width of line (3px when horizontal)?
                # you can set this +1, and -1 below to aim for middle of 3px line
                # setting it to +2, -0 - aims for the top of the line. Makes no difference!
                # raw_line.append((x, y)) # for debugging
                break
    for x in range(x_mid, x_end):
        for y in range(height): # this goes from top to bottom of image
            if pixels[x, y] == orange:
                line.append((x - x_origin, height - y)) # -1 to adjust for width of line (3px when horizontal)?
                # raw_line.append((x, y)) # for debugging
                break # cycles through every x but stops at first y.


    x_min, y_min = line[0]
    x_max, y_max = line[-1]

    # print(raw_line) # for debugging

    lha_rate = float(brma['LHArate'])
    min_rent_price = float(brma['minRent'])
    max_rent_price = float(brma['maxRent'])
    max_num_rents = float(brma['nRents'])

    x_step = max_num_rents / (x_max - x_min)
    y_step = (max_rent_price - min_rent_price) / (y_max - y_min)

    values = []
    for x in linspace(x_min, x_max, 100):
        y = closest_point(line, x)
        num_rents = x * x_step
        rent_price = round((y - y_min) * y_step + min_rent_price, 2)
        values.append(rent_price)
    values = sorted(values) # actually assigns points on line to values
    
    lha_x = closest_point_y(line, (lha_rate - min_rent_price) * y_step + y_min) # is this for the graph??

    final_values = [brma_id, brma['BRMAname'], int(brma['nRents']), float(brma['LHArate']), -1] + values

    #brmas_out[brma_id] = values
    brmas_out.append(final_values)

n_brmas = len(brmas_out)
n_percentiles = len(brmas_out[0])

for i in range(1, n_brmas):
    if brmas_out[i][3] is None:
            brmas_out[i][4] = None
            continue
    for j in range(5, 105):
        if brmas_out[i][3] < brmas_out[i][j]:
            brmas_out[i][4] = j-5
            break

brmas_transposed = []
temp_list = []
for i in range(0, n_percentiles):
    for j in range(0, n_brmas):
        temp_list.append(brmas_out[j][i])
    brmas_transposed.append(temp_list)
    temp_list = []

with open("brma_transposed_0_beds.csv", "w", newline = "") as outFile: # change to match property size
    writer = csv.writer(outFile)
    writer.writerows(brmas_transposed)

#with open("brma_test.json", "w") as outFile:
#    json.dump(brmas_out, outFile)

