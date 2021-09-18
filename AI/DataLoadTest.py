#%%
# 필요한 패키지를 불러옵니다.
import pandas as pd
import numpy as np

# %%
# 데이터를 읽어옵니다.
data = pd.read_csv("제7652부대 식단 정보_월별.csv", encoding="CP949")
data

#%%
# 데이터를 다 보고 싶으면
with pd.option_context('display.max_rows', None, 'display.max_columns', None):
    print(data)

# %%
# 데이터에 값이 아예 없는 열은 제외합니다.
for column in data:
    if data[column].count() == 0:
        data = data.drop(column, axis=1)
data

# %%
# 비어있는 날짜 값을 채워줍니다.
''''기본 데이터는 하나의 행에만 날짜가 입력되어 있고 그 다음 행에는 날짜가 비어있습니다.'''
for index, date in enumerate(data["날짜"]):
    if index == 0 or date is not np.NAN: continue
    data['날짜'][index] = data['날짜'][index-1]
data

# %%
# 날짜가 비어있는 열은 제외합니다.
for index, row in data.iterrows():
    if row['날짜'] is np.NAN:
        data = data.drop([index], axis=0)
data

# %%


# %%


#%%

