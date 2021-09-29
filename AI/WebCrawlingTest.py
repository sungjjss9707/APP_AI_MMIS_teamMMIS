#%%
import pandas as pd
import requests
from bs4 import BeautifulSoup

# %%
all_menu = pd.read_csv("All Menu (Various Versions)/ 국방부메뉴_v1.0.csv", index_col=0)
all_menu

#%%
urls = []
for name in all_menu['메뉴이름']:
    url = 'https://www.fatsecret.kr/%EC%B9%BC%EB%A1%9C%EB%A6%AC-%EC%98%81%EC%96%91%EC%86%8C/search?q=' + str(name)
    urls.append(url)
urls 

# %%
from concurrent.futures import ThreadPoolExecutor

def get_url(url):
    return requests.get(url)

with ThreadPoolExecutor(max_workers=10) as pool:
    response_list = list(pool.map(get_url,urls))

for response in response_list:
    print(response)

# %%
def get_link_from_response(response: str) -> str:
    soup = BeautifulSoup(response, 'lxml')
    table = soup.find("table", {"class": "generic searchResult"})
    if not table: return ""
    row = table.find('tr')
    link = row.find('a', href = True)
    link = 'https://www.fatsecret.kr' + link['href']
    return link

# %%
url = urls[0]
url

# %%
response = requests.get(url)
response

# %%
soup = BeautifulSoup(response.text, 'lxml')
soup

# %%
table = soup.find("table", {"class": "generic searchResult"})
# if not table: continue
table

# %%
row = table.find('tr')
row

# %%
link = row.find('a', href = True)
link = 'https://www.fatsecret.kr' + link['href']
link

# %%
response = requests.get(link)
soup = BeautifulSoup(response.content, 'lxml')
soup

# %%
section = soup.find("div", {"class": "nutrition_facts international"})
section

# %%
serving = section.find("div", {"class": "serving_size black serving_size_value"})
serving = serving.text
serving

# %%
nutrition_list1 = []
for value in section.find_all("div", {"class": "nutrient black right tRight"}):
    nutrition_list1.append(value.text)
nutrition_list1 = nutrition_list1[1:]
nutrition_list1

# %%
nutrition_list2 = []
for value in section.find_all("div", {"class": "nutrient right tRight"}):
    nutrition_list2.append(value.text)
del nutrition_list2[1]
nutrition_list2

# %%
nutrition_list = nutrition_list1 + nutrition_list2
nutrition_list.append(serving)
nutrition_list

# %%
nutrition_name = ["탄수화물", "단백질", "지방", "열량", "포화지방", "다불포화지방", "불포화지방", "콜레스테롤", "식이섬유", "나트륨", "칼륨", "기준양"]
nutrition_name

# %%
url = urls[0]
url

# %%
response = requests.get(url)
response

# %%
if response.status_code == 200:
    with open(str(all_menu['메뉴이름'][0]) + "_response.txt", "w") as file:
        file.write(response.text)

# %%
with open(str(all_menu['메뉴이름'][0]) + "_response.txt", "r") as file:
    response_text = file.read()
response_text

# %%
soup = BeautifulSoup(response_text, 'lxml')
soup

