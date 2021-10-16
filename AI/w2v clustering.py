#%%
#패키지 불러오기
import pandas as pd
import numpy as np
import matplotlib as mpl
import matplotlib.pyplot as plt
from pandas.core.frame import  DataFrame

from gensim.models import Word2Vec
#형태소 분석 패키지
from konlpy.tag import Okt 
from konlpy.tag import Komoran
from sklearn.utils.validation import indexable

# 데이터 불러오기
data= pd.read_csv("All Menu (Various Versions)/국방부메뉴_v2.1.csv", encoding="UTF-8")

# 정규 표현식을 통한 한글 외 문자 제거
data['메뉴이름'] = data['메뉴이름'].str.replace("[^ㄱ-ㅎㅏ-ㅣ가-힣 ]","")
data['메뉴이름'] = data['메뉴이름'].str.replace(" ","")
# 중복 제거
data = data.drop_duplicates(['메뉴이름'], ignore_index=True)

# 정규화

for i in data:
    if(i in ['계란류', '우유', '메밀', '땅콩', '대두', '밀', '고등어', '게', '새우', '돼지고기', '복숭아', '토마토', '아황산류', '호두', '닭고기', '쇠고기', '오징어', '조개류', '잣']):
        data[i] = data[i]/100
    if i in ['열량', '탄수화물', '지방', '단백질', '나트륨', '콜레스트롤']:
        data[i] = ((data[i]-data[i].mean())/data[i].std())/500

#
# Komoran 사용한 토큰화 작업
# okt, komoran 이 사용 가능(절대적 우위 가리기 불가) & morphs
# kkma는 시간이 오래 걸림/ hannanum은 위의 두 개 보다 성능 낮음

komoran = Komoran()
okt=Okt()
tokenized_data=[]

for menu in data['메뉴이름']:
    temp_X = okt.morphs(menu) #토큰화
    tokenized_data.append(temp_X)

# word2vec 사용

model = Word2Vec(sentences=tokenized_data, vector_size=200 , window=3, min_count=0, workers=4, sg=0)

# 
# 메뉴별 벡터 구하는 함수 

def get_sentence_mean_vector(morphs):
    vector=[]
    for i in morphs:
        try:
            vector.append(model.wv[i])
        except KeyError as e:
            pass
    try:
        return np.mean(vector, axis=0).tolist()
    except IndexError as e:
        pass

# 
# sentence vector를 data에 추가

sentence_vector=[]

for vectors in tokenized_data:
    temp_X = get_sentence_mean_vector(vectors)
    
    sentence_vector.append(temp_X)

data.insert(3, 'wv',sentence_vector)
# 
# clustering -> 추천 잘 될 수 있는지 시각화 용도

dataList=[]
for i in range(0, 1550):
    vectorData=data['wv'][i]
    for j in ['계란류', '우유', '메밀', '땅콩', '대두', '밀', '고등어', '게', '새우', '돼지고기', '복숭아', '토마토', '아황산류', '호두', '닭고기', '쇠고기', '오징어', '조개류', '잣', '열량', '탄수화물', '지방', '단백질', '나트륨', '콜레스트롤']:
        vectorData.append(data[j][i])
    dataList.append(vectorData)

from sklearn.cluster import KMeans

num_clusters = 10

k_means_clustering = KMeans(n_clusters=num_clusters)
idx = k_means_clustering.fit_predict(dataList)
data['category']=idx

# 
# Embedding & 시각화 위해 import
from sklearn.manifold import TSNE
import os.path
import pickle

# 차원축소(2차원으로)

X = data['wv'].tolist()
y = data['category'].tolist()

tsne_filepath = 'tnse3000(w2v).pkl'

# File Cache
if not os.path.exists(tsne_filepath):
    tsne = TSNE(random_state=42)
    tsne_points = tsne.fit_transform(X)
    with open(tsne_filepath, 'wb+') as f:
        pickle.dump(tsne_points, f)
else: #cache hits
    with open(tsne_filepath, 'rb') as f:
        tsne_points=pickle.load(f)
        

tsne=TSNE(random_state=42)
tsne_points = tsne.fit_transform(X)

tsne_df = pd.DataFrame(tsne_points, index=range(len(X)), columns=['x_coord', 'y_coord'])
tsne_df['menu_name']=data['메뉴이름'].tolist()
tsne_df['cluster_number'] = y

#2차원 plotting
from bokeh.plotting import figure, show, output_notebook
from bokeh.models import HoverTool, ColumnDataSource, value
from bokeh.palettes import brewer

output_notebook()

# Get the number of colors we'll need for the plot.
colors = brewer["Spectral"][len(tsne_df['cluster_number'].unique())]

# Create a map between factor and color.
colormap = {i: colors[i] for i in tsne_df['cluster_number'].unique()}

# Create a list of colors for each value that we will be looking at.
colors = [colormap[x] for x in tsne_df['cluster_number']]

tsne_df['color']=colors

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

# 
# 유사 메뉴 추천 

from sklearn.metrics.pairwise import cosine_similarity
import warnings; warnings.filterwarnings('ignore')

# 
# 코사인 유사도 계산
menuNameSimilarity = cosine_similarity(dataList, dataList)

# 유사도 정렬
menu_sim_sorted_idx = menuNameSimilarity.argsort()[:, ::-1]

# 
# 유사 메뉴 추천 함수
def find_sim_menu(data, sorted_idx, name, number=10):
    title_menu=data[data['메뉴이름']==name]

    title_menu_idx = title_menu.index.values

    top_sim_idx = sorted_idx[title_menu_idx, :number]
    
    top_sim_idx = top_sim_idx.reshape(-1,)
    similar_menu = data.iloc[top_sim_idx]['메뉴이름']

    similar_menu_list =[]
    for sim_menu in similar_menu:
        similar_menu_list.append(sim_menu)


    return similar_menu_list[1:4]



# 
# 메뉴 추천 Test
recommendMenus = ['청양마요치킨', '비엔나소시지찌개','햄치즈버거','탕수육','두부고추장찌개','낙지덮밥','꼬리곰탕','김장김치','콘형아이스크림']
for menu in recommendMenus:
    print(menu, end=' : ')
    print(find_sim_menu(data, menu_sim_sorted_idx, menu))


# %%
# 서비스 작동을 위한 배열 저장

np.save('/workspaces/APP_AI_MMIS_teamMMIS/AI/server/AI file/w2v_menu_sim_sorted_idx',menu_sim_sorted_idx)
data.to_csv('/workspaces/APP_AI_MMIS_teamMMIS/AI/server/AI file/data.csv')
# %%
