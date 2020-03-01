<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../includes/header.jsp" %>

<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">Board Read</h1>
	</div><!-- col-lg-12 end -->
</div><!-- row end -->

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default"></div>
			<div class="panel-heading">Board Read Page</div>
			<div class="panel-body" style="padding : 0; margin-bottom: 20px;">
			
					<div class="form-group">
						<label>Bno</label>
						<input class="form-control" name='bno'
							value='<c:out value="${board.bno}"/>' readonly="readonly">
					</div><!-- form-group end -->
					
					<div class="form-group">
						<label>Title</label>
						<input class="form-control" name='title'
							value='<c:out value="${board.title}" />' readonly="readonly">
					</div><!-- form-group end -->
					
					<div class="form-group">
						<label>Text area</label>
						<textarea class="form-control" rows="3" name='content'
							 readonly="readonly" ><c:out value="${board.content}" />
						</textarea>
					</div><!-- form-group end -->	

					<div class="form-group">
						<label>Writer</label>
						<input class="form-control" name='writer'
							value='<c:out value="${board.writer}" />' readonly="readonly">
					</div>
					
					<button data-oper='modify' class="btn btn-default">
						Modify
					</button>
					<button data-oper='list' class="btn btn-info">
						List
					</button>
					
					<!-- page 이동을 위한 폼 -->
					<form id="openForm" action="${pageContext.request.contextPath}/board/modify" method="get">
						<input type="hidden" id="bno" name="bno" value='<c:out value="${board.bno}"/>'>
						<input type="hidden" id="pageNum" name="pageNum" value='<c:out value="${cri.pageNum}"/>'>
						<input type="hidden" id="amount" name="amount" value='<c:out value="${cri.amount}"/>'>
						<input type="hidden" id="type" name="type" value='<c:out value="${cri.type}"/>'>
						<input type="hidden" id="keyword" name="keyword" value='<c:out value="${cri.keyword}"/>'>
					</form>
				
			</div><!-- panel-body end -->
	</div><!-- col-lg-12 end -->
</div><!-- row end -->

<!-- 댓글 화면 -->
<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-heading">
                <i class="fa fa-comments fa-fw"></i> Reply
                <button id='addReplyBtn' class='btn btn-primary btn-xs pull-right'>New Reply</button>
            </div><!-- <div class="panel-heading"> -->
        <div class="panel-body">
            <ul class="chat">
                <!-- start reply -->
                <li class="left clearfix" data-rno='12'>
                    <div>
                        <div class="header">
                            <strong class="primary-font">user00</strong>
                            <small class="full-right text-muted">2018-01-01 13:13</small>
                        </div>
                        <p>Good Job!</p>
                    </div>
                </li>
                <!-- end reply -->
            </ul><!-- end<ul> -->
        </div><!-- <div class="panel-body"> end-->
        <div class="panel-footer"></div>
        </div><!-- <div class="panel panel-default"> end-->
    </div><!-- <div class="col-lg-12"></div> -->
 </div><!-- <div class="row"> end -->

<!-- 댓글 Modal -->
      <div class="modal fade" id="myModal" tabindex="-1" role="dialog"
        aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
          <div class="modal-content">
            <div class="modal-header">
              <button type="button" class="close" data-dismiss="modal"
                aria-hidden="true">&times;</button>
              <h4 class="modal-title" id="myModalLabel">REPLY MODAL</h4>
            </div>
            <div class="modal-body">
              <div class="form-group">
                <label>Reply</label> 
                <input class="form-control" name='reply' value='New Reply!!!!'>
              </div>      
              <div class="form-group">
                <label>Replyer</label> 
                <input class="form-control" name='replyer' value='replyer'>
              </div>
              <div class="form-group">
                <label>Reply Date</label> 
                <input class="form-control" name='replyDate' value='2018-01-01 13:13'>
              </div>
            </div><!-- modal-body end -->
	  		<div class="modal-footer">
        		<button id='modalModBtn' type="button" class="btn btn-warning">Modify</button>
        		<button id='modalRemoveBtn' type="button" class="btn btn-danger">Remove</button>
        		<button id='modalRegisterBtn' type="button" class="btn btn-primary">Register</button>
        		<button id='modalCloseBtn' type="button" class="btn btn-default">Close</button>
      		</div>          
      	</div>
          <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
      </div>
      <!-- /.modal -->



<!-- 댓글처리 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/reply.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		console.log("==================");
		console.log("JS TEST");
		
		var bnoValue = '<c:out value="${board.bno}"/>';
		var replyUL = $(".chat");
		
		showList(1);				
		
		function showList(page) {
			//console.log("showList page:" + page);
			replyService.getList({bno:bnoValue , page:page||1}, function(replyCnt, list) {
				
				console.log("replyCnt: "+ replyCnt );
			    console.log("list: " + list);
			    console.log(list);
			    
			    if(page == -1){
			      pageNum = Math.ceil(replyCnt/10.0);
			      console.log(pageNum);
			      showList(pageNum);
			      return;
			    }
				
				var str="";
				if (list == null || list.length == 0) {
					replyUL.html("");
					return;
				}//if (list == null || list.length == 0) end
				for (var i = 0, len = list.length || 0; i < len ; i++) {
					str += "<li class='left clearfix' data-rno='"+ list[i].rno+"'>";
					str += "	<div><div class='header'><strong class='primary-font'>" + list[i].replyer + "</strong>";
					str +="    <small class='pull-right text-muted'>"+replyService.displayTime(list[i].replyDate)+"</small></div>";
			        str +="    <p>"+list[i].reply+"</p></div></li>";
				}//for end
			replyUL.html(str);
				
			showReplyPage(replyCnt);	
			})//end function(list)
		} // function showList(page) end
		
		var pageNum = 1;
	    var replyPageFooter = $(".panel-footer");
	    
	    function showReplyPage(replyCnt){
	      
	      var endNum = Math.ceil(pageNum / 10.0) * 10;  
	      var startNum = endNum - 9; 
	      
	      var prev = startNum != 1;
	      var next = false;
	      
	      if(endNum * 10 >= replyCnt){
	        endNum = Math.ceil(replyCnt/10.0);
	      }
	      
	      if(endNum * 10 < replyCnt){
	        next = true;
	      }
	      
	      var str = "<ul class='pagination pull-right'>";
	      
	      if(prev){
	        str+= "<li class='page-item'><a class='page-link' href='"+(startNum -1)+"'>Previous</a></li>";
	      }
	      
	      for(var i = startNum ; i <= endNum; i++){
	        
	        var active = pageNum == i? "active":"";
	        
	        str+= "<li class='page-item "+active+" '><a class='page-link' href='"+i+"'>"+i+"</a></li>";
	      }
	      
	      if(next){
	        str+= "<li class='page-item'><a class='page-link' href='"+(endNum + 1)+"'>Next</a></li>";
	      }
	      
	      str += "</ul></div>";
	      
	      console.log(str);
	      
	      replyPageFooter.html(str);
	    }
	     
	    replyPageFooter.on("click","li a", function(e){
	       e.preventDefault();
	       console.log("page click");
	       
	       var targetPageNum = $(this).attr("href");
	       
	       console.log("targetPageNum: " + targetPageNum);
	       
	       pageNum = targetPageNum;
	       
	       showList(pageNum);
	     });     

		var modal = $(".modal");
	    var modalInputReply = modal.find("input[name='reply']");
	    var modalInputReplyer = modal.find("input[name='replyer']");
	    var modalInputReplyDate = modal.find("input[name='replyDate']");
	    
	    var modalModBtn = $("#modalModBtn");
	    var modalRemoveBtn = $("#modalRemoveBtn");
	    var modalRegisterBtn = $("#modalRegisterBtn");
	    
	    $("#modalCloseBtn").on("click", function(e){
	    	
	    	modal.modal('hide');
	    });
	    
	    $("#addReplyBtn").on("click", function(e){
	      
	      modal.find("input").val("");
	      modalInputReplyDate.closest("div").hide();
	      modal.find("button[id !='modalCloseBtn']").hide();
	      
	      modalRegisterBtn.show();
	      
	      $(".modal").modal("show");
	      
	    });
	    
	    modalRegisterBtn.on("click",function(e){
	        
	        var reply = {
	              reply: modalInputReply.val(),
	              replyer:modalInputReplyer.val(),
	              bno:bnoValue
	            };
	        replyService.add(reply, function(result){
	          
	          alert(result);
	          
	          modal.find("input").val("");
	          modal.modal("hide");
	          
	          //showList(1);
	          showList(-1);
	        });//replyService.add(reply, function(result){end
	    });//modalRegisterBtn.on("click",function(e){ end
	    	
	  	//댓글 조회 클릭 이벤트 처리 
	    $(".chat").on("click", "li", function(e){
	      
	      var rno = $(this).data("rno");
	      
	      replyService.get(rno, function(reply){
	      
	        modalInputReply.val(reply.reply);
	        modalInputReplyer.val(reply.replyer);
	        modalInputReplyDate.val(replyService.displayTime( reply.replyDate))
	        .attr("readonly","readonly");
	        modal.data("rno", reply.rno);
	        
	        modal.find("button[id !='modalCloseBtn']").hide();
	        modalModBtn.show();
	        modalRemoveBtn.show();
	        
	        $(".modal").modal("show");
	            
	      });//replyService.get(rno, function(reply){ end
	    });//$(".chat").on("click", "li", function(e){ end
	    
	    modalModBtn.on("click", function(e){
	        
	        var reply = {rno:modal.data("rno"), reply: modalInputReply.val()};
	        
	        replyService.update(reply, function(result){
	              
	          alert(result);
	          modal.modal("hide");
	          showList(pageNum);	          
	        });//replyService.update(reply, function(result){ end        
	    });//modalModBtn.on("click", function(e){end
	    
	    modalRemoveBtn.on("click", function (e){
	    	  
	    	  var rno = modal.data("rno");
	    	  
	    	  replyService.remove(rno, function(result){
	    	        
	    	      alert(result);
	    	      modal.modal("hide");
	    	      showList(pageNum);	    	      
	    	  });	    	  
	    });
		//get reply - id 4
		/*replyService.get(4, function(data) {
			console.log(data);
		});*/
		
		//update test - id 7
		/*replyService.update(
		{rno:7 , reply:"REPLY MODIFY TEST", replyer:"modifier", bno:bnoValue}, 
		function(count) { //success callback 
			console.log(count);
			if (count === "success") {
				alert("UPDATED");
			} //if (count === "success") { end
		}, //function(count) end
		function(err) { //error callback
			alert("ERROR...");
		} //function(err) end
		); //replyService.update( end */
				
		//delete test - id 6
		/*replyService.remove(6, 
		function(count) { //success callback 
			console.log(count);
			if (count === "success") {
				alert("REMOVED");
			} //if (count === "success") { end
		}, //function(count) end
		function(err) { //error callback
			alert("ERROR...");
		} //function(err) end
		); //replyService.remove( end */

		//get reply
		/*replyService.getList({bno:bnoValue, page:1},
							 function(list){
								 for(var i = 0, len = list.length||0; i < len; i++ ) {
									console.log(list[i]);	 
								 }//for end
							 }//function(list) end
							 )//replyService.getList( end */
		//for replyService add test
		/*replyService.add(
				{reply:"JS TEST", replyer:"tester", bno:bnoValue},
				function(result){
					alert("RESULT: " + result);
				}//function(result){ end
		);//replyService.add( end */
	});
</script>

<!-- 버튼 이벤트 처리 -->
<script type="text/javascript">
	$(document).ready(function() {
		var openForm = $("#openForm");
		$("button[data-oper='modify']").on("click", function(e) {
			openForm.attr("action", "${pageContext.request.contextPath}/board/modify").submit();
		}); /* $("button[data-oper='modify']") end */
		
		$("button[data-oper='list']").on("click", function(e) {
			openForm.find("#bno").remove();
			openForm.attr("action", "${pageContext.request.contextPath}/board/list").submit();
		});

	}); /* ready end */
	
	
</script>


<%@ include file="../includes/footer.jsp" %>
