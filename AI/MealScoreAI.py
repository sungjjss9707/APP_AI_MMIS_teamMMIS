# %%
import pandas as pd

# %%
distinct_correlation = pd.read_csv("Second Model Data/메뉴조합점수.csv", index_col=0)
main_menu_data = pd.read_csv("Second Model Data/메인메뉴데이터_v2.csv", index_col=0)
another_menu_data = pd.read_csv("Second Model Data/다른메뉴데이터_v2.csv", index_col=0)

# %%
del main_menu_data['메뉴이름']
main_menu_data

# %%
del another_menu_data['메뉴이름']
another_menu_data

# %%
main_menu_data.columns = [col_name + '1' for col_name in main_menu_data.columns]
another_menu_data.columns = [col_name + '2' for col_name in another_menu_data.columns]

# %%
final_df = pd.concat([distinct_correlation, main_menu_data, another_menu_data], axis=1)
final_df

# %%
# 메뉴이름 bigram 만들기
bigram_list=[]
for menuName in final_df['메뉴이름']:
    temp=[]
    if(len(menuName)==1):
        bigram_list.append([menuName])
    else:
        for i in range(len(menuName)-1):
            temp.append(str(menuName[i]+menuName[i+1]))
        bigram_list.append(temp)        
bigram_list

# %%
# 메뉴이름 tri-gram 만들기
trigram_list =[]
for menuName in final_df['메뉴이름']:
    temp=[]
    if(len(menuName)==1 or len(menuName)==2) :
        trigram_list.append([menuName])
    else :
        for i in range(len(menuName)-2):
            temp.append(str(menuName[i]+menuName[i+1]+menuName[i+2]))    
        trigram_list.append(temp)
trigram_list

# %%
# bigram/ trigram list 형태로 만듦
bigramText = [" ".join(bigram) for bigram in bigram_list]
trigramText = [" ".join(trigram) for trigram in trigram_list]

# data축에 삽입
final_df.insert(2, 'bigram1',bigramText)
final_df.insert(3, 'trigram1',trigramText)
final_df

# %%
# 다른메뉴 bigram 만들기
bigram_list=[]
for menuName in final_df['다른메뉴']:
    temp=[]
    if(len(menuName)==1):
        bigram_list.append([menuName])
    else:
        for i in range(len(menuName)-1):
            temp.append(str(menuName[i]+menuName[i+1]))
        bigram_list.append(temp)        
bigram_list

# %%
# 다른메뉴 tri-gram 만들기
trigram_list =[]
for menuName in final_df['다른메뉴']:
    temp=[]
    if(len(menuName)==1 or len(menuName)==2) :
        trigram_list.append([menuName])
    else :
        for i in range(len(menuName)-2):
            temp.append(str(menuName[i]+menuName[i+1]+menuName[i+2]))    
        trigram_list.append(temp)
trigram_list

# %%
# bigram/ trigram list 형태로 만듦
bigramText = [" ".join(bigram) for bigram in bigram_list]
trigramText = [" ".join(trigram) for trigram in trigram_list]

# data축에 삽입
final_df.insert(4, 'bigram2',bigramText)
final_df.insert(5, 'trigram2',trigramText)
final_df

# %%
final_df.dropna()

# %%
# tf-idf 적용 
from sklearn.feature_extraction.text import TfidfVectorizer

bigram_tfidf_vectorizer=TfidfVectorizer
trigram_tfidf_vectorizer=TfidfVectorizer

#bigram/ trigram list 형태로 만듦
bigramText = [" ".join(bigram) for bigram in data['bigram']]
trigramText = [" ".join(trigram) for trigram in data['trigram']]

#tfidf 진행
bigram_tfidf_vectorizer = TfidfVectorizer(min_df = 3, ngram_range=(1,1))
bigram_tfidf_vectorizer.fit(bigramText)

trigram_tfidf_vectorizer = TfidfVectorizer(min_df = 2, ngram_range=(1,1))
trigram_tfidf_vectorizer.fit(trigramText)

#벡터로 변환
bigram_vector = bigram_tfidf_vectorizer.transform(bigramText).toarray()
trigram_vector=trigram_tfidf_vectorizer.transform(trigramText).toarray()


# %%

