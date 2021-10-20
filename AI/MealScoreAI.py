# %%
import pickle
import pandas as pd
import numpy as np
import Levenshtein as lev
import joblib

# %%
menus = pd.read_csv('./server/AI file/국방부메뉴_v2.1_맛_점수_포함.csv', index_col=0)
vectorizer_b1 = pickle.load(open('server/AI file/vectorizer_b1.pk', 'rb'))
vectorizer_t1 = pickle.load(open('server/AI file/vectorizer_t1.pk', 'rb'))
vectorizer_t2 = pickle.load(open('server/AI file/vectorizer_t2.pk', 'rb'))
x_min_max_scaler = joblib.load('server/AI file/x_min_max_scaler.save')
y_min_max_scaler = joblib.load('server/AI file/y_min_max_scaler.save')
model = pickle.load(open('server/AI file/ridge_v1.0.sav', 'rb'))

# %%
def calculate_lev(first: str, second: str) -> int:
    return lev.ratio(first, second)

def get_nearest_data(menu_name: str, menus: pd.DataFrame) -> pd.DataFrame:
    lev_ratio = [calculate_lev(str(s), menu_name) for s in menus['메뉴이름']]
    idx = lev_ratio.index(max(lev_ratio))
    return pd.DataFrame(menus.iloc[idx]).transpose()

# %%
def create_predict_df(main: str, another: str) -> pd.DataFrame:
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

# %%
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

# %%
def create_ngram_features(final_df: pd.DataFrame) -> pd.DataFrame:
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

# %%
def predict_combination_score(main: str, another: str) -> float:
  predict_df = create_predict_df(main, another)
  predict_df = create_ngrams(str(predict_df['메뉴이름1'][0]), True, predict_df)
  predict_df = create_ngrams(str(predict_df['다른메뉴2'][0]), False, predict_df)
  final_df = predict_df.rename(columns={'메뉴이름1': '메뉴이름', '다른메뉴2': '다른메뉴'})
  final_df = create_ngram_features(final_df)

  scaled_X = x_min_max_scaler.transform(final_df)
  pred = model.predict(scaled_X)
  score = y_min_max_scaler.inverse_transform(pred)
  return score

# %%
main = "김치"
another = "흑미밥"

# %%
predict_combination_score(main, another)

# %%
menuList= ['두부김치', '해물짬뽕', '흑미밥', '김치', '복숭아 주스']

# %%
scores = []
for i in range(len(menuList)):
  for j in range(len(menuList)):
    if i == j: break   
    main = menuList[i]
    another = menuList[j]
    scores.append(predict_combination_score(main, another))
scores

# %%
np.mean(scores)
