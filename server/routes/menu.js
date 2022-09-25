var express = require('express');
var router = express.Router();
const mysql = require('mysql');


const connection =   mysql.createPool({
    user:'admin',
    password:'05751234',
    database: 'MMIS',
    host:'mmis.cip9531xqh6o.ap-northeast-2.rds.amazonaws.com',
    multipleStatements:true,
});

router.post('/', async (req, res) => {
    var name = req.body.name;
    var nut =req.body.nutrition;
    var al = req.body.allergy;
    var nutrition;
    var allergy;
    var menu_reg;
    var menu_reg = `insert into menu (name) value (\'${name}\');`;
    var nut_reg = `insert into nutrition (name, 칼로리, 탄수화물, 지방, 단백질, 나트륨, 콜레스테롤) value (\'${name}\',\'${nut.칼로리}\', \'${nut.탄수화물}\',\'${nut.지방}\',\'${nut.단백질}\',\'${nut.나트륨}\',\'${nut.콜레스테롤}\');`;
    var allergy_reg = `insert into allergy (name,계란류, 우유, 메밀, 땅콩, 대두, 밀, 고등어, 게, 새우, 돼지고기, 복숭아, 토마토, 아황산류, 호두, 닭고기, 쇠고기, 오징어, 조개류, 잣) value (\'${name}\',\'${al.계란류}\',\'${al.우유}\',\'${al.메밀}\',\'${al.땅콩}\',\'${al.대두}\',\'${al.밀}\',\'${al.고등어}\',\'${al.게}\',\'${al.새우}\',\'${al.돼지고기}\',\'${al.복숭아}\',\'${al.토마토}\',\'${al.아황산류}\',\'${al.호두}\',\'${al.닭고기}\',\'${al.쇠고기}\',\'${al.오징어}\',\'${al.조개류}\',\'${al.잣}\');`;
    
    connection.query(menu_reg, (error, results, fields) => {
        if (error) {
            console.log(error);
	    res.send({"code" : -1});
        }
	else{
            connection.query(nut_reg+allergy_reg, (error, results1, fields) => {
                if (error) {
                    console.log(error);
	    	    res.send({"code" : -1});
        	}
		else{
		    var sql1 = `select 칼로리, 탄수화물, 지방, 단백질, 나트륨, 콜레스테롤 from nutrition where name = \'${name}\';`;
		    var sql2 = `select 계란류, 우유, 메밀, 땅콩, 대두, 밀, 고등어, 게, 새우, 돼지고기, 복숭아, 토마토, 아황산류, 호두, 닭고기, 쇠고기, 오징어, 조개류, 잣 from allergy where name = \'${name}\';`;
		    connection.query(sql1+sql2, (error, results2, fields) => {
			if(error){
				res.send({"code" : -1});
			}
			else{
				console.log(results2[0][0]);
				console.log(results2[1][0]);
				var data = {"name" : name, "nutrition" : results2[0][0], "allergy" : results2[1][0]};
				var response = {"code" : 1, "msg" : "success", "data" : data};
				res.send(response);
			}
		    })
        	}
    	    })
        }
    })
});

router.get('/', async (req, res) => {
    var query = `select name from menu;`;
    connection.query(query, (error, results, fields) => {
        if (error) {
            console.log(error);
	    res.send({"code" : -1});
	}
	else{
	    if(results.length==0) res.send({"code":1, "msg":"success", "data":[]});
	    else{
	    var namearray = [];
	    console.log(results);
	    for(var i in results){
		namearray.push(results[i].name);
		console.log(namearray[i]);
	    }
	    
	   // console.log(namearray);
	   // res.send(namearray);
	    var tempquery,query2 = ``;
	    for(var i in namearray){
		tempquery = `select 칼로리, 탄수화물, 지방, 단백질, 나트륨 콜레스테롤 from nutrition where name = \'${namearray[i]}\';`;
		query2 +=tempquery;
		console.log(tempquery);
	    }
	    connection.query(query2, (error, results2, fields) => {
		if(error){
		    res.send({"code" : -1});
		}
	  	else{
		    var nutritionarray=[];
		    for(var i in results2){
			nutritionarray.push(results2[i][0]);
			console.log(nutritionarray[i]);
	    	    }
		    var tempquery2,query3 = '';
	            for(var i in namearray){
			tempquery2 = `select 계란류, 우유, 메밀, 땅콩, 대두, 밀, 고등어, 게, 새우, 돼지고기, 복숭아, 토마토, 아황산류, 호두, 닭고기, 쇠고기, 오징어, 조개류, 잣 from allergy where name = \'${namearray[i]}\';`;
			query3+=tempquery2;
			console.log(tempquery2);
	    	    }
		    connection.query(query3, (error, results3, fields) => {
	                if(error){
		            res.send({"code" : -1});
		        }
	  	        else{
		            var allergyarray=[];
		            for(var i in results3){
			        allergyarray.push(results3[i][0]);
			        console.log(allergyarray[i]);
	    	            }
			    var data = [];
			    for(var i in namearray){
				data.push({"name": namearray[i], "nutrition": nutritionarray[i], "allergy": allergyarray[i]});
				
			    }
			    var GetAllMenuData = {"code": 1, "msg": "success", "data": data};
			    res.send(GetAllMenuData);
		        }
	            })

		}
	    })
	}
	}
    })
});


router.get('/:mymenu', async (req, res) => {
    var mymenu = req.params.mymenu;
    var query1 = `select name from menu where name = \'${mymenu}\';`;
    var query2 = `select 칼로리, 탄수화물, 지방, 단백질, 나트륨, 콜레스테롤 from nutrition where name = \'${mymenu}\';`;
    var query3 = `select 계란류, 우유, 메밀, 땅콩, 대두, 밀, 고등어, 게, 새우, 돼지고기, 복숭아, 토마토, 아황산류, 호두, 닭고기, 쇠고기, 오징어, 조개류, 잣 from allergy where name = \'${mymenu}\' ;`;


    connection.query(query1+query2+query3, (error, results, fields) => {
        if (error) {
            console.log(error);
	    res.send({"code" : -1});
	}
	else{
	    if(results.length==0) res.send({"code":1, "msg":"success", "data":[]});
	    else{

	    console.log(results);
	    //res.send(results);
	    
	    var name = results[0][0].name;
	    var nutrition = results[1][0];
	    var allergy = results[2][0];
	    console.log(nutrition);
	    console.log(allergy);
	    var data = {"name": name, "nutrition": nutrition, "allergy": allergy};
	    var menuDataResponse = {"code": 1, "msg": "success", "data": data};
	    res.send(menuDataResponse);
	}
	}
    })
});




module.exports = router;
