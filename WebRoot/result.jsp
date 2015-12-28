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
        sql="delete analysis_record where output_table='"+request.getAttribute("delete")+"'";
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

   

    <div class="navbar navbar-default" role="navigation">
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
	        <div  navbar-collapse collapse" style="height: 1px;">
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
    </div>


    <div class="sidebar-nav">
        <ul>
            <li><a href="index.jsp" class="nav-header"><i class="fa fa-home"></i> 首页</a></li>

                <li ><a a href="#"  data-target=".accounts-menu" class="nav-header collapsed" data-toggle="collapse"><i class="fa fa-user"></i> 账户<span class="label label-info">+2</span></a></li>
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
            
            <h1 class="page-title">分析结果</h1>
                    <ul class="breadcrumb">
            <li><a href="index.jsp">首页</a> </li>
            <li class="active">分析结果</li>
        </ul>

        </div>
        <div class="main-content">

          <form id="form1" name="form1" action="reuslt.jsp">
            <div class="form-group">
                <label>历史记录</label>
                <select name="history_record" id="history_record" class="form-control" onchange="document.form1.submit();">
                <%
                   sql="select * from analysis_record where username='"+(String)request.getSession().getAttribute("username")+"'";
                   ResultSet st=SQLHelp.query(sql);
                   String output_table=null;
                   int i=1;
                  if((String)request.getParameter("history_record")!=null)
                  {//显示选中的
                     while(st.next())
                     {
                       int selected=Integer.valueOf(request.getParameter("history_record"));
                       if(selected==i)
                       {%>
                        <option value="<%=i%>" selected="selected"><%=st.getString("output_table")%></option>    
                       <%
                         output_table=st.getString("output_table");
                       }
                       else
                       {%>
                        <option value="<%=i%>"><%=st.getString("output_table")%></option>    
                       <%}
                       i++;
                     }
                  }
                  else
                  {//显示最新的
                    while(st.next())
                     {
                       if(st.isLast())
                      {%>
                        <option value="<%=i%>" selected="selected"><%=st.getString("output_table")%></option>    
                      <%
                         output_table=st.getString("output_table");
                      }
                      else
                      {
                      %>
                        <option value="<%=i%>"><%=st.getString("output_table")%></option>    
                      <%}
                      i++;
                     }
                  }
                  st.close();
                 %>   
                </select>
            </div>
          </form>
<div class="btn-toolbar list-toolbar">


    <button class="btn btn-default">数据结果导出</button>
    <button class="btn btn-default">图片结果导出</button>
  <div class="btn-group">
  </div>
</div>
     
       <%if(output_table!=null)
       {%>
         <label>部分分析结果:</label>
         <input type="button" class="btn btn-primary pull-right" value="删除分析结果" onclick="document.location.herf='result.jsp?delete='<%=output_table%>"/>
          <table class="table">
                <thead>
                <% 
                  sql="select  * from `"+output_table+"` limit 10 ";
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
                         <th><%=st.getMetaData().getColumnName(i)%></th>
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

            <div class="panel panel-default">
                <p class="panel-heading">图片结果</p>
                <div class="panel-body gallery">
                    <img src="images/regre.jpg" class="img-polaroid">
                    <div class="clearfix"></div>
                </div>
            </div>


            <footer>

                <hr>
                <!-- Purchase a site license to remove this link from the footer: http://www.portnine.com/bootstrap-themes -->
                <p class="pull-right"> <a  target="_blank">RPlato</a> 由 <a href="team-info.html" target="_blank">南航1613001班一队</a>设计</p>
                <p>© 2015 <a href="team-info.html" target="_blank">南航1613001班一队</a></p>
            </footer>

    </div>


    <script src="lib/bootstrap/js/bootstrap.js"></script>
    <script type="text/javascript">
        $("[rel=tooltip]").tooltip();
        $(function() {
            $('.demo-cancel-click').click(function(){return false;});
        });
    </script>
    
  
</body></html>