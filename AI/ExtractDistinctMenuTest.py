#%%
import pandas as pd
import numpy as np

#%%
# 모든 부대 번호입니다.
unitNumbers = [1691, 2171, 3296, 3389, 5021, 5322, 6176, 6282, 6335, 7369, 7652, 8623, 8902, 9030]
unitNumbers

# %%
all_menu = pd.DataFrame()
for unit in unitNumbers:
    temp = pd.read_csv("Processed CSV Data Files(Attached Allergy)/제"+ str(unit) +"부대 메뉴정보.csv")
    all_menu = pd.concat([all_menu, temp])
all_menu

# %%
distinct_menu = all_menu.drop_duplicates(subset=['메뉴이름'])
distinct_menu

#%%
distinct_menu = distinct_menu[distinct_menu['메뉴이름'].notna()]
distinct_menu

#%%
# 불필요한 열을 삭제합니다.
distinct_menu = distinct_menu.iloc[ : , 2: ]
distinct_menu = distinct_menu.drop(['식사명', '날짜', '부대'], axis=1)
distinct_menu = distinct_menu.reset_index(drop=True)
distinct_menu

#%%
distinct_menu.to_csv("All Menu (Various Versions)/ 국방부메뉴_v1.0.csv")

# %%
