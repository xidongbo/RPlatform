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
    String username = request.getParameter("username").trim();  
    String userpwd = request.getParameter("userpwd").trim();  
    String name = request.getParameter("name").trim();  
    String email = request.getParameter("email").trim(); 
    String checkbox= request.getParameter("checkbox"); 
    if(username.length()<1 || userpwd.length()<1 ||name.length()<1 || email.length()<1){  
        response.sendRedirect("sign-up.html");   
        return;
    }  
    if(checkbox==null)
    {
        %>  
        <script type="text/javascript" language="javascript">  
            alert("请勾选我同意");  
            window.document.location.href="sign-up.html";  // 用户名和密码错误，跳转到登录界面          
        </script>   
      <% 
      return;
    }
     String sql="select * from userinfo where username='"+username+"'";      
     ResultSet st=SQLHelp.query(sql);
     if(st.next())
     {
         %>  
        <script type="text/javascript" language="javascript">  
            alert("用户名已存在");  
            window.document.location.href="sign-up.html";  // 用户名和密码错误，跳转到登录界面    
        </script>   
     <% 
     }
    else {    
         sql="insert into userinfo(username,userpwd,name,email) values('"+username+"','"+userpwd+"','"+name+"','"+email+"')";
         SQLHelp.update(sql);
     %>  
        <script type="text/javascript" language="javascript">  
            alert("注册成功");  
            window.document.location.href="sign-in.html";  // 用户名和密码错误，跳转到登录界面          
        </script>   
<% 
    }
    if(st!=null)
      st.close();    
%>  
  </body>
</html>
