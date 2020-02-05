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
		})//$.ajax end
	}//function add(reply, callback, error) { end
	
	function getList(param, callback, error) {
		
		var bno = param.bno;
		var page = param.page || 1;
		
		$.getJSON("/ex03/replies/pages/" + bno + "/" + page + ".json",
				function(data) {
					if (callback) {
						callback(data);
					} //if (callback) end
				}//function(data) end
		).fail(function(xhr, status, err) {
			if (error) {
				error();
			}//if (error) end
			}//function(xhr, status, err)
		);//getJson.fail end
	}//function getList(param, callback, error) { end
	
	return { 
		add:add,
		getList:getList
	};
})();