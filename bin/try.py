from typing import Dict
from variables import district

for k,v in district.items():
    for l,u in district[k].items():
        district[k][l].pop('name')
        
        for m,w in district[k][l].items():
            district[k][l][m]['name']=m
            district[k][l][m]['lat']=1
            district[k][l][m]['long']=1
            b:dict=district[k][l][m]
            #print(b)
        district[k][l]['name']=l
    district[k]['name']=k
            
print(district)