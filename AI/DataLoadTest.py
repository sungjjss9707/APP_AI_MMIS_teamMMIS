#%%
# 필요한 패키지를 불러옵니다.
import pandas as pd
import numpy as np

# %%
# 데이터를 읽어옵니다.
unitNum = 7652
data = pd.read_csv("Raw CSV Data Files/제" + str(unitNum) + "부대 식단 정보_월별.csv", encoding="CP949")
data

#%%
# 데이터를 다 보고 싶으면
with pd.option_context('display.max_rows', None, 'display.max_columns', None):
    print(data)

# %%
# 데이터에 값이 아예 없는 열은 제외합니다.
data = data.dropna(axis=1, how='all')
data

#%%
# 증특식 열의 필요성을 못 느껴 제외합니다.
data = data.drop('증특식', axis=1)
data

# %%
# 비어있는 날짜 값을 채워줍니다.
''''기본 데이터는 하나의 행에만 날짜가 입력되어 있고 그 다음 행에는 날짜가 비어있습니다.'''
for index, date in enumerate(data["날짜"]):
    if index == 0 or date is not np.NAN: continue
    data['날짜'][index] = data['날짜'][index-1]
data

# %%
# 날짜가 비어있는 행은 제외합니다.
data = data[data['날짜'].notna()]
data = data.reset_index(drop=True)
data

# %%
# 메뉴이름, 식사명, 열량, 날짜, 부대의 형태의 테이블로 변경합니다.
processed_data = pd.DataFrame(columns=['메뉴이름', '식사명', '열량', '날짜', '부대'])
for index, row in data.iterrows():
    processed_data.loc[index * 3] = [row['조식'], '조식', row['조식열량'], row['날짜'], unitNum]
    processed_data.loc[index * 3 + 1] = [row['중식'], '중식', row['중식열량'], row['날짜'], unitNum]
    processed_data.loc[index * 3 + 2] = [row['석식'], '석식', row['석식열량'], row['날짜'], unitNum]
processed_data

# %%
# 메뉴이름이 없는 열은 제외합니다.
processed_data = processed_data[processed_data['메뉴이름'].notna()]
processed_data = processed_data.reset_index(drop=True)
processed_data
