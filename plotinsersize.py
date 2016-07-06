#!/usr/bin/env python
# A script to aggregate insert size data from bbmap and plot it with pandas and matplotlib
# Adam Rivers 2016-05-19
import pandas
import os
import re

import matplotlib.pyplot as plt
import matplotlib
matplotlib.style.use('ggplot')
pandas.options.display.max_columns = 50

dir = "/global/projectb/scratch/arrivers/ss-dsPhageMapping/20160621/results"
dict = {}

for handle in os.listdir(dir):
	with open(os.path.join(dir,handle), "r") as file:
		dict[handle] = {}
		for line in file:
			if not re.match("#", line):
				ls = line.strip().split("\t")
				dict[handle][int(ls[0])] = int(ls[1])

df = pandas.DataFrame.from_dict(dict)
df.to_csv("20160621/insertsizes_by_sample.csv")
df2 = df.div(df.sum(axis=0), axis=1)
df3 = pandas.rolling_mean(df2, window=20)
plottedfig = df3.plot()
plottedfig.set_xlim(0,1000)
plt.savefig("20160621/insertsizes.pdf")
