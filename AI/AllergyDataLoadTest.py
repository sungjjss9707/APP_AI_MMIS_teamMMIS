#%%
#필요한 패키지를 불러옵니다
import pandas as pd
import numpy as np
from pandas.core.frame import DataFrame

#%%
# 데이터를 읽어옵니다
unitNum = 1691
data= pd.read_csv("Processed CSV Data Files/제" + str(unitNum) + "부대 메뉴정보.csv", encoding="UTF-8")
len(data)

# %%
#메뉴이름 알러지 정보 제거, 알러지 정보 배열 생성
allergyList=['계란류', '우유', '메밀', '땅콩', '대두', '밀', '고등어', '게', '새우', '돼지고기', '복숭아', '토마토', '아황산류', '호두', '닭고기', '쇠고기', '오징어', '조개류', '잣']
num = ['01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19']
allergyData = np.arange(20*6522).reshape(20, 6522)


for index, name in enumerate(data['메뉴이름']):

    for i in num:
        if i in name :
            allergyData[int(i)][index]=1
        else :
            allergyData[int(i)][index]=0


    if(name.find('(')==-1) : continue
    else :
        data['메뉴이름'][index] = name[:name.find('(')]
data['메뉴이름']
# %%
#알러지 정보 열 삽입

for i in num:
    index = int(i)
    data.insert(index+2, allergyList[index-1], allergyData[index])

data

# %%
