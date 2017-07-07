Extracts rental information from graph images.

You will need the (http://www.pythonware.com/products/pil/)[Python Imaging Library]


```
python graphs.py > data.json
```

graphIt_transposed_final.py is a tweaked version - slightly different calibration (so the points are a bit different), transposes the output and sends to csv instead of json. (This is basically designed to store the data offline rather than integrate it into an online app.) Also - this version is in Python 3 instead of Python 2.

***

You can download updated graphs and an updated index file (brma.csv) using homeless_hack_scrape_VOA.R. (You can also download the same information for different property sizes.) The script requires an R installation with the following packages: rvest, dplyr. Edits to the script are required - these are labelled in comments.
