#필요한 패키지를 불러옵니다
import pandas as pd
import numpy as np
from pandas.core.frame import DataFrame

# 데이터를 읽어옵니다
def load_data(unitNum: int) -> pd.DataFrame:
    return pd.read_csv("Processed CSV Data Files/제" + str(unitNum) + "부대 메뉴정보.csv", encoding="UTF-8")
    
# 알레르기 유발물질 배열, 표기숫자 배열

allergyList=['계란류', '우유', '메밀', '땅콩', '대두', '밀', '고등어', '게', '새우', '돼지고기', '복숭아', '토마토', '아황산류', '호두', '닭고기', '쇠고기', '오징어', '조개류', '잣']
num = ['01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19']

# 메뉴이름에서 알러지 정보 제거, 알러지 정보 배열 생성, 알러지 정보 열 삽입

def process_data(data: pd.DataFrame)->pd.DataFrame:

    allergyData = np.arange(20*len(data)).reshape(20, len(data))
    
    for index, name in enumerate(data['메뉴이름']):
        for i in num:
            if i in name :
                allergyData[int(i)][index]=1
            else :
                allergyData[int(i)][index]=0


        if(name.find('(')==-1) : continue
        else :
            data['메뉴이름'][index] = name[:name.find('(')]
        
    for i in num:
            index = int(i)
            data.insert(index+2, allergyList[index-1], allergyData[index])
    return data

#데이터 저장
def save_processed_data(processed_data: pd.DataFrame, csv_name: str):
    processed_data.to_csv("Processed CSV Data Files(Attached Allergy)/"+ csv_name + ".csv")

# main 함수
def main():
    unitNumbers = [1691, 2171, 3296, 3389, 5021, 5322, 6176, 6282, 6335, 7369, 7652, 8623, 8902, 9030]

    for unitNum in unitNumbers:
        data=load_data(unitNum)
        processed_data = process_data(data)
        csv_name = "제" + str(unitNum) + "부대 메뉴정보"
        save_processed_data(processed_data, csv_name)
    return 0

if __name__ == "__main__":
    main()