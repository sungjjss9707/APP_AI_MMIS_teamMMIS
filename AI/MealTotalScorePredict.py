# %%
import pandas as pd
import numpy as np

# %%
# 모든 부대를 불러옵니다.
unitNumbers = [1691, 2171, 3296, 3389, 5021, 5322, 6176, 6282, 6335, 7369, 7652, 8623, 8902, 9030]
unitNumbers

# %%
menu_correlation = pd.DataFrame()
for unit in unitNumbers:
    temp = pd.read_csv("Second Model Data/제"+ str(unit) +"부대_메뉴_조합점수.csv", index_col=0)
    menu_correlation = pd.concat([menu_correlation, temp])
menu_correlation

# %%
distinct_correlation = menu_correlation.groupby(['메뉴이름', '다른메뉴'], as_index=False).mean()
distinct_correlation = distinct_correlation[distinct_correlation['메뉴이름'] != distinct_correlation['다른메뉴']]
distinct_correlation = distinct_correlation.reset_index(drop=True)
distinct_correlation

# %%
menus = pd.read_csv("Second Model Data/국방부메뉴_v2.1_맛_점수_포함.csv", index_col=0)
menus

# %%
menus.loc[menus['메뉴이름'] == '가공우유']

# %%
main_menu_data = pd.DataFrame()
another_menu_data = pd.DataFrame()
for index, row in distinct_correlation.iterrows():
    main_temp = menus.loc[menus['메뉴이름'] == str(row['메뉴이름'])]
    main_menu_data = pd.concat([main_menu_data, main_temp], ignore_index = True, axis = 0)
    another_temp = menus.loc[menus['메뉴이름'] == str(row['다른메뉴'])]
    another_menu_data = pd.concat([another_menu_data, another_temp], ignore_index = True, axis = 0)

# %%
main_menu_data.to_csv("Second Model Data/메인메뉴데이터.csv")

# %%
another_menu_data.to_csv("Second Model Data/다른메뉴데이터.csv")

# %%
main_menu_data = pd.read_csv("Second Model Data/메인메뉴데이터.csv", index_col=0)
another_menu_data = pd.read_csv("Second Model Data/다른메뉴데이터.csv", index_col=0)

# %%
pd.merge(left=distinct_correlation, right=main_menu_data, how="left", on="메뉴이름")

# %%
another_menu_data

# %%
