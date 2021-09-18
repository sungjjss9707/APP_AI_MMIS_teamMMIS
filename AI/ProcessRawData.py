# 필요한 패키지를 불러옵니다.
import pandas as pd
import numpy as np

# 데이터를 읽어옵니다.
def load_data(unitNum: int) -> pd.DataFrame:
    return pd.read_csv("Raw CSV Data Files/제" + str(unitNum) + "부대 식단 정보_월별.csv", encoding="CP949")

# 데이터에서 필요한 데이터만 가져옵니다. 
def process_data(data: pd.DataFrame, unitNum: int) -> pd.DataFrame:
    # 데이터에 값이 아예 없는 열은 제외합니다.
    data = data.dropna(axis=1, how='all')
    # 증특식 열의 필요성을 못 느껴 제외합니다.
    data = data.drop('증특식', axis=1, errors='ignore')

    # 비어있는 날짜 값을 채워줍니다.
    for index, date in enumerate(data["날짜"]):
        if index == 0 or date is not np.NAN: continue
        data['날짜'][index] = data['날짜'][index-1]
    
    # 날짜가 비어있는 열은 제외합니다.
    data = data[data['날짜'].notna()]
    data = data.reset_index(drop=True)

    # 메뉴이름, 식사명, 열량, 날짜, 부대의 형태의 테이블로 변경합니다.
    processed_data = pd.DataFrame(columns=['메뉴이름', '식사명', '열량', '날짜', '부대'])
    for index, row in data.iterrows():
        processed_data.loc[index * 3] = [row['조식'], '조식', row['조식열량'], row['날짜'], unitNum]
        processed_data.loc[index * 3 + 1] = [row['중식'], '중식', row['중식열량'], row['날짜'], unitNum]
        processed_data.loc[index * 3 + 2] = [row['석식'], '석식', row['석식열량'], row['날짜'], unitNum]

    # 메뉴이름이 없는 열은 제외합니다.
    processed_data = processed_data[processed_data['메뉴이름'].notna()]
    processed_data = processed_data.reset_index(drop=True)
    return processed_data

# 처리된 데이터를 저장합니다.
def save_processed_data(processed_data: pd.DataFrame, csv_name: str):
    processed_data.to_csv("Processed CSV Data Files/" + csv_name + ".csv")



def main():
    # 모든 부대 번호입니다.
    unitNumbers = [1691, 2171, 3296, 3389, 5021, 5322, 6176, 6282, 6335, 7369, 7652, 8623, 8902, 9030]
    
    # 모든 부대의 식단 데이터에서 필요한 데이터만 가져옵니다.
    for unitNum in unitNumbers:
        data = load_data(unitNum)
        processed_data = process_data(data, unitNum)
        csv_name = "제" + str(unitNum) + "부대 메뉴정보"
        save_processed_data(processed_data, csv_name)

    return 0

if __name__ == "__main__":
    main()

