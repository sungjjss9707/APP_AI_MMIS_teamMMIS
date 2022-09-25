var express = require('express');
var router = express.Router();
const mysql = require('mysql');


const connection =   mysql.createPool({
    user:'admin',
    password:'05751234',
    database: 'MMIS',
    host:'mmis.cip9531xqh6o.ap-northeast-2.rds.amazonaws.com',
});

router.post('/', async (req, res) => {
    var name = req.body.name;
    var nut =req.body.nutrition;
    var al = req.body.allergy;
    var nut_id;
    var allergy_id;
    var menu_reg;
    var nut_reg = `insert into nutrition (name, 칼로리, 탄수화물, 지방, 단백질, 나트륨, 콜레스테롤) value (\'${name}\',\'${nut.칼로리}\', \'${nut.탄수화물}\',\'${nut.지방}\',\'${nut.단백질}\',\'${nut.나트륨}\',\'${nut.콜레스테롤}\');`;
    var allergy_reg = `insert into allergy (name,계란류, 우유, 메밀, 땅콩, 대두, 밀, 고등어, 게, 새우, 돼지고기, 복숭아, 토마토, 아황산류, 호두, 닭고기, 쇠고기, 오징어, 조개류, 잣) value (\'${name}\',\'${al.계란류}\',\'${al.우유}\',\'${al.메밀}\',\'${al.땅콩}\',\'${al.대두}\',\'${al.밀}\',\'${al.고등어}\',\'${al.게}\',\'${al.새우}\',\'${al.돼지고기}\',\'${al.복숭아}\',\'${al.토마토}\',\'${al.아황산류}\',\'${al.호두}\',\'${al.닭고기}\',\'${al.쇠고기}\',\'${al.오징어}\',\'${al.조개류}\',\'${al.잣}\');`;
    connection.query(nut_reg, (error, results, fields) => {
        if (error) {
            console.log(error);
	    res.send({"code" : -1});
        }
	else{
	   // res.send("영양소 등록 성공");
	    var nut_ask = `select * from nutrition where name = \'${name}\' and 칼로리 = \'${nut.칼로리}\'and 탄수화물 = \'${nut.탄수화물}\'and 지방 = \'${nut.지방}\'and 단백질 = \'${nut.단백질}\'and 나트륨 = \'${nut.나트륨}\'and 콜레스테롤 = \'${nut.콜레스테롤}\'`; 
	    connection.query(nut_ask,(error, results, fields) => {
	       //  var noticeresponse = {"code" : 1, "msg" : "success", "data" : results[0]};
	       // res.send(noticeresponse);
		nut_id = results[0].id;

                connection.query(allergy_reg, (error, results, fields) => {

        	    if (error) {
            	        console.log(error);
	    	        res.send({"code" : -1});
         	    }
		    else{
	   // res.send("영양소 등록 성공");
	                var nut_ask = `select * from allergy where name = \'${name}\' and 계란류 = \'${al.계란류}\' and 우유 = \'${al.우유}\' and 메밀 = \'${al.메밀}\' and 땅콩 = \'${al.땅콩}\' and 대두 = \'${al.대두}\' and 밀 = \'${al.밀}\' and 고등어 = \'${al.고등어}\' and 게 = \'${al.게}\' and 새우 = \'${al.새우}\' and 돼지고기 = \'${al.돼지고기}\' and 복숭아 = \'${al.복숭아}\' and 토마토 = \'${al.토마토}\' and 아황산류 = \'${al.아황산류}\' and 호두= \'${al.호두}\' and 닭고기 = \'${al.닭고기}\' and 쇠고기 = \'${al.쇠고기}\' and 오징어 = \'${al.오징어}\' and 조개류 = \'${al.조개류}\' and 잣 = \'${al.잣}\' `; 
	                connection.query(nut_ask,(error, results, fields) => {
	       //  var noticeresponse = {"code" : 1, "msg" : "success", "data" : results[0]};
	       // res.send(noticeresponse);
		            allergy_id = results[0].id;
			    menu_reg = `insert into menu (name, nutrition_id, allergy_id) value (\'${name}\', \'${nut_id}\', \'${allergy_id}\');`
			    connection.query(menu_reg,(error, results, fields) => {
			    //    menu_reg = `insert into menu (name, nutrition_id, allergy_id) value (\'${name}\', \'${nut_id}\', \'${allergy_id}\');`
			   //     console.log(name);
			    //    console.log(nut_id);
			    //    console.log(allergy_id);
			    //    console.log(menu_reg);
			    //    console.log(nut);
			    //    console.log(al);
			        if(error){
	    			    res.send({"code" : -100});	
			        }
			        else{
	    			    var menuDataResponse = {"code" : 1, "msg" : "success","name" : name,  "nutrition" : nut, "allergy" : al};
	    			    res.send(menuDataResponse);
			        }
    		            })

                        })
                    }	
                })

            })
        }
    })
});

module.exports = router;
