import pandas as pd
import numpy as np
import datetime

ttc = pd.read_csv('delays.csv') 

ttc['date_object'] = [ datetime.datetime.strptime(a, '%Y/%m/%d') for a in ttc['Date'] ]
ttc['year'] = [ a.year for a in ttc['date_object'] ]
ttc['week'] = [ a.isocalendar()[1] for a in ttc['date_object'] ]

station_max_week = ttc.groupby( ['year', 'week', 'Station'] )['Min Delay'].max()
