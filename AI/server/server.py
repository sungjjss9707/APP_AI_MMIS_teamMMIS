# 데이터 읽기 위한 라이브러리
import pandas as pd
import numpy as np
from pandas.core.frame import  DataFrame

# 플라스크 라이브러리
from flask import Flask, request, jsonify
from flask_cors import CORS

# 예측 함수 파일
import predict as p

app = Flask(__name__)
CORS(app)

# 필요 data 읽기
data = pd.read_csv("/workspaces/APP_AI_MMIS_teamMMIS/AI/server/AI file/data.csv", encoding="UTF-8")
menu_sim_sorted_idx=np.load("/workspaces/APP_AI_MMIS_teamMMIS/AI/server/AI file/menu_sim_sorted_idx.npy")


#Flutter 앱에서 이 친구를 호출할 예정 (body 데이터를 가져오려면 http 규칙이 post로 전송)

@app.route("/", methods=['POST'])
def main():

    cmReqDto = request.get_json()
    print(cmReqDto)
    cmRespDto={} 

    for menu in cmReqDto:
        menuIndex = data.loc[data['메뉴이름']==cmReqDto[menu]]
        if(menuIndex.empty==True):
            cmRespDto['code'] = -1
            cmRespDto['msg'] = "Failure. Invalid menu name."
            return jsonify(cmRespDto)
        else:
            cmRespDto[menu] = p.find_sim_menu(data, menu_sim_sorted_idx, cmReqDto[menu])

    cmRespDto['code'] = 1
    cmRespDto['msg'] = 'Success'
    cmRespDto['score'] = p.predictScore()

    return jsonify(cmRespDto)


if __name__ == "__main__":
    app.run(debug=True, port=5500)
