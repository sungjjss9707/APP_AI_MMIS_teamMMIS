# %%
import pandas as pd
import numpy as np

# %%
data = pd.read_csv("All Menu (Various Versions)/국방부메뉴_v2.0.csv", index_col=0)
data

# %%
# 기준열량을 활용하여 영양성분 값을 바꿀꺼여서 기준양은 삭제합니다.
data = data.drop(columns=['기준양'])
data

# %%
# 테스트 행을 삭제합니다.
data = data.drop(1412)
data = data.reset_index(drop=True)
data

# %%
# 열량 값이 없는 메뉴는 기준열량을 가져옵니다.
for index, row in data.iterrows():
    if row['열량'] is np.NAN:
        data['열량'][index] = row['기준열량']
data

# %%
# 열량 열도 int 타입으로 바꿔줍니다.
for index, row in data.iterrows():
    cal = str(row['열량'])
    if cal[-4:] == 'kcal': cal = cal[:-4]
    if cal[0] == '*': cal = cal[2:]
    if cal == '0': cal = row['기준열량']
    cal = cal.replace(',', '')
    data['열량'][index] = int(round(float(cal)))
data['열량'] = pd.to_numeric(data['열량'])
data
    
# %%
# 기준열량, 탄수화물, 지방, 단백질, 나트륨, 콜레스트롤 열을 다 int 타입으로 바꿔줍니다.
for index, row in data.iterrows():
    data['기준열량'][index] = row['기준열량'].replace(',', '')
    data['탄수화물'][index] = row['탄수화물'].replace('-', '0')
    data['지방'][index] = row['지방'].replace('-', '0')
    data['단백질'][index] = row['단백질'].replace('-', '0')
    data['나트륨'][index] = row['나트륨'].replace('-', '0')
    data['나트륨'][index] = row['나트륨'].replace(',', '')
    data['콜레스트롤'][index] = row['콜레스트롤'].replace('-', '0')
    data['콜레스트롤'][index] = row['콜레스트롤'].replace(',', '')
    if row['나트륨'] == '--': data['나트륨'][index] = '0'
    if row['콜레스트롤'] == '--': data['콜레스트롤'][index] = '0'
data['기준열량'] = pd.to_numeric(data['기준열량'])
data['탄수화물'] = pd.to_numeric(data['탄수화물'])
data['지방'] = pd.to_numeric(data['지방'])
data['단백질'] = pd.to_numeric(data['단백질'])
data['나트륨'] = pd.to_numeric(data['나트륨'])
data['콜레스트롤'] = pd.to_numeric(data['콜레스트롤'])
data

# %%
# 열량과 기준열량의 비율에 맞게 영양성분 값을 변경합니다.
columns = ['탄수화물', '지방', '단백질', '나트륨', '콜레스트롤']
for col in columns:
    data[col] = data['열량'] * data[col] / data['기준열량']
data

# %%
# 기준열량 열을 삭제합니다.
data = data.drop(columns=['기준열량'])
data

# %%
# 전처리가 완료된 테이블을 저장합니다.
data.to_csv("All Menu (Various Versions)/국방부메뉴_v2.1.csv")

# %%
