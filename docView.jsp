<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />



<title><spring:message code="common.docTitle"/></title>
<link rel="stylesheet" type="text/css" href="css/wizen_common.css"/>
<link rel="stylesheet" type="text/css" href="css/jquery-ui.css" />



<script type="text/javascript" src="js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="js/jquery-ui.js"></script>
<script type="text/javascript" src="js/docView.js"></script>
<script type="text/javascript" src="js/wizenFileDownload.js"></script>

<script type="text/javascript">
var judgeDetailDialog=null;
function judgeDetailDialogOpen(docno, procseq){
   	if (judgeDetailDialog==null) {
   		judgeDetailDialog = $( "#judgeDetailDialog" ).dialog({
   			autoOpen : false,
			resizable : false,
			draggable: false,
			resizable: false,
   		    /* height: 800, */
   		    width: 1200,
   		 	open : function() {
				$(this).parents('.ui-dialog').attr(
						'tabindex', -1)[0].focus();
			},
			modal : true
   		});
   		$(".ui-dialog-titlebar" ).css("display", "none" );
   		$("#judgeDetailDialog").css("padding", "0px");
   	}
   	
	 
	//window.open("popupSignPath.dmn", "", "width=900px,height=580px,top=0px,left=200px,status=,resizable=false,scrollbars=true");
	$.ajax({
		url: "popupJudgeDetail2.dmn",
	  	cache: false,
	  	data: {
	  		docno: docno,
	  		procseq: procseq
	  	}
	}).done(function(data){
		$("#judgeDetailDialog").html(data);
		judgeDetailDialog.dialog( "open" );
	})	
}


function fn_judgeDetailDialogClose(){
	judgeDetailDialog.dialog( "close" );	
	window.parent.jQuery('#judgeDetailDialog').dialog('close');
}

var doclikeDialog=null;
function getDocLikeList(docno){
	
   	if (doclikeDialog==null) {
   		doclikeDialog = $( "#doclikeDialog" ).dialog({
   			autoOpen : false,
			resizable : false,
			draggable: false,
			resizable: false,
   		    width: 400,
   		 	open : function() {
				$(this).parents('.ui-dialog').attr(
						'tabindex', -1)[0].focus();
			},
			modal : true
   		});
   		$(".ui-dialog-titlebar" ).css("display", "none" );
   		$("#doclikeDialog").css("padding", "0px");
   		
   		$('html, body').css({'overflow': 'hidden', 'height': '100%'}); 
   		$('#element').on('scroll touchmove mousewheel', function(event) { 
   		    event.preventDefault();
   		    event.stopPropagation();

   		    return false;
   		});
   	}
   	
	//window.open("popupSignPath.dmn", "", "width=900px,height=580px,top=0px,left=200px,status=,resizable=false,scrollbars=true");
	$.ajax({
		url: "docLikeList.dmn",
	  	cache: false,
	  	data: {
	  		docno: docno,
	  	}
	}).done(function(data){
		$("#doclikeDialog").html(data);
		doclikeDialog.dialog( "open" );
	})	
}


function closeDocLikeList(){
    $('html, body').css({'overflow': 'auto', 'height': '100%'}); 
	doclikeDialog.dialog( "close" );	
	window.parent.jQuery('#doclikeDialog').dialog('close');
}
</script>

</head>
<body>

<div id="wrap">
      <!-- (s) header -->
      <header id="header">
			<jsp:include page="/jsp/common/wizen_head.jsp" />
      </header>
      <!-- //header (e) -->
      
      <!-- (s) container -->
      <section id="contents">
        <!-- (s) contentArea -->
        <div id="contentArea">
        
          <jsp:include page="menuLeft.jsp" />
          
          <div id="contents_wrap">
                <div class="conwrap">
                
                    <!-- 타이틀 -->
                    <div class="h3group">
                        <h3 class="tit">나의제안기록</h3>
                        <div class="location">
                            <ul>
                                <li><a href="#" title="메인으로"><img src="images/common/icon_location_home.png" alt="메인으로"></a></li>
                                <jsp:include page="menuSub.jsp" />  
                                <li>나의제안기록</li>
                            </ul>
                        </div>
                    </div>
                    <!-- //타이틀 -->
                    
                    
                    <!-- (s) lnbTypeContentArea  -->
                    <div class="lnbTypeContentArea">
                    
                    <!-- 버튼 -->
                    <div class="mypit">
					    <h5 class="tit"><c:out value="${docInfo.docid}"/></h5>
						<div class="fr">
							<a class="btn middle02 ico_list blue" href='myIdeaList.dmn?page=<c:out value="${page}"/>' ><span>목록</span></a>
							<c:if test="${docInfo.usersq==sessionScope.usersq && docInfo.mainingcd<6 && docInfo.cnt==0 && chkRelateBtn==null}">
								<a class="btn middle02 ico_revise" href="myIdeaListWizenModify.dmn?docno=<c:out value="${docno}"/>"><span>수정</span></a>
							    <a class="btn middle02 ico_delete" href="#" onclick="fn_docDelete(<c:out value="${docno}"/>)"><span>삭제</span></a>
							</c:if>
							<c:if test="${docInfo.usersq==sessionScope.usersq && docInfo.mainingcd==5}">
								<a class="btn middle02 ico_revise" href="myIdeaListWizenModify.dmn?docno=<c:out value="${docno}"/>"><span>수정</span></a>  
							</c:if>
							<a class="btn middle02 ico_print" href="#" onclick="fn_print(<c:out value="${docInfo.docno}"/>)"><span>인쇄</span></a>
							<c:choose>
								<c:when test='${docInfo.real_sswritersq!=sessionScope.usersq}'>
									<a class="btn middle02 ico_scrap" href="myBookmarkAdd.dmn?docno=<c:out value="${docInfo.docno}"/>"><span>스크랩</span></a>
								</c:when>
							</c:choose>	
							<!-- <a class="btn middle02 ico_excel"><span>엑셀</span></a> -->
							
						</div>
						
					</div>
                    <!-- //버튼 -->
                    
                    <jsp:include page="/jsp/wizen/popupDocView.jsp" />
                    
                     <!-- 테이블영역 -->
                     <div class="tblwrap">
						<jsp:include page="/jsp/wizen/docViewSub.jsp"/>
					</div>
                     <!-- //테이블영역 -->
                        
                    </div>
                    <!-- //lnbTypeContentArea (e) -->                
                       	 
                </div>
          </div>
          
        </div>
        <!-- //content (e) -->
        <div id="div_file" style="display:none; position:absolute; background-color:white; border:2px solid #e1e1e1; padding:5px; text-align:left;z-index:20;"></div>
      </section>      
      <!-- //container (e) -->  
          
      <!-- (s) footer -->
	   <jsp:include page="/jsp/common/wizen_footer.jsp" />
	  <!-- //footer (e) -->
</div>
<div id="judgeDetailDialog" style="display: none; padding: 0px; overflow: hidden;"></div>
<div id=doclikeDialog style="display: none; padding: 0px; overflow: hidden;"></div>
</body>
</html>
