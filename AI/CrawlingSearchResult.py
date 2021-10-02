#%%
import pandas as pd
import requests
from bs4 import BeautifulSoup

# %%
# 데이터 불러오기
all_menu = pd.read_csv("All Menu (Various Versions)/국방부메뉴_v1.0.csv", index_col=0)
all_menu

# %%
# 정규 표현식을 통한 한글 외 문자 제거
all_menu['메뉴이름'] = all_menu['메뉴이름'].str.replace("[^ㄱ-ㅎㅏ-ㅣ가-힣 ]","")
all_menu

# %%
# 요청해야하는 URL주소를 가져옵니다.
urls = []
for name in all_menu['메뉴이름']:
    url = 'https://www.myfitnesspal.com/ko/food/search?page=1&search=' + str(name)
    urls.append(url)
urls

# %%
# 병렬로 10개씩 URL주소를 요청합니다.
from concurrent.futures import ThreadPoolExecutor

def get_url(url):
    return requests.get(url)

with ThreadPoolExecutor(max_workers=10) as pool:
    response_list = list(pool.map(get_url,urls))

# %%
# 메뉴이름의 검색결과를 정리해서 테이블로 반환합니다.
def create_search_result_df(response_content: str, index: int) -> pd.DataFrame:
    soup = BeautifulSoup(response_content, 'lxml')
    section = soup.find_all("div", {"class": "jss64"})
    search_result = pd.DataFrame(columns=['메뉴이름', '검색결과', 'URL'])
    for div in section:
        search_result = search_result.append({'메뉴이름': str(all_menu['메뉴이름'][index]), '검색결과': div.text, 'URL': div.find('a', href=True)['href']}, ignore_index=True)
    return search_result

#%%
# 모든 메뉴이름에 대하여 검색결과를 테이블에 정리합니다.
all_search_result = pd.DataFrame(columns=['메뉴이름', '검색결과', 'URL'])
for index, response in enumerate(response_list):
    df = create_search_result_df(response.content, index)
    all_search_result = pd.concat([all_search_result, df], ignore_index=True)
all_search_result

# %%
# 정리한 테이블을 CSV로 저장합니다.
all_search_result.to_csv("Web Crawling Data/메뉴검색결과.csv")