<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ page import="com.RPlatform.*" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta charset="utf-8">
    <title>RPlatform</title>
    <meta content="IE=edge,chrome=1" http-equiv="X-UA-Compatible">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,700' rel='stylesheet' type='text/css'>
    <link rel="stylesheet" type="text/css" href="lib/bootstrap/css/bootstrap.css">
    <link rel="stylesheet" href="lib/font-awesome/css/font-awesome.css">

    <script src="lib/jquery-1.11.1.min.js" type="text/javascript"></script>

    

    <link rel="stylesheet" type="text/css" href="stylesheets/theme.css">
    <link rel="stylesheet" type="text/css" href="stylesheets/premium.css">

</head>
<body class=" theme-blue">
     <%
     String sql=null;
     if(request.getAttribute("delete")!=null)
     {
        sql="delete analysis_data where input_table='"+request.getAttribute("delete")+"'";
        SQLHelp.update(sql);
        sql="drop table '"+request.getAttribute("delete")+"'";
        SQLHelp.update(sql);
     }
      %>
  

    <script type="text/javascript">
        $(function() {
            var match = document.cookie.match(new RegExp('color=([^;]+)'));
            if(match) var color = match[1];
            if(color) {
                $('body').removeClass(function (index, css) {
                    return (css.match (/\btheme-\S+/g) || []).join(' ')
                })
                $('body').addClass('theme-' + color);
            }

            $('[data-popover="true"]').popover({html: true});
            
        });
    </script>
    <style type="text/css">
        #line-chart {
            height:300px;
            width:800px;
            margin: 0px auto;
            margin-top: 1em;
        }
        .navbar-default .navbar-brand, .navbar-default .navbar-brand:hover { 
            color: #fff;
        }
    </style>

    <script type="text/javascript">
        $(function() {
            var uls = $('.sidebar-nav > ul > *').clone();
            uls.addClass('visible-xs');
            $('#main-menu').append(uls.clone());
        });
    </script>

  

    <div class="navbar navbar-default" >
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="sr-only"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="" href="index.jsp"><span class="navbar-brand"><span class="fa fa-life-ring"></span> RPlato</span></a></div>

       <%
            if((String)request.getSession().getAttribute("username")!=null){                   
        %>
	        <div style="height: 1px;">
	          <ul id="main-menu" class="nav navbar-nav navbar-right">
	            <li class="dropdown hidden-xs">
	                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
	                    <span class="glyphicon glyphicon-user padding-right-small" style="position:relative;top: 3px;"></span><%=request.getSession().getAttribute("username")%>
	                    
	                    <i class="fa fa-caret-down"></i>
	                </a>
	
	              <ul class="dropdown-menu">
	
	                <li><a tabindex="-1" href="login_out.jsp">注销</a></li>
	            </ul>
	            </li>
	          </ul>
	
	        </div>
        <%} %>
      </div>
   


    <div class="sidebar-nav">
        <ul>
            <li><a href="index.jsp" class="nav-header"><i class="fa fa-home"></i> 首页</a></li>

                <li ><a  href="#"  data-target=".accounts-menu" class="nav-header collapsed" data-toggle="collapse"><i class="fa fa-user"></i> 账户<span class="label label-info">+2</span></a></li>
                <li ><ul class="accounts-menu nav nav-list collapse">
                  <%
                    if((String)request.getSession().getAttribute("username")==null){                   
                   %>
                  <li ><a  id="user_login" href="sign-in.html"><span  class="fa fa-caret-right"></span> 登陆</a></li>
                <%} %>
                <li ><a href="sign-up.html"><span class="fa fa-caret-right"></span> 注册</a></li>          
                <%
                   if((String)request.getSession().getAttribute("username")!=null){                   
                %>
                <li ><a  id="user_reset"  href="reset-password.html"><span class="fa fa-caret-right"></span>重置密码 </a></li>
                 <%}%>
            </ul></li>
            <%
            if((String)request.getSession().getAttribute("username")!=null){                   
             %>
            <li><a href="analysis.jsp?first=1" class="nav-header"><i class="fa fa-bar-chart-o"></i>数据分析</a></li>

            <li><a href="result.jsp" class="nav-header"><i class="fa fa-columns"></i>分析结果</a></li>
             <%} %>
            <li><a href="#" data-target=".legal-menu" class="nav-header collapsed" data-toggle="collapse"><i class="fa fa-fw fa-legal"></i> 法律信息<i class="fa fa-collapse"></i></a></li>
            <li><ul class="legal-menu nav nav-list collapse">
                <li ><a href="privacy.jsp"><span class="fa fa-caret-right"></span> 隐私政策</a></li>
                <li ><a href="terms.jsp"><span class="fa fa-caret-right"></span> 南航1613001班一队条款</a></li>
            </ul></li>

        </ul>
    </div>




    <div class="content">
        <div class="header">
            
            <h1 class="page-title">数据分析</h1>
                    <ul class="breadcrumb">
            <li><a href="index.jsp">首页</a> </li>
            <li class="active">数据分析</li>
        </ul>

        </div>
        <div class="main-content">
        
        <form method="POST" name="form1" id="form1" action="analysis.jsp">  
           <div class="form-group">
                <label>选择算法</label>
                 <%
			      if((String)request.getParameter("algorithm")!=null)
			      {
			         %>
			         <select name="algorithm" id="algorithm" class="form-control" onchange="document.form1.submit();">
                    <option value="1" ${param.algorithm eq  '1' ? 'selected="selected"':''}>多元线性回归</option>
                    <option value="2" ${param.algorithm eq  '2' ? 'selected="selected"':''}">K_means</option>
                    <option value="3" ${param.algorithm eq  '3' ? 'selected="selected"':''}">NaiveBayes</option>                 
                    <option value="4" ${param.algorithm eq  '4' ? 'selected="selected"':''}">PCA</option>           
                     </select>
			         <%  
			      }
			      else
			      {
			       %>
			        <select name="algorithm" id="algorithm" class="form-control">
                    <option selected="selected" value="1">多元线性回归</option>
                    <option value="2">K_means</option>
                    <option value="3">NaiveBayes</option>                 
                    <option value="4">PCA</option>           
                     </select>
			       <%
			      }
			      %>
               
            </div>
            <div class="form-group">
                <label>选择已导入的数据</label>
                <select name="imported_data" id="imported_data" class="form-control" onchange="document.form1.submit();">
                <%
                   sql="select * from analysis_data where username='"+session.getAttribute("username")+"'";
                   ResultSet st=SQLHelp.query(sql);
                   String input_table=null;
                   int i=1;
                   if((String)request.getParameter("imported_data")!=null)
                   {//显示选中的
                       i=1;
                      while(st.next())
	                   {
	                     int selected=Integer.valueOf(request.getParameter("imported_data"));
	                     if(selected==i)
	                      {%>
	                           <option value="<%=i%>" selected="selected"><%=st.getString("input_table")%></option>
	                      <%   input_table=st.getString("input_table");
	                      }
	                      else
	                      {%>
	                           <option value="<%=i%>" ><%=st.getString("input_table")%></option>
	                      <%}
	                      i++;
	                    
	                   }%>
	                   <% 
                   }
                   else
                   {//显示最新的
                          i=1;
	                   while(st.next())
	                   {
	                      if(st.isLast())
	                      {%>
	                           <option value="<%=i%>" selected="selected"><%=st.getString("input_table")%></option>
	                      <%   input_table=st.getString("input_table");
	                      }
	                      else
	                      {%>
	                           <option value="<%=i%>" ><%=st.getString("input_table")%></option>
	                      <%}
	                      i++;
	                   }
	                   %>
	                   <%
                   }
                   st.close();
                 %> </select>
                
            </div>
           
             
             
             
			<div class="btn-toolbar list-toolbar">
				<a class="btn btn-primary" href="#" style="display:inline-block; position:relative; overflow:hidden;">
				    <input type="file"  accept=".xls,.xlsx" style="position:absolute; right:0; top:0; font-size:100px; opacity:0; filter:alpha(opacity=0);"/>
				<i class="fa fa-plus"></i> 加载数据</a>
			    <input type="button" class="btn btn-default" data-target=".set" data-toggle="collapse" value="参数设置"/>
 
			      <%
			      if((String)request.getParameter("algorithm")!=null)
			      {
				      if(((String)request.getParameter("algorithm")).equals("1"))
				      {//多元线性回归
				          %>
				          <ul class="set nav nav-list collapse">    
				          <br/> 
				         <input type="submit" class="btn btn-default" value="开始"/>             
				        </ul>    
				          <% 
				      }
				      else if(((String)request.getParameter("algorithm")).equals("2"))
				     {//k_means
					     %>
					      <ul class="set nav nav-list collapse">    
					         <br/>        
					         <label>聚类簇数</label>
					         <input type="text" class="form-control" style="width:100px"/>
					          <br/> 
					         <input type="submit" class="btn btn-default" value="开始"/>             
					      </ul>   
					     <%
				     }
				      else if(((String)request.getParameter("algorithm")).equals("3"))
				     {//NaiveBayes
					     %>
					      <ul class="set nav nav-list collapse">    
					       
					          <br/> 
					         <input type="submit" class="btn btn-default" value="开始"/>             
					      </ul>   
					     <%
				     }
				      else if(((String)request.getParameter("algorithm")).equals("4"))
				     {//PCA
					     %>
					      <ul class="set nav nav-list collapse">      
					          <br/> 
					          <label>目标空间维数</label>
					         <input type="text" class="form-control" style="width:100px"/>
					          <br/> 
					         <input type="submit" class="btn btn-default" value="开始"/>             
					      </ul>   
					     <%
				     }
			      }%>
			</div>
		   </form>
		<%
		if(input_table!=null)
		{ %>
		<label>部分测试数据:</label>
		<input type="button" class="btn btn-primary pull-right" value="删除测试数据" onclick="window.location.herf='analysis.jsp?delete='<%=input_table%>"/>
          <table class="table">
                <thead>
                <% 
                  sql="select  * from `"+input_table+"` limit 10 ";
                  st=SQLHelp.query(sql); %>
                   <tr>
                  <%
                     for(i=0;i<=st.getMetaData().getColumnCount()&&i<=10;i++)
                     {
                        if(i==0)
                        {%>
                         <th>#</th>
                        <% }
                        else
                        {%>
                         <th><%=i%></th>
                        <% }
                     }
                   %>
                </tr>
                </thead>
                <tbody>
                 <% 
                  int row=0;
                  while(st.next())
                  {
                     row++;
                   %>
	                   <tr>
	                     <%
	                        for(i=0;i<=st.getMetaData().getColumnCount()&&i<=10;i++) 
	                        {
	                          if(i==0)
	                          {%>
	                          <td><%=row%></td>
	                          <%}
	                          else
	                          {%>
	                          <td>[<%=st.getString(i)%>]</td>
	                          <% }   
	                        }
	                     %>
	                   </tr>
                   <%
                  }st.close();
                  %>
                  
                </tbody>
            </table>
            <%}
            %>
 

<div class="modal small fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            <h3 id="myModalLabel">Delete Confirmation</h3>
        </div>
        <div class="modal-body">
            <p class="error-text"><i class="fa fa-warning modal-icon"></i>Are you sure you want to delete the user?<br>This cannot be undone.</p>
        </div>
        <div class="modal-footer">
            <button class="btn btn-default" data-dismiss="modal" aria-hidden="true">Cancel</button>
            <button class="btn btn-danger" data-dismiss="modal">Delete</button>
        </div>
      </div>
    </div>
</div>


            <footer >
                <hr >
                <p class="pull-right"> <a  target="_blank">RPlato</a> 由 <a href="team-info.html" target="_blank">南航1613001班一队</a>设计</p>
                <p>© 2015 <a href="team-info.html" target="_blank">南航1613001班一队</a></p>
            </footer>
        </div>
    </div>


    <script src="lib/bootstrap/js/bootstrap.js"></script>
    <script type="text/javascript">
        $("[rel=tooltip]").tooltip();
        $(function() {
            $('.demo-cancel-click').click(function(){return false;});
        });
    </script>
    <script type="text/javascript">
         window.onload=function()
         {
           var first=<%=request.getParameter("first")%>;
           if(first=="1")
             document.getElementById('form1').submit();
         }
    </script>

</body></html>
