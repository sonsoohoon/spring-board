console.log("reply Module......");

var replyService = (function(){
	
	function add(reply, callback, error) {
		console.log("add reply........");
	
		$.ajax({
			type : 'post',
			url : '/ex03/replies/new',
			data : JSON.stringify(reply),
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr) {
				if (callback) {
					callback(result);
				}
			},
			error : function(xhr, status, er) {
				if (error) {
					error(er);
				}//if (error) end
			}//error : function(xhr, status, er) { end
		});//$.ajax end
	}//function add(reply, callback, error) { end
	
	function getList(param, callback, error) {
		
		var bno = param.bno;
		//console.log("getList param.page:" + param.page);
		var page = param.page || 1;
		
		$.getJSON("/ex03/replies/pages/" + bno + "/" + page + ".json",
				function(data) {
					if (callback) {
						//callback(data);//댓글 목록만 가져올 
						callback(data.replyCnt, data.list); //댓글 숫자와 목록을 가져오는 경우 
					} //if (callback) end
				}//function(data) end
		).fail(function(xhr, status, err) {
			if (error) {
				error();
			}//if (error) end
			}//function(xhr, status, err)
		);//getJson.fail end
	}//function getList(param, callback, error) { end
	
	function remove(rno, callback, error) {
		console.log("delete reply........");
		$.ajax({
			type : 'delete',
			url : '/ex03/replies/' + rno,
			success : function(deleteResult, status, xhr) {
				if (callback) {
					callback(deleteResult);
				} //if (callback) end
			}, //success: end
			error : function(xhr, status, er) {
				if (error) {
					error(er);
				} //if (error) end
			} //error : end
		}); //$.ajax ({ end
	} //function remove(rno, callback, error) { end
	
	function update(reply, callback, error) {
		console.log("update reply........");
		$.ajax({
			type : 'put',
			url : '/ex03/replies/' + reply.rno,
			data : JSON.stringify(reply),
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr) {
				if (callback) {
					callback(result);
				} //if (callback) end
			}, //success: end
			error : function(xhr, status, er) {
				if (error) {
					error(er);
				} //if (error) end
			} //error : end
		}); //$.ajax ({ end
	} //function remove(rno, callback, error) { end
	function get(rno, callback, error) {
		$.get("/ex03/replies/" + rno + ".json" , function(result) {
			
			if (callback) {
				callback(result);
			}
		}).fail(function(xhr, status, err) {
			if (error) {
				error();
			} //if (error) end
		});//$.get, .fail end
	} //function get(rno, callback, error) end
	
	function displayTime(timeValue) {

		var today = new Date(); //현재 날짜 할당

		var gap = today.getTime() - timeValue;//댓글 시간과 현재시간 비교

		var dateObj = new Date(timeValue);//댓글 시간 할당
		var str = "";

		if (gap < (1000 * 60 * 60 * 24)) {//24시간이 안지났다면

			var hh = dateObj.getHours();
			var mi = dateObj.getMinutes();
			var ss = dateObj.getSeconds();

			return [ (hh > 9 ? '' : '0') + hh, ':', (mi > 9 ? '' : '0') + mi,
					':', (ss > 9 ? '' : '0') + ss ].join('');

		} else { //24시간이 지났다면
			var yy = dateObj.getFullYear();
			var mm = dateObj.getMonth() + 1; // getMonth() is zero-based
			var dd = dateObj.getDate();

			return [ yy, '/', (mm > 9 ? '' : '0') + mm, '/',
					(dd > 9 ? '' : '0') + dd ].join('');
		}//else end
	};//function displayTime(timeValue) { end
	
	return { 
		add:add,
		getList:getList,
		remove:remove,
		update:update,
		get:get,
		displayTime:displayTime
	};
})();