# %%
import pandas as pd
import requests
import time
from bs4 import BeautifulSoup
from concurrent.futures import ThreadPoolExecutor

# %%
# 모든 메뉴 데이터를 불러옵니다.
all_menu = pd.read_csv("All Menu (Various Versions)/ 국방부메뉴_v1.0.csv", index_col=0)
all_menu

# %%
# 병렬로 사이트를 처리하기 위하여 URL 리스트를 만듭니다.
urls = []
for name in all_menu['메뉴이름']:
    url = 'https://www.fatsecret.kr/%EC%B9%BC%EB%A1%9C%EB%A6%AC-%EC%98%81%EC%96%91%EC%86%8C/search?q=' + str(name)
    urls.append(url)
len(urls)

# %%
# URL에서 HTML 파일을 읽어옵니다.
# def get_url(url):
#     return requests.get(url)
def get_url(url):
    response = requests.get(url)
    if response.status_code == 200:
        return response
    else:
        time.sleep(10)
        return get_url(url)
        
# %%
# 한번에 10사이트씩 요청합니다.
with ThreadPoolExecutor(max_workers=10) as pool:
    response_list = list(pool.map(get_url,urls))
len(response_list)

# %%
def get_info_url(response: str) -> str:
    soup = BeautifulSoup(response, 'lxml')
    table = soup.find("table", {"class": "generic searchResult"})
    if not table: return ""
    row = table.find('tr')
    url = row.find('a', href = True)
    url = 'https://www.fatsecret.kr' + url['href']
    return url

# %%
count = 0
for response in response_list:
    if response.status_code == 200:
        count += 1
count

# %%
urls = []
with open("Info_HTML_URL.txt", "w") as file:
    for response in response_list:
        url = get_info_url(response.text)
        urls.append(url)
        file.write(url)
urls
