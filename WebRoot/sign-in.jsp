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
    <base href="<%=basePath%>">
    <title>RPlatform</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
   <%  
    request.setCharacterEncoding("utf8");  
  
    String userName = request.getParameter("username").trim();  
    String userPwd = request.getParameter("userpwd").trim();  
    String checkbox= request.getParameter("checkbox"); 
    if(userName.length()<1 || userPwd.length()<1){  
        response.sendRedirect("sign-in.html");  
        return;  
    }  
     if(checkbox==null)
    {
        %>  
        <script type="text/javascript" language="javascript">  
            alert("请勾选我同意");  
            window.document.location.href="sign-in.html";  // 用户名和密码错误，跳转到登录界面          
        </script>   
      <% 
      return;
    }
     String sql="select * from userinfo where username='"+userName+"' and userpwd='"+userPwd+"'";      
     ResultSet st=SQLHelp.query(sql);
     if(st.next())
     {
         session.setMaxInactiveInterval(30*60);          // 设置session失效时间（timeout），单位为秒 
         session.setAttribute("username", userName);     // 用户名和密码正确，保存登录信息  
         response.sendRedirect("index.jsp");  
     }
    else {    
     %>  
        <script type="text/javascript" language="javascript">  
            alert("用户名或密码错误");  
            window.document.location.href="sign-in.html";  // 用户名和密码错误，跳转到登录界面
            
        </script>   
<% 
    }
    if(st!=null)
      st.close();  
%>  
  </body>
</html>
