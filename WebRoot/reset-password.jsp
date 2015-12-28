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
    String ruserpwd = request.getParameter("ruserpwd").trim();  
    String nuserpwd1 = request.getParameter("nuserpwd1").trim();  
    String nuserpwd2 = request.getParameter("nuserpwd2").trim();  
      
    if(username.length()<1 || ruserpwd.length()<1 || nuserpwd1.length()<1 || nuserpwd2.length()<1){  
        response.sendRedirect("reset_password.html");  
        return;  
    }  
    if(!nuserpwd1.equals(nuserpwd2))
    {
      %>
      <script type="text/javascript" language="javascript">  
            alert("两次输入密码不一致");  
            window.document.location.href="reset-password.html"; 
            
        </script>   
      <% 
    }
    else
    {
     String sql="select * from userinfo where username='"+username+"' and userpwd='"+ruserpwd+"'";      
     ResultSet st=SQLHelp.query(sql);
     if(st.next())
     {
        
        sql="update userinfo set userpwd='"+nuserpwd1+"' where username='"+username+"'";
        SQLHelp.update(sql);
       %>  
        <script type="text/javascript" language="javascript">  
            alert("密码修改成功");  
            window.document.location.href="sign-in.html";  
            
        </script>   
     <% 
     }
    else {    
     %>  
        <script type="text/javascript" language="javascript">  
            alert("用户名或密码错误");  
            window.document.location.href="reset-password.html";  // 用户名和密码错误，跳转到登录界面
            
        </script>   
       <% }
     
      if(st!=null)   
       st.close();} 
      %> 
  </body>
</html>
