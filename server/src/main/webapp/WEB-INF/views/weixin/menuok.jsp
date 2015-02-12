<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page session="false"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html >
<head>
	<title>微信关键字list</title>
<link href="${ctx}/static/zebra_tooltips/zebra_tooltips.css" type="text/css" rel="stylesheet" />
<script src="${ctx}/static/zebra_tooltips/zebra_tooltips.js" type="text/javascript"></script>
<script src="${ctx}/static/zebra_tooltips/zebra_tooltips.src.js" type="text/javascript"></script>

	
</head>
<body >
	<div class="row">
		<div class="col-md-2">
			<%@ include file="nav.jsp"%>
		</div>	
		<div class="col-md-10 ">
	
		
		
			<div class="bs-callout bs-callout-info">
			<h4   style="color: #222;">微信菜单 
			     
			 </h4>
				
				<p >微信菜单 返回结果</p>
			</div>
			<br/><br/><br/><br/>
           <div class="alert alert-success" role="alert"> 您的菜单已经<strong>成功</strong>同步至微信平台  ！  ^_^       &nbsp;   <kbd>稍等1分钟，可以在公众账号上看到效果</kbd></div>
			
			
			   <br/>
           <br/>
           <div >
	          <a    href="${ctx}/"><button id="jun" type="button" class="btn btn-success"	>回到主页</button></a>
		
		       <a href="${ctx}/mgr/weixin/menuIndex"> <button type="button" class="btn btn-warning"   style="margin-left: 50px" >返回微信菜单</button></a>
           </div>
			
			
				
		</div>
		
		

		
		
	</div>
	
</body>
</html>