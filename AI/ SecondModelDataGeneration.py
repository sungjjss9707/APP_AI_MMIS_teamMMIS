# %%
import pandas as pd
import random

# %%
# 모든 부대를 불러옵니다.
unitNumbers = [1691, 2171, 3296, 3389, 5021, 5322, 6176, 6282, 6335, 7369, 7652, 8623, 8902, 9030]
unitNumbers

# %%
# 각 부대마다 랜덤한 설문조사 점수를 부여합니다.
def generate_random_score(unit: str) -> pd.DataFrame:
    # 데이터를 불러오고 필요한 열만 남깁니다.
    data = pd.read_csv("Processed CSV Data Files(Attached Allergy)/제"+ unit +"부대 메뉴정보.csv", index_col=0)
    data = data.iloc[:, 1:]
    data = data.drop(columns=data.columns[2:22])
    # 정규 표현식을 통한 한글 외 문자 제거
    data['메뉴이름'] = data['메뉴이름'].str.replace("[^ㄱ-ㅎㅏ-ㅣ가-힣 ]","")
    # 각 메뉴이름마다 맛, 양, 빈도에 대한 점수를 랜덤하게 생성합니다.
    taste = []
    size = []
    frequency = []
    for i in range(len(data)):
        taste.append(random.randint(0, 5))
        size.append(random.randint(0, 5))
        frequency.append(random.randint(0, 5))
    # 새로운 열로 적용합니다.
    data['맛'] = taste
    data['양'] = size
    data['빈도'] = frequency
    
    # 식사명과 날짜에 맞추어 정렬합니다.
    sorted_data = data.sort_values(['식사명', '날짜'])
    sorted_data = pd.DataFrame(sorted_data)
    # 각 식사명과 날짜마다 몇개의 메뉴가 있는지 계산합니다.
    number_of_menus = sorted_data.groupby(['식사명', '날짜']).count()['메뉴이름']
    number_of_menus = number_of_menus.to_list()
    # 각 끼니마다의 종합점수를 랜덤으로 생성합니다.
    total_score = []
    for num in number_of_menus:
        score = random.randint(0, 5)
        for i in range(num):
            total_score.append(score)
    sorted_data['종합점수'] = total_score
    return sorted_data

# %%
all_menu = pd.DataFrame()
for unit in unitNumbers:
    temp = generate_random_score(str(unit))
    all_menu = pd.concat([all_menu, temp])
all_menu

# %%
data = pd.read_csv("Processed CSV Data Files(Attached Allergy)/제"+ str(unitNumbers[0]) +"부대 메뉴정보.csv", index_col=0)
data = data.iloc[:, 1:]
data = data.drop(columns=data.columns[2:22])
data

# %%
# 정규 표현식을 통한 한글 외 문자 제거
data['메뉴이름'] = data['메뉴이름'].str.replace("[^ㄱ-ㅎㅏ-ㅣ가-힣 ]","")
data

# %%
taste = []
size = []
frequency = []
for i in range(len(data)):
    taste.append(random.randint(0, 5))
    size.append(random.randint(0, 5))
    frequency.append(random.randint(0, 5))

# %%
data['맛'] = taste
data['양'] = size
data['빈도'] = frequency
data

# %%
sorted_data = data.sort_values(['식사명', '날짜'])
sorted_data = pd.DataFrame(sorted_data)
sorted_data

# %%
number_of_menus = sorted_data.groupby(['식사명', '날짜']).count()['메뉴이름']
number_of_menus = number_of_menus.to_list()
number_of_menus

# %%
total_score = []
for num in number_of_menus:
    score = random.randint(0, 5)
    for i in range(num):
        total_score.append(score)
total_score

# %%
sorted_data['종합점수'] = total_score
sorted_data

# %%


# %%
# 데이터를 다 보고 싶으면
with pd.option_context('display.max_rows', None, 'display.max_columns', None):
    print(sorted_data)

# %%
