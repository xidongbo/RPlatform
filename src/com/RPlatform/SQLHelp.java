package com.RPlatform;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;




public class SQLHelp{
	
	private static String url = "jdbc:mysql://localhost:3306/rplatform";	// 数据库连接字符串
	private static String username = "root";	// 数据库用户名
	private static String password = "";	// 数据库密码    
	
	
	public SQLHelp() throws ClassNotFoundException
	{
		
	}
	private static void release(Connection conn,Statement st,ResultSet rs){
	       if(rs!=null)
	       {
	             try{
	                 //关闭存储查询结果的ResultSet对象
	                 rs.close();
	             }catch (Exception e) {
	                 e.printStackTrace();
	             }
	             rs = null;
	         }
	         if(st!=null){
	             try{
	                 //关闭负责执行SQL命令的Statement对象
	                 st.close();
	             }catch (Exception e) {
	                 e.printStackTrace();
	             }
	         }
	         
	         if(conn!=null){
	             try{
	                 //关闭Connection数据库连接对象
	                 conn.close();
	             }catch (Exception e) {
	                 e.printStackTrace();
	             }
	         }
	     }
		 
	private static Connection getConnection() throws SQLException, ClassNotFoundException{
    	Class.forName("com.mysql.jdbc.Driver");	// 加载数据库驱动，注册到驱动管理器
    	return DriverManager.getConnection(url, username,password);
    	   }
    
    public static int update(String sql)
	{//增、删、改，返回更新的行数，返回0则失败
    	int i=0;
    	Connection conn=null;
    	Statement st=null;
    	ResultSet rs=null;
		try {
			st=getConnection().createStatement();
			i=st.executeUpdate(sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		finally{
		  release(conn,st,rs);
		}
		return i;
	}
    public static ResultSet query(String sql)
   	{//查询，返回结果ResultSet
       	Statement st=null;
       	ResultSet rs=null;
   		try {
   			st=getConnection().createStatement();
   			rs=st.executeQuery(sql);
   		} catch (SQLException e) {
   			// TODO Auto-generated catch block
   			e.printStackTrace();
   		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
   		
   		return rs;
   	}
           
}

