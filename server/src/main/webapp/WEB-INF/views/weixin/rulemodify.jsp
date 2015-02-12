<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ page session="false"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html >
<head>

<title>微信规则add</title>
<style type="text/css">
.jumbotron {
	background-color: rgba(17, 17, 16, 0.08);

}
table.table.table-hover.table-bordered{
margin-left:30px;
}
table td,table th{text-align:center}
</style>
<script src="${ctx}/static/layer1.7.0/layer.min.js"></script>

<script type="text/javascript">


function alertdivtodo(data,id){


	
	//发送   ajax  data  拼成 一个页面    
	$.ajax({
			url: '${ctx}/'+data, 
			type: 'GET',
			contentType: "application/json;charset=UTF-8",
			dataType: 'json',
			success: function(data){
			
				var parray=new Array();
				$.each(data,function(key,value){
		//根据key的类型，不同的处理		
					if(key=="ppp"){
		//获得属性放入数组			
				$.each(value,function(i,n){
					parray[i]=n;
				});
					}
				});	
		
				var tarray=new Array();
		//获得value值放入数组		
				$.each(data,function(key,value){
					if(key!="ppp"){
				var varray=new Array(parray.length);
						$.each(value,function(i,n){
							varray[i]=n;
						});
						tarray.push(varray);
						
					}
					
				});
				
			
			//拼出弹出框页面
           var html="<br/><br/><table   class='table table-hover table-bordered' style='table-layout: fixed;word-wrap:break-word; width:400px;height: 200px	'><thead><tr><th>选择</th>";
				var html1="";
				var html2="";
				var html3="</tr></thead><tbody class='junzee'>";
				var html4="</tr></tbody></table><div>&nbsp;<button type='button' class='btn btn-primary' id='11'>选择</button></div>";
				var totalhtml;
				  for(var i=0;i<parray.length;i++){
			   var html6="<th>";
			   //Id一列不显示
					  if(i==0){
						  html6="<th style='display:none;'>";
					  }
					  html1+=html6+parray[i]+"</th>";
						}
				  for (var i=0;i<tarray.length;i++){
					  
					  var darray= tarray[i];

					 var html5="";	
					  for(var j=0;j<darray.length;j++){
						  var html6="<td>";
						  if(j==0){
							  html6="<td style='display:none;'>";
						  }
					  html5+=html6+darray[j]+"</td>";
					  
					  }

					
					  html2+="<tr class='info warning'><td><input type='radio' name='optionsRadios' id='optionsRadios1' value="+darray[0]+","+darray[1]+"></td>"+html5+"</tr>";
				  }
			 
			     totalhtml=html+html1+html3+html2+html4;
		
			 	$("#text").html(totalhtml);
					

			//触发弹出框	
				var indexx=  $.layer({
						    type: 1,
						    title: false,
						    offset: ['15px' , ''],
						    area: ['450px', '600px'],
						    shade: [0],
						    
						   page : {dom : '#text'}
						    	
						    , success: function(){
					//成功后执行,点击选择触发的方法		
								 layer.shift('right');
								 $('#11').click(function(){ 
									//获得被选择的值放入input中
									  var a=$('input[name="optionsRadios"]:checked').val();
									  
								     
									  var arrok= a.split(",");
									  //显示中文
							         $("#"+id).val(arrok[1]);
							         
									  //传值是id  ？how to do？
							        // $("input[class='form-control  alertval']").val(arrok[0]);
									  
							         $("#"+id+"val").val(arrok[0]);
							         
						
							         
					//关闭弹框		         
					     
							       layer.close(indexx);
									});
									
						    }
						});	
				
					
				}
				});
	
}
//------------------------------------------------------------------------------------------------

$(function(){


	// -----------------------------------修改的数据回显  START -------------------------------------
	
	//回复类型
	var backtype="${rule.wpCategory}";

	if(backtype=="text"){
		$("#selectStr").html("文本");
	}else if(backtype=="url"){
		$("#selectStr").html("连接");
	}else if(backtype="biz"){
		$("#selectStr").html("业务");
	}
	
	$("#"+"${rule.wpCategory}"+"Wrap").show();
	//TODO
	//TODO

	if("${rule.wpCategory}"=="biz"){
		//业务--------------------//业务模块选中
		
		$("#bizCode").val("${rule.bizCode}");
		// 方法   
		//TODO  应该把该bizcode 的所有method 拿过来遍历，然后选中 保存的那个
		$("#proxyInterface").append(new Option( "${rule.chineseProxyInterFace}","${rule.proxyInterface}"));
		
		
		//参数
		//数据库的参数  ,转换成  数组， 然后循环的时候  取值
		  var dbparas =  "${rule.params}";
		  var arrpara= dbparas.split(",");

		//单独发送  请求    获取当前 rule的，所有的参数 对象
		$.getJSON("${ctx}/mgr/weixin/rules/modify/getallpara?id=${rule.id}",function(data){
			//回调函数接收返回的 json 格式数据data
			
			$.each( data,function(index,paraobj){

			
				
				
				if(paraobj.type=="hidden"){			
					$("#paraminp").append("<div    style='display:none'  class='col-xs-3'><label style='font-size: x-small;' >"+paraobj.enName+"</label> <br /><input     value="+arrpara[index]+"   disabled='disabled' name="+paraobj.zhName+"  type='text' class='form-control'		placeholder='"+"id不需要输入"+"'></div>");				
				}else if(paraobj.type=="alert"){
					//显示中文    ，去除这个筛选   not
					$("#paraminp").append("<div class='col-xs-3'><label style='font-size: x-small;' >"+paraobj.enName+"</label> <br /><input  readonly=‘true’   id='"+index+"'   type='text'  class='form-control notservice'		placeholder='"+arrpara[index]+"'> <a onclick='alertdivtodo(\""+paraobj.handle+"\" ,"+"\""+index+"\""+" )'	>选择</a></div>");
					//把id 传入到后台 ！！
					$("#paraminp").append("  <div     style='display:none'  class='col-xs-3'> <input       value="+arrpara[index]+"    id='"+index+"val'  name="+paraobj.zhName+"  type='text' class='form-control  alertval' />	</div>"); 
					
				}else{
					$("#paraminp").append("<div class='col-xs-3'><label style='font-size: x-small;' >"+paraobj.enName+"</label> <br /><input        value="+arrpara[index]+"  name="+paraobj.zhName+"  type='text' class='form-control'		placeholder='"+paraobj.description+"'></div>");
				}
				
				
			});
			
			
			//把参数放到隐藏域中
			$("#allparamname").val("");
			$("#paraminp .col-xs-3 input, #paraminp .col-xs-3 select ").not( "input[class='form-control notservice']").each(function(){
				var Pname= $("#allparamname").val();
			    $("#allparamname").val(Pname+$(this).attr("name")+',');
			    
			});
			
			
			
			
	     });
	

	}else if("${rule.wpCategory}"=="text"){
		$("#textinput").text("${rule.text}");
		
	}else if ("${rule.wpCategory}"=="url"){
		$("#urlinput").val("${rule.text}");
	}else{
		
	}
	
	// -----------------------------------修改的数据回显  END -------------------------------------
	
	

	
		

		//asone moify begin.
		$(".wp_category_select").bind("click", function(){
			var value = $(this).attr("data-value");
			var str = $(this).html();
			$("#selectStr").html(str);
			$(".hiddenWrap").hide();
			$("#"+value+"Wrap").show();
			
			//把业务的类型也放到隐藏域
			
			   $("#wpCategory").val("");
				$("#wpCategory").val(value);
		});
		
		$("#bizCode").change(function(){
			$.ajax({
				url: '${ctx}/mgr/weixin/keywords/beanname?bizcode='+ $(this).val(), 
				type: 'GET',
				contentType: "application/json;charset=UTF-8",
				dataType: 'json',
				success: function(data){
					
					$("#proxyInterface").empty();
					$("#paraminp").empty();
					
					
					$("#proxyInterface").append(new Option("请选择调用业务方法", ""));
					$.each( data,function(key,value){
						$("#proxyInterface").append(new Option(value, key));
					});
				},error:function(xhr){
					alert('内部服务发生错误，请联系管理员！！！！');
				}}
			);
		});
		
		//method -------params
		$("#proxyInterface").change(function(){
			$.ajax({
				url: '${ctx}/mgr/weixin/keywords/methodname?bizcode=' + $("#bizCode").val() +'&methodname='+ $("#proxyInterface").val(), 
				type: 'GET',
				contentType: "application/json;charset=UTF-8",
				dataType: 'json',
				success: function(data){
					
					
					$("#paraminp").empty();
					
					
					//把业务方法  保存，然后用于显示中文
					//TODO

					
					$.each( data,function(index,paraobj){
						if(paraobj.type=="hidden"){			
							$("#paraminp").append("<div    style='display:none'  class='col-xs-3'><label style='font-size: x-small;' >"+paraobj.enName+"</label> <br /><input    disabled='disabled' name="+paraobj.zhName+"  type='text' class='form-control'		placeholder='"+"id不需要输入"+"'></div>");				
						}else if(paraobj.type=="alert"){
							//显示中文    ，去除这个筛选   not
							$("#paraminp").append("<div class='col-xs-3'><label style='font-size: x-small;' >"+paraobj.enName+"</label> <br /><input  readonly=‘true’   id='"+index+"'   type='text'  class='form-control notservice'		placeholder='请选择分类'> <a onclick='alertdivtodo(\""+paraobj.handle+"\" ,"+"\""+index+"\""+" )'	>选择</a></div>");
							//把id 传入到后台 ！！
							$("#paraminp").append("  <div     style='display:none'  class='col-xs-3'> <input      id='"+index+"val'  name="+paraobj.zhName+"  type='text' class='form-control  alertval' />	</div>"); 
							
						}else{
							$("#paraminp").append("<div class='col-xs-3'><label style='font-size: x-small;' >"+paraobj.enName+"</label> <br /><input    name="+paraobj.zhName+"  type='text' class='form-control'		placeholder='"+paraobj.description+"'></div>");
						}
					});
					
					//把参数 name  后台  通过 name  来取值 放到隐藏域中	
					  $("#allparamname").val("");
						$("#paraminp .col-xs-3 input, #paraminp .col-xs-3 select ").not( "input[class='form-control notservice']").each(function(){
							var Pname= $("#allparamname").val();
						    $("#allparamname").val(Pname+$(this).attr("name")+',');
						    
						});
						
						
						
						//把业务的类型也放到隐藏域, 到了这边说明  就是业务了
						   $("#wpCategory").val("");
							$("#wpCategory").val("biz");

				},error:function(xhr){
					alert('内部服务发生错误，请联系管理员！！！！');
				}}
			);
		});
		

		


	
	
	
	
	
	
	

	

});


</script>
<script type="text/javascript">
//弹出连接

	
function addurl(){
	
	
	
	var  uurl = $('#InfoModal input:radio:checked').val(); 
	

	
	$("#closego").trigger("click");
	
	$("#urlinput").val(uurl);
	
}
	

	




</script>




</head>
<body >


<a style="display: inline-block;"></a>
<div id="text" style="display: none; ">
</div>
	<div class="row">
		<div class="col-md-2"  >
			<%@ include file="nav.jsp"%>
		</div>
		<div class="col-md-10 ">
			<div class="bs-callout bs-callout-info">
				<h4>微信规则设置</h4>
				<p>用于登记微信平台规则内容。</p>
			</div>

				<form:form role="form" method="post" modelAttribute="rule" action="${ctx}/mgr/weixin/rules/modify/save">
					
					<!-- 隐藏域 -->

					<input  type="hidden"   id="allparamname"    name="allpara" />
					<input  type="hidden"   id="wpCategory"    value="${rule.wpCategory}"  name="wpCategory" />
					<input  type="hidden"   id="chinesename"    name="chinesename" />
					<input  type="hidden"   id="ruleid"    name="ruleid"   value="${rule.id }"/>
					
					
					
					<div class="form-group">
						<label for="title">规则名称</label> 
						<input   value="${rule.title}" type="text" class="form-control" id="title" name="rulename">
					</div>
					
					
                 	<div class="form-group">
						<label for="title">回复类型</label> 
						<div class="catWrap">
							<div class="input-group">
					          <div class="input-group-btn">
					            <button   type="button" class="btn btn-default" tabindex="-1" id="selectStr">选择回复类型</button>
					            <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" tabindex="-1"    >
					              <span class="caret"></span>
					              <span class="sr-only">Toggle Dropdown</span>
					            </button>
					            <ul class="dropdown-menu" role="menu">
						            <c:forEach items="${wpCategories}" var="category">
						              <li><a href="#" data-value="${category.key }" class="wp_category_select">${category.value}</a></li>
						             </c:forEach> 
					            </ul>
					          </div>
					        </div>
						</div>
					</div>
					
					<div class="form-group hiddenWrap" id="textWrap" >
						<label for="title">输入回复文本内容</label> 
						<textarea id="textinput" name="text" class="form-control"   rows="4" placeholder="例：欢迎关注微信号"></textarea>	
					</div>
					
					<div class="form-group hiddenWrap" id="urlWrap">
						<label for="title">输入回复链接地址</label> 
						<div class="input-group">
							<input id="urlinput" name="url" class="form-control" type="text" placeholder="http://www.example.com/m/index.do"/>
				          <div  class="input-group-btn">
				          	<button   id="urlalert"   type="button"    data-toggle='modal' data-target='#InfoModal'  class="btn btn-default">可选业务模块</button>
				          </div>
					    </div>
					</div>
					
					<div class="hiddenWrap" id="bizWrap">
						<div class="form-group">
							<label for="bizCode">业务服务</label> 
							<select name="bizCode" id="bizCode" class="form-control">
								<option>选择业务服务模块</option>
								<c:forEach items="${authedBizCodes}" var="dict">
						              <option value="${dict.key}">${dict.value}</option>
						        </c:forEach> 
							</select>
						</div>
						
						<div class="form-group">
							<label for="bizCode">选择业务方法</label> 
							<select  name="proxyInterface" id="proxyInterface" class="form-control" >
							</select>
						</div>
						<div class="form-group" id="paramsWrap">
						
						</div>
						
						<div      id="paramget" class="form-group">
						<label for="keywords">所有参数</label> <br />
						<div   id="paraminp"  class="row">
						<!-- 遍历这边的input    获取到  input中  name 的值 -->


						</div>
					</div>
					</div>

					
					
					<br />
					<button type="submit" class=" btn btn-primary">确认修改规则</button>
					<button style="margin-left: 50px" type="button"
						class=" btn btn-success"   onclick="history.back();">返回上一级</button>
				</form:form>

		</div>
	</div>
	
	
	
	<!--    弹出框    START -->





<div class="modal fade" id="InfoModal"      tabindex="-1" >
<div class="modal-dialog" style="width:800px;">
<div class="modal-content">
    <div class="modal-header">
    <button type="button" class="close"    id="closego" data-dismiss="modal" >&times;</button>
    <h4 class="modal-title" id="myModalLabel">添加信息</h4><span id="error" class="label label-danger"></span>
    </div>
    <div class="modal-body">
       
  
      <form class="navbar-form navbar-left" method="get" action="#">
        <div class="form-group">
          &nbsp;&nbsp;&nbsp;&nbsp;<label>模块名称：</label> 
          <input name="search_LIKE_word" value="" type="text" class="form-control" placeholder="输入查找的名称">
        </div>
         
        <button type="submit" class="btn btn-default">查找</button>
      </form>
      <br/><br/><br/>
      
      
      <table   style="width: 700px;" class="table table-hover table-bordered">
				<thead>
					<tr>
						<th  style="width: 70px;">
						请选择
						</th>
						<th>
						模块名称
						</th>
						<th>
					   模块代码
						</th>

					</tr>
				</thead>
				<tbody>
				
				<c:forEach items="${res}"  var="oneres">
				<tr>
						<td>
						<input type="radio" name="optionsRadios"  value="${oneres.target}">
						</td>
						<td>
						  ${oneres.title}
						</td>
						<td>
							  ${oneres.bizCode}
						</td>


					</tr>
				
				</c:forEach>
					
					
					
				</tbody>
			</table>
			
			 <br/>
       &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
       <ul class="pagination">
           <li><a href="#">&laquo;</a></li>
           <li class="active"><a href="#">1</a></li>

            <li><a href="#">&raquo;</a></li>
        </ul>
       
        
        
    </div>
    <div class="modal-footer">
    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
    <button type="button" class="btn btn-primary" onclick="addurl()">提交数据</button>
    </div>
</div>
</div>
</div>  
<!--    弹出框    END -->
	
	

</body>



</html>