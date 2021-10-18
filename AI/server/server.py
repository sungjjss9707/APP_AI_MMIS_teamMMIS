# 데이터 읽기 위한 라이브러리
import pandas as pd
import numpy as np
import pickle
import joblib
from pandas.core.frame import  DataFrame

# 플라스크 라이브러리
from flask import Flask, request, jsonify
from flask_cors import CORS

# 조합 관련
from itertools import product
from operator import itemgetter

# 예측 함수 파일
import predict as p

app = Flask(__name__)
CORS(app)

# 필요 data 읽기
data = pd.read_csv("/workspaces/APP_AI_MMIS_teamMMIS/AI/server/AI file/data.csv", encoding="UTF-8")
w2v_menu_sim_sorted_idx=np.load("/workspaces/APP_AI_MMIS_teamMMIS/AI/server/AI file/w2v_menu_sim_sorted_idx.npy")
bigram_menu_sim_sorted_idx=np.load("/workspaces/APP_AI_MMIS_teamMMIS/AI/server/AI file/bigram_menu_sim_sorted_idx.npy")
menus = pd.read_csv('/workspaces/APP_AI_MMIS_teamMMIS/AI/server/AI file/국방부메뉴_v2.1_맛_점수_포함.csv', index_col=0)
vectorizer_b1 = pickle.load(open('/workspaces/APP_AI_MMIS_teamMMIS/AI/server/AI file/vectorizer_b1.pk', 'rb'))
vectorizer_t1 = pickle.load(open('/workspaces/APP_AI_MMIS_teamMMIS/AI/server/AI file/vectorizer_t1.pk', 'rb'))
vectorizer_b2 = pickle.load(open('/workspaces/APP_AI_MMIS_teamMMIS/AI/server/AI file/vectorizer_b2.pk', 'rb'))
vectorizer_t2 = pickle.load(open('/workspaces/APP_AI_MMIS_teamMMIS/AI/server/AI file/vectorizer_t2.pk', 'rb'))
x_min_max_scaler = joblib.load('/workspaces/APP_AI_MMIS_teamMMIS/AI/server/AI file/x_min_max_scaler.save')
y_min_max_scaler = joblib.load('/workspaces/APP_AI_MMIS_teamMMIS/AI/server/AI file/y_min_max_scaler.save')
model = pickle.load(open('/workspaces/APP_AI_MMIS_teamMMIS/AI/server/AI file/ridge_v1.0.sav', 'rb'))

# Flutter 앱에서 이 친구를 호출할 예정 (body 데이터를 가져오려면 http 규칙이 post로 전송)

@app.route("/", methods=['POST'])
def main():

    cmReqDto = request.get_json()
    cmRespDto={} 


    # data 관련(score, recommendation)
    cmRespData={}

    for menu in cmReqDto["menus"]:
        menuIndex = data.loc[data['메뉴이름']==menu]
        if(menuIndex.empty==True):
            cmRespDto['code'] = -1
            cmRespDto['msg'] = "Failure. Invalid menu name."
            return jsonify(cmRespDto)

        # data - score
    cmRespData['score'] = p.predictScore(list(cmReqDto["menus"]), menus, vectorizer_b1, vectorizer_t1, vectorizer_b2, vectorizer_t2, x_min_max_scaler, y_min_max_scaler, model)

        # data - recommendation
    menuList=[]
    menuRecommendList=[]
    menuRecommend=[]

    for menu in cmReqDto["menus"]:
        bigram_w2v_menus=[]
        bigramTemp=p.find_sim_menu(data, bigram_menu_sim_sorted_idx, menu)
        w2vTemp=p.find_sim_menu(data, w2v_menu_sim_sorted_idx,menu)
        for temp in w2vTemp:
            bigram_w2v_menus.append(temp)
        for temp in bigramTemp:
            if not temp in bigram_w2v_menus:
                bigram_w2v_menus.append(temp)

        menuList.append(bigram_w2v_menus[:5])
    
    print(menuList)

    if len(cmReqDto["menus"])==3:
        for j in product(menuList[0],menuList[1],menuList[2]):
            menuRecommend.append(list(j))
    elif len(cmReqDto["menus"])==4:
        for j in product(menuList[0],menuList[1],menuList[2], menuList[3]):
            menuRecommend.append(list(j))
    elif len(cmReqDto["menus"])==5:
        for j in product(menuList[0],menuList[1],menuList[2], menuList[3],menuList[4]):
            menuRecommend.append(list(j))
    elif len(cmReqDto["menus"])==6:
        for j in product(menuList[0],menuList[1],menuList[2], menuList[3], menuList[4],menuList[5]):
            menuRecommend.append(list(j))
    elif len(cmReqDto["menus"])==7:
        for j in product(menuList[0],menuList[1],menuList[2], menuList[3], menuList[4], menuList[5],menuList[6]):
            menuRecommend.append(list(j))
    else: 
        cmRespDto['code'] = -1
        cmRespDto['msg'] = "Failure. more or less than set menu number(s)"
        return jsonify(cmRespDto)

    for testMenu in menuRecommend:
        tempNum=p.predictScore(testMenu)
        if tempNum >= cmRespData['score']:
            inputDict={}
            inputDict['score'] = tempNum
            inputDict['menus'] = testMenu
            menuRecommendList.append(inputDict)
    
    menuRecommendListSorted = sorted(menuRecommendList, key=itemgetter('score'),reverse=True)

    cmRespData['recommendation'] = menuRecommendListSorted[:5]


    cmRespDto['data'] = cmRespData

    # code와 msg 관련
    cmRespDto['code'] = 1
    cmRespDto['msg'] = 'Success'
    

    return jsonify(cmRespDto)

if __name__ == "__main__":
    app.run(host = '0.0.0.0', port=5500)
