#%%
#패키지 불러오기
import pandas as pd
import numpy as np
import matplotlib as mpl
import matplotlib.pyplot as plt
from pandas.core.frame import  DataFrame

#형태소 분석 패키지
from konlpy.tag import Okt 
from konlpy.tag import Komoran

# %%
#데이터 불러오기
data= pd.read_csv("All Menu (Various Versions)/ 국방부메뉴_v1.0.csv", encoding="UTF-8")
data

#%%
# 정규 표현식을 통한 한글 외 문자 제거
data['메뉴이름'] = data['메뉴이름'].str.replace("[^ㄱ-ㅎㅏ-ㅣ가-힣 ]","")

#%%
# bigram/ trigram 만들기
bigram=[]
trigram =[]

# bigram
for menuName in data['메뉴이름']:
    temp=[]
    if(len(menuName)==1) :
        bigram.append([menuName])
    else :
        for i in range(len(menuName)-1):
            
            temp.append(str(menuName[i]+menuName[i+1]))
        bigram.append(temp)        

# tri-gram
for menuName in data['메뉴이름']:
    temp=[]
    if(len(menuName)==1 or len(menuName)==2) :
        trigram.append([menuName])
    else :
        for i in range(len(menuName)-2):
            
            temp.append(str(menuName[i]+menuName[i+1]+menuName[i+2]))    
        trigram.append(temp)

# %%
data.insert(2, 'bigram',bigram)

data.insert(3, 'trigram',trigram)

data
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

trigram_tfidf_vectorizer = TfidfVectorizer(min_df = 3, ngram_range=(1,1))
trigram_tfidf_vectorizer.fit(trigramText)

#벡터로 변환
bigram_vector = bigram_tfidf_vectorizer.transform(bigramText).toarray()
trigram_vector=trigram_tfidf_vectorizer.transform(trigramText).toarray()


# %%
# k-means clustering

from sklearn.cluster import KMeans

bigram_dataList=[]
for vectorList in bigram_vector:
    bigram_dataList.append(vectorList.tolist())

trigram_dataList=[]
for vectorList in trigram_vector:
    trigram_dataList.append(vectorList.tolist())

num_clusters = 10

k_means_clustering = KMeans(n_clusters=num_clusters)

bigram_idx = k_means_clustering.fit_predict(bigram_dataList)
trigram_idx = k_means_clustering.fit_predict(trigram_dataList)

data['category_bigram']=bigram_idx
data['category_trigram']=trigram_idx


# %%
#Embedding & 시각화
from sklearn.manifold import TSNE
import os.path
import pickle

#%%
#차원축소
X = bigram_vector.tolist()
y = data['category_bigram'].tolist()

tsne_filepath = 'tnse3000(n-gram).pkl'

# File Cache
if not os.path.exists(tsne_filepath):
    tsne = TSNE(random_state=42)
    tsne_points = tsne.fit_transform(X)
    with open(tsne_filepath, 'wb+') as f:
        pickle.dump(tsne_points, f)
else: #cache hits
    with open(tsne_filepath, 'rb') as f:
        tsne_points=pickle.load(f)

tsne_df = pd.DataFrame(tsne_points, index=range(len(X)), columns=['x_coord', 'y_coord'])
tsne_df['menu_name']=data['메뉴이름'].tolist()
tsne_df['cluster_number'] = y

# %%
#2차원 plotting
from bokeh.plotting import figure, show, output_notebook
from bokeh.models import HoverTool, ColumnDataSource, value
from bokeh.palettes import brewer

output_notebook()
# %%
# Get the number of colors we'll need for the plot.
colors = brewer["Spectral"][len(tsne_df['cluster_number'].unique())]

# Create a map between factor and color.
colormap = {i: colors[i] for i in tsne_df['cluster_number'].unique()}

# Create a list of colors for each value that we will be looking at.
colors = [colormap[x] for x in tsne_df['cluster_number']]

tsne_df['color']=colors
# %%
# Bokeh Datasouce 만들기
plot_data = ColumnDataSource(
    data=tsne_df.to_dict(orient='list')
)

# Plot 만들기(배경)
tsne_plot = figure(
    # title='TSNE Twitter BIO Embeddings',
    plot_width = 650,
    plot_height = 650,
    active_scroll='wheel_zoom',
    output_backend="webgl",
)

# 해당 Hover 툴팁 만들기
tsne_plot.add_tools(
    HoverTool(
        tooltips='@menu_name'
    )
)

tsne_plot.circle(
    source=plot_data,
    x='x_coord',
    y='y_coord',
    line_alpha=0.3, 
    fill_alpha=0.2,
    size=10,
    fill_color='color',
    line_color='color',
)

# 각 값들 추가해주기 
tsne_plot.title.text_font_size = '16pt'
tsne_plot.xaxis.visible = False
tsne_plot.yaxis.visible = False
tsne_plot.grid.grid_line_color = None
tsne_plot.outline_line_color = None

# 짠!
show(tsne_plot)

# %%
