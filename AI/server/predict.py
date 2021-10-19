# 모듈 import
import pandas as pd
import numpy as np
from pandas.core.frame import  DataFrame
from itertools import product
import pickle
import Levenshtein as lev
import joblib

"""# 필요 data 읽기
data = pd.read_csv("/workspaces/APP_AI_MMIS_teamMMIS/AI/server/AI file/data.csv", encoding="UTF-8")
menu_sim_sorted_idx=np.load("/workspaces/APP_AI_MMIS_teamMMIS/AI/server/AI file/menu_sim_sorted_idx.npy")
menus = pd.read_csv('/workspaces/APP_AI_MMIS_teamMMIS/AI/server/AI file/국방부메뉴_v2.1_맛_점수_포함.csv', index_col=0)
vectorizer_b1 = pickle.load(open('/workspaces/APP_AI_MMIS_teamMMIS/AI/server/AI file/vectorizer_b1.pk', 'rb'))
vectorizer_t1 = pickle.load(open('/workspaces/APP_AI_MMIS_teamMMIS/AI/server/AI file/vectorizer_t1.pk', 'rb'))
vectorizer_b2 = pickle.load(open('/workspaces/APP_AI_MMIS_teamMMIS/AI/server/AI file/vectorizer_b2.pk', 'rb'))
vectorizer_t2 = pickle.load(open('/workspaces/APP_AI_MMIS_teamMMIS/AI/server/AI file/vectorizer_t2.pk', 'rb'))
x_min_max_scaler = joblib.load('/workspaces/APP_AI_MMIS_teamMMIS/AI/server/AI file/x_min_max_scaler.save')
y_min_max_scaler = joblib.load('/workspaces/APP_AI_MMIS_teamMMIS/AI/server/AI file/y_min_max_scaler.save')
model = pickle.load(open('/workspaces/APP_AI_MMIS_teamMMIS/AI/server/AI file/ridge_v1.0.sav', 'rb'))
"""

# 유사 메뉴 추천 함수

def find_sim_menu(data, menu_sim_sorted_idx, name, number=10):

    
    
    title_menu=data[data['메뉴이름']==name]

    title_menu_idx = title_menu.index.values

    top_sim_idx = menu_sim_sorted_idx[title_menu_idx, :number]
    
    top_sim_idx = top_sim_idx.reshape(-1,)
    similar_menu = data.iloc[top_sim_idx]['메뉴이름']

    similar_menu_list =[]
    for sim_menu in similar_menu:
        similar_menu_list.append(sim_menu)


    return similar_menu_list[1:4]



''' 한끼니 점수 예측을 위한 함수들 '''

def calculate_lev(first: str, second: str) -> int:
    return lev.ratio(first, second)

def get_nearest_data(menu_name: str, menus: pd.DataFrame) -> pd.DataFrame:
    lev_ratio = [calculate_lev(str(s), menu_name) for s in menus['메뉴이름']]
    idx = lev_ratio.index(max(lev_ratio))
    return pd.DataFrame(menus.iloc[idx]).transpose()

def create_predict_df(main: str, another: str, menus) -> pd.DataFrame:
    # 첫번째 메뉴 데이터 가져오기
    main_df = menus.loc[menus['메뉴이름'] == main]
    if len(main_df) == 0: main_df = get_nearest_data(main, menus)
    main_df.columns = [col_name + '1' for col_name in main_df.columns]
    main_df = main_df.reset_index(drop=True)
    # 두번째 메뉴 데이터 가져오기
    another_df = menus.loc[menus['메뉴이름'] == another]
    if len(another_df) == 0: another_df = get_nearest_data(another, menus)
    another_df = another_df.rename(columns={'메뉴이름': '다른메뉴'})
    another_df.columns = [col_name + '2' for col_name in another_df.columns]
    another_df = another_df.reset_index(drop=True)
    # 예측 데이터 테이블 만들기
    predict_df = pd.concat([main_df, another_df], axis=1)
    return predict_df

def create_ngrams(menuName: str, first: bool, predict_df: pd.DataFrame) -> pd.DataFrame:
    # 메뉴이름 bigram 만들기
    bigram_list=[]
    if(len(menuName)==1):
        bigram_list = [menuName]
    else:
        for i in range(len(menuName)-1):
            bigram_list.append(str(menuName[i]+menuName[i+1]))       
    bigramText = " ".join(bigram_list)
    # 메뉴이름 tri-gram 만들기
    trigram_list =[]
    if(len(menuName)==1 or len(menuName)==2) :
        trigram_list = [menuName]
    else :
        for i in range(len(menuName)-2):
            trigram_list.append(str(menuName[i]+menuName[i+1]+menuName[i+2]))    
    trigramText = " ".join(trigram_list)
    # data축에 삽입
    if first: 
        predict_df.insert(1, 'bigram1',bigramText)
        predict_df.insert(2, 'trigram1',trigramText)
    else:
        predict_df.insert(3, 'bigram2',bigramText)
        predict_df.insert(4, 'trigram2',trigramText)
    return predict_df

def create_ngram_features(final_df: pd.DataFrame, vectorizer_b1, vectorizer_t1, vectorizer_b2, vectorizer_t2) -> pd.DataFrame:
    # 메뉴이름, 다른메뉴 열 삭제
    del final_df['메뉴이름']
    del final_df['다른메뉴']
    # 첫번째 메뉴 bigram 생성
    x_b1 = vectorizer_b1.transform(final_df['bigram1'])
    bigram1 = pd.DataFrame(x_b1.toarray(), columns = ['b1_' + c for c in vectorizer_b1.get_feature_names()])
    # 첫번째 메뉴 trigram 생성
    x_t1 = vectorizer_t1.transform(final_df['trigram1'])
    trigram1 = pd.DataFrame(x_t1.toarray(), columns = ['t1_' + c for c in vectorizer_t1.get_feature_names()])
    # 두번째 메뉴 bigram 생성
    x_b2 = vectorizer_b2.transform(final_df['bigram2'])
    bigram2 = pd.DataFrame(x_b2.toarray(), columns = ['b2_' + c for c in vectorizer_b2.get_feature_names()])
    # 두번째 메뉴 trigram 생성
    x_t2 = vectorizer_t2.transform(final_df['trigram2'])
    trigram2 = pd.DataFrame(x_t2.toarray(), columns = ['t2_' + c for c in vectorizer_t2.get_feature_names()])
    # 데이터 합체
    final_df = pd.concat([final_df, bigram1, trigram1, bigram2, trigram2], axis=1)
    # 불필요 데이터 삭제
    del final_df['bigram1']
    del final_df['trigram1']
    del final_df['bigram2']
    del final_df['trigram2']
    # 리턴
    return final_df

def predict_combination_score(main: str, another: str, menus, vectorizer_b1, vectorizer_t1, vectorizer_b2, vectorizer_t2, x_min_max_scaler, y_min_max_scaler, model) -> float:
    predict_df = create_predict_df(main, another, menus)
    predict_df = create_ngrams(str(predict_df['메뉴이름1'][0]), True, predict_df)
    predict_df = create_ngrams(str(predict_df['다른메뉴2'][0]), False, predict_df)
    final_df = predict_df.rename(columns={'메뉴이름1': '메뉴이름', '다른메뉴2': '다른메뉴'})
    final_df = create_ngram_features(final_df, vectorizer_b1, vectorizer_t1, vectorizer_b2, vectorizer_t2)

    scaled_X = x_min_max_scaler.transform(final_df)
    pred = model.predict(scaled_X)
    score = y_min_max_scaler.inverse_transform(pred)
    return score

def predictScore(menuList: list, menus, vectorizer_b1, vectorizer_t1, vectorizer_b2, vectorizer_t2, x_min_max_scaler, y_min_max_scaler, model) -> int:
    scores = []
    for i in range(len(menuList)):
        for j in range(len(menuList)):
            if i == j: break   
            main = menuList[i]
            another = menuList[j]
            scores.append(predict_combination_score(main, another, menus, vectorizer_b1, vectorizer_t1, vectorizer_b2, vectorizer_t2, x_min_max_scaler, y_min_max_scaler, model))
    mean_score = round(np.mean(scores) + np.random.randint(-1, 3))
    return mean_score if mean_score > 0 else 0


