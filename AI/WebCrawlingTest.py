#%%
import pandas as pd
from pandas.core.frame import DataFrame
import requests
from bs4 import BeautifulSoup
import Levenshtein as lev

# %%
# 검색 결과 불러오기
search_result = pd.read_csv("Web Crawling Data/메뉴검색결과.csv", index_col=0)
search_result

# %%
# 정규 표현식을 통한 한글 외 문자 제거
search_result['검색결과'] = search_result['검색결과'].str.replace("[^ㄱ-ㅎㅏ-ㅣ가-힣 ]","")
search_result

# %%
# Levenshtein 거리를 사용하여 단어 두개의 비슷함을 측정하여 테이블에 추가합니다.
lev_ratio = []
for index, row in search_result.iterrows():
    lev_ratio.append(lev.ratio(str(row['메뉴이름']), str(row['검색결과'])))
search_result['Lev Ratio'] = lev_ratio
search_result

# %%
# 메뉴이름마다 Levenshtein 값이 가장 높은 행를 가져옵니다.
idx = search_result.groupby(['메뉴이름'])['Lev Ratio'].transform(max) == search_result['Lev Ratio']
info_data = search_result[idx]
info_data = info_data.drop_duplicates(subset=['메뉴이름'], keep='first')
info_data = info_data.reset_index(drop=True)
info_data

# %%
# 요청해야하는 URL주소를 가져옵니다.
urls = []
for part_url in info_data['URL']:
    full_url = 'https://www.myfitnesspal.com' + str(part_url)
    urls.append(full_url)
urls

# %%
# 병렬로 10개씩 URL주소를 요청합니다.
from concurrent.futures import ThreadPoolExecutor

def get_url(url):
    return requests.get(url)

with ThreadPoolExecutor(max_workers=10) as pool:
    response_list = list(pool.map(get_url,urls))

# %%
# 영양성분 정보를 가져옵니다.
def get_nutrition_value(response_content: str) -> list:
    soup = BeautifulSoup(response_content, 'lxml')
    # 기준양 (그램)
    quantity = soup.find("div", {"class": "MuiSelect-root MuiSelect-select MuiSelect-selectMenu MuiInputBase-input MuiInput-input"})
    quantity = quantity.text
    # 열량
    calorie = soup.find("span", {"class": "title-cgZqW"})
    calorie = calorie.text
    # 탄수화물, 지방, 단백질
    carb_fat_protein = soup.find_all("span", {"class": "title-1P2uF"})
    carb = carb_fat_protein[0].text
    carb = carb[:-1]
    fat = carb_fat_protein[1].text
    fat = fat[:-1]
    protein = carb_fat_protein[2].text
    protein = protein[:-1]
    # 나트륨, 콜레스트롤
    sodium_cholesterol = soup.find_all("div", {"class": "subtext-2_Vtc"})
    sodium = sodium_cholesterol[2].text
    sodium = sodium.split()[0]
    cholesterol = sodium_cholesterol[3].text
    cholesterol = cholesterol.split()[0]
    # 리스트의 형태로 반환합니다.
    return [quantity, calorie, carb, fat, protein, sodium, cholesterol]

# %%
# 모든 메뉴의 영양성분 정보를 가져옵니다.
nutrition_value = pd.DataFrame(columns=['메뉴이름', '기준양', '기준열량', '탄수화물', '지방', '단백질', '나트륨', '콜레스트롤'])
for index, response in enumerate(response_list):
    nutritions = get_nutrition_value(response.content)
    nutritions.insert(0, info_data['메뉴이름'][index])
    nutrition_value = nutrition_value.append(pd.Series(nutritions, index=nutrition_value.columns), ignore_index=True)
nutrition_value

# %%
# 현재 메뉴 정보 테이블를 가져옵니다.
all_menu = pd.read_csv("All Menu (Various Versions)/국방부메뉴_v1.0.csv", index_col=0)
all_menu

# %%
# 정규 표현식을 통한 한글 외 문자 제거
all_menu['메뉴이름'] = all_menu['메뉴이름'].str.replace("[^ㄱ-ㅎㅏ-ㅣ가-힣 ]","")
all_menu

# %%
# 영양성분을 테이블에 더해줍니다
all_menu_with_nutrition = all_menu.merge(nutrition_value, how = 'inner', on = ['메뉴이름'])
all_menu_with_nutrition

# %%
# 중복을 제외하고 순번을 재정렬합니다.
all_menu_with_nutrition = all_menu_with_nutrition.drop_duplicates(subset=['메뉴이름'], keep='first')
all_menu_with_nutrition = all_menu_with_nutrition.reset_index(drop=True)
all_menu_with_nutrition

# %%
# 영양성분을 합한 테이블을 저장합니다.
all_menu_with_nutrition.to_csv("All Menu (Various Versions)/국방부메뉴_v2.0.csv")

# %%
