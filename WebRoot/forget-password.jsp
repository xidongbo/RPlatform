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
    String name = request.getParameter("name").trim();  
    String nuserpwd1 = request.getParameter("nuserpwd1").trim();  
    String nuserpwd2 = request.getParameter("nuserpwd2").trim();  
      
    if(username.length()<1 || name.length()<1 || nuserpwd1.length()<1 || nuserpwd2.length()<1){  
        response.sendRedirect("forget-password.html");  
        return;  
    }  
    
     String sql="select * from userinfo where username='"+username+"' and name='"+name+"'";      
     ResultSet st=SQLHelp.query(sql);
     if(st.next())
     {  
         if(!nuserpwd1.equals(nuserpwd2))
	    {
	      %>
	      <script type="text/javascript" language="javascript">  
	            alert("两次输入密码不一致");  
	            window.document.location.href="forget-password.html"; 
	            
	        </script>   
	      <% 
	    }
	      else
	      {
	        sql="update userinfo set userpwd='"+nuserpwd1+"' where username='"+username+"'";
	        SQLHelp.update(sql);
	       %>  
	        <script type="text/javascript" language="javascript">  
	            alert("密码修改成功");  
	            window.document.location.href="sign-in.html";  
	            
	        </script>   
	     <% }
     }
    else {    
     %>  
        <script type="text/javascript" language="javascript">  
            alert("用户名和姓名不匹配！");  
            window.document.location.href="forget-password.html";
            
        </script>   
       <% }
     
      if(st!=null)   
       st.close();
      %> 
  </body>
</html>
