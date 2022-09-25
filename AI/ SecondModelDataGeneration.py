# %%
import pandas as pd
import requests
from bs4 import BeautifulSoup
from concurrent.futures import ThreadPoolExecutor

# %%
# 메뉴 데이터를 불러옵니다.
data = pd.read_csv("All Menu (Various Versions)/국방부메뉴_v2.1.csv", index_col=0)
data

# %%
# 요청해야하는 URL주소를 가져옵니다 (네이버).
urls = []
for name in data['메뉴이름']:
    url = 'https://search.naver.com/search.naver?sm=tab_hty.top&where=nexearch&query=' + str(name)
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
# 모든 요청이 정상적으로 실행되었는지 확인합니다.
count = 0
for response in response_list:
    if response.status_code != 200: count += 1
count

# %%
# 각 요청(메뉴)마다 메인에 있는 섹션의 개수를 계산합니다.
def get_number_of_sections(response_content: str) -> int:
    soup = BeautifulSoup(response_content, 'lxml')
    main = soup.find("div", {"class": "main_pack"})
    sections = main.find_all("section")
    return len(sections)

# %%
# 모든 요청의 섹션 개수를 가져오고 저장합니다. 
section_num = []
for response in response_list:
    num = get_number_of_sections(response.content)
    section_num.append(num)
section_num

# %%
# 섹션의 개수가 기준 맛 점수가 됩니다.
data['맛'] = section_num
data

# %%
# 맛 점수를 포함하여 데이터를 저장합니다.
data.to_csv("Second Model Data/국방부메뉴_v2.1_맛_점수_포함.csv")

# %%
# 모든 부대를 불러옵니다.
unitNumbers = [1691, 2171, 3296, 3389, 5021, 5322, 6176, 6282, 6335, 7369, 7652, 8623, 8902, 9030]
unitNumbers

# %%
def clean_data(unit: str) -> pd.DataFrame:
    # 데이터를 불러오고 필요한 열만 남깁니다
    data = pd.read_csv("Processed CSV Data Files(Attached Allergy)/제"+ unit +"부대 메뉴정보.csv", index_col=0)
    data = data[data['메뉴이름'].notna()]
    data = data.iloc[:, 1:]
    data = data.drop(columns=data.columns[2:22])
    data = data.reset_index(drop=True)
    # 정규 표현식을 통한 한글 외 문자 제거
    data['메뉴이름'] = data['메뉴이름'].str.replace("[^ㄱ-ㅎㅏ-ㅣ가-힣 ]","")
    return data

# %%
def get_url(url):
    return requests.get(url)

def get_responses(urls: list) -> list:
    # 병렬로 10개씩 URL주소를 요청합니다.
    with ThreadPoolExecutor(max_workers=10) as pool:
        response_list = list(pool.map(get_url,urls))
    # 모든 요청이 정상적으로 실행되었는지 확인합니다.
    for response in response_list:
        if response.status_code != 200: 
            print("문제 있음!")
            break
    return response_list

# %%
def get_scores_of_meals(response_list: list) -> list:
    # 모든 요청의 섹션 개수를 가져오고 저장합니다. 
    section_num = []
    for response in response_list:
        num = get_number_of_sections(response.content)
        section_num.append(num)
    return section_num

# %%
def generate_combination_score(unit: str) -> pd.DataFrame:
    data = clean_data(unit)
    # 식사명과 날짜에 맞추어 정렬합니다.
    sorted_data = data.sort_values(['식사명', '날짜'])
    sorted_data = pd.DataFrame(sorted_data)
    # 각 식사명과 날짜마다 몇개의 메뉴가 있는지 계산합니다.
    number_of_menus = sorted_data.groupby(['식사명', '날짜']).count()['메뉴이름']
    number_of_menus = number_of_menus.to_list()
    # 식사명과 날짜로 군집화하고 한 끼니의 모든 메뉴를 한 값으로 저장합니다.
    meals = data.groupby(['식사명', '날짜'])['메뉴이름'].apply(lambda x: "%s" % ' '.join(x))
    meals = pd.DataFrame(meals)
    print(unit + ": 군집화 완료")

    # 요청해야하는 URL주소를 가져옵니다 (네이버).
    urls = []
    for meal in meals['메뉴이름']:
        url = 'https://search.naver.com/search.naver?sm=tab_hty.top&where=nexearch&query=' + str(meal)
        urls.append(url)
    response_list = get_responses(urls)
    section_num = get_scores_of_meals(response_list)
    print(unit + ": 페이지 요청 완료")

    # 한 끼니 종합점수를 새로운 열로 추가합니다.
    meals['종합점수'] = section_num
    meals = meals.reset_index()
    meals.rename(columns = {"메뉴이름": "한끼니"}, inplace = True)
    # 각 메뉴마다 종합점수를 추가합니다.
    menu_with_score = pd.merge(sorted_data, meals, on=['식사명', '날짜'])
    
    # 각 메뉴마다 다른 메뉴와의 조합점수를 계산합니다.
    combination_score = pd.DataFrame(columns=['메뉴이름', '다른메뉴', '조합점수'])
    start_index = 0
    cs_index = 0
    for num in number_of_menus:
        partition = menu_with_score.iloc[start_index: start_index + num, :]
        partition = partition.reset_index(drop=True)
        for i in range(len(partition)):
            menu = str(partition['메뉴이름'][i])
            for j in range(len(partition)):
                if i == j: continue
                another = str(partition['메뉴이름'][j])
                score = partition['종합점수'][i]
                combination_score.loc[cs_index] = [menu, another, score]
                cs_index += 1
        start_index += num
    print(unit + ": 다른메뉴와의 조합점수 계산 완료")

    # 복수 중복된 행은 평균을 구한 후 리턴합니다.
    return combination_score.groupby(['메뉴이름', '다른메뉴'], as_index=False).mean()


# %%
# 하나씩 조합점수를 생성합니다.
unit = unitNumbers[13]
df = generate_combination_score(str(unit))
df.to_csv("Second Model Data/제" + str(unit) + "부대_메뉴_조합점수.csv")

# %%
# 모든 부대의 메뉴마다의 조합점수를 생성합니다.
for unit in unitNumbers:
    df = generate_combination_score(str(unit))
    df.to_csv("Second Model Data/제" + str(unit) + "부대_메뉴_조합점수.csv")
    
# %%

