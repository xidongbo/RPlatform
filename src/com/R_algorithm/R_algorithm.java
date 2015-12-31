package com.R_algorithm;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.RPlatform.SQLHelp;
import com.sun.org.apache.commons.digester.rss.Image;

public class R_algorithm extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * The doPost method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to post.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		    response.setContentType("text/html;charset=gbk");
		
		     
		     PrintWriter out = response.getWriter();
		     R_call re=R_Rengine.get_re();
		     
		     String index=request.getParameter("algorithm");
		     int table_index;
		    try{
		    	table_index=Integer.valueOf(request.getParameter("imported_data"));//测试数据表
		    }catch(NumberFormatException e)
		    {
		    	 out.print("<script>alert('请先导入测试数据！');history.back();</script>");
	        	 return;
		    }
		    
		     if(index.equals("1"))//linear_regression
		     {	
		    	 
		    	 try {
			         String predict_data_str=request.getParameter("predict_data");//算法参数
			         if(predict_data_str==null)
			         {
			        	 out.print("<script>alert('算法参数有误！');history.back();</script>");
			        	 return;
			         }
			         predict_data_str=predict_data_str.trim();//去掉空格
			         String[] predict_datas=predict_data_str.split(",");
			         double[] predict_data=new double[predict_datas.length];
			         for(int i=0;i<predict_datas.length;i++)
			         {
			        	 predict_data[i]=Double.valueOf(predict_datas[i]);
			         }
			        
			         String username=(String)request.getSession().getAttribute("username");
			         String sql="select * from analysis_data where username='"+username+"'";
				     ResultSet st=SQLHelp.query(sql);//得到该用户所有测试数据
				     st.absolute(table_index);//定位到行
				     String table=st.getString("input_table");//得到测试数据表名
				     sql="select * from `"+table+"`";
				     st=SQLHelp.query(sql);//得到测试数据
		             st.last();
					 int row = st.getRow(); 
					 st.beforeFirst();
					 int col=st.getMetaData().getColumnCount();
					 if(predict_datas.length!=col-1)
			         {//不是N-1维数据
			        	 out.print("<script>alert('算法参数维数有误！');history.back();</script>");
			        	 return;
			         }		 
					 
					 double[][] data=new double[row][col];
					 int j=0;
			         while(st.next())
			         { 
			        	 for(int i=0;i<col;i++)
			        	 {
			        		 data[j][i]=st.getDouble(i+1);
			        	 }
			        	 j++;
			         }
			         st.close();
			         Map<String,Object>returnmap=re.linearRegression(data,predict_data);
			         double[] result=(double[])returnmap.get("result");
			         BufferedImage image=(BufferedImage)returnmap.get("image");
			        
			     	 
			     	  Calendar cal=Calendar.getInstance();    
			    	  int year=cal.get(Calendar.YEAR);    
			    	  int month=cal.get(Calendar.MONTH);    
			    	  int day=cal.get(Calendar.DATE);    
			    	  int hour=cal.get(Calendar.HOUR_OF_DAY);    
			    	  int minute=cal.get(Calendar.MINUTE);    
			    	  int second=cal.get(Calendar.SECOND);
			    	  String time = year+ "_" + (month+1) + "_" + day + "_" + hour + "_" + minute + "_" + second;
			     	
			     	 String result_table=username+"_"+time+"linear_regression_result";
			     	
			     	 String pic_path="D:\\\\upload\\\\";
			     	 pic_path+=result_table+"_pic1.jpg";
			     	 ImageIO.write(image,"JPG",new File(pic_path));//写到磁盘
			     	 
			     	
			     	 //插入分析记录
			     	 String sql_record="insert into analysis_record(username,algorithm,input_table,output_table,pic_path1) values('"+username+"','1','"+table+"','"+result_table+"','"+pic_path+"')";
			     	
			     	 
			     	//插入分析结果
			     	 String sql_result_table="create table `"+result_table+"` (`预测平均值` varchar(20) not null,`预测最小值` varchar(20) not null,`预测最大值` varchar(20) not null)";
			     	 
			     	 
			     	 
			     	sql="insert into `"+result_table+"` values('"+result[0]+"','"+result[1]+"','"+result[2]+"')";
			     	
			         SQLHelp.update(sql_record);  //插入分析记录
			     	 SQLHelp.update(sql_result_table);//建结果表
			     	 SQLHelp.update(sql);//结果表插入数据
			     	 
			   
			     	 sql="select * into outfile 'D:/upload/"+result_table+".xls' from `"+result_table+"`";
			     	SQLHelp.query(sql);//结果表写入excel
			     	 
			     	response.sendRedirect("/RPlatform/result.jsp");
					 } catch (SQLException e1) {
							// TODO Auto-generated catch block
						 out.print("<script>alert('测试数据有误！');history.back();</script>");
					}catch(NumberFormatException e){
			    		 out.print("<script>alert('算法参数有误！');history.back();</script>");
			    		 return;
					}catch(ArrayIndexOutOfBoundsException e)
					{
						 out.print("<script>alert('算法参数有误！');history.back();</script>");
						 return;
					}
		    	 return;
		     }
		     if(index.equals("2"))//K_means
		     {
		    	 try {
		         int kind=Integer.valueOf(request.getParameter("kind"));//算法参数	
		         if(kind<1)
		         {
		        	 out.print("<script>alert('算法参数有误！');history.back();</script>");
		        	 return;
		         }
		         String username=(String)request.getSession().getAttribute("username");
		         String sql="select * from analysis_data where username='"+username+"'";
			     ResultSet st=SQLHelp.query(sql);//得到该用户所有测试数据
			     st.absolute(table_index);//定位到行
			     String table=st.getString("input_table");//得到测试数据表名
			     sql="select * from `"+table+"`";
			     st=SQLHelp.query(sql);//得到测试数据
	             st.last();
				 int row = st.getRow();
				 st.beforeFirst();
				 int col=st.getMetaData().getColumnCount();
				 double[] array=new double[row*col];
				 int j=0;
		         while(st.next())
		         { 
		        	 for(int i=0;i<col;i++)
		        	 {
		        		 array[col*j+i]=st.getDouble(i+1);
		        	 }
		        	 j++;
		         }
		         st.close();
		         Map<String,Object> datamap=re.k_means(array, row, kind);
		         if(datamap!=null)
		         {
			         double[][] centers=(double[][]) datamap.get("centers");
			     	 double [] cluster=(double[]) datamap.get("cluster");
			     	 BufferedImage image=(BufferedImage) datamap.get("image");
			     	 
			     	  Calendar cal=Calendar.getInstance();    
			    	  int year=cal.get(Calendar.YEAR);    
			    	  int month=cal.get(Calendar.MONTH);    
			    	  int day=cal.get(Calendar.DATE);    
			    	  int hour=cal.get(Calendar.HOUR_OF_DAY);    
			    	  int minute=cal.get(Calendar.MINUTE);    
			    	  int second=cal.get(Calendar.SECOND);
			    	  String time = year+ "_" + (month+1) + "_" + day + "_" + hour + "_" + minute + "_" + second;
			     	
			     	 String result_table=username+"_"+time+"K_means_result";
			     	
			     	 String pic_path="D:\\\\upload\\\\";
			     	 pic_path+=result_table+"_pic1.jpg";
			     	 ImageIO.write(image,"JPG",new File(pic_path));//写到磁盘
			     	
			     	 //插入分析记录
			     	 sql="insert into analysis_record(username,algorithm,input_table,output_table,pic_path1) values('"+username+"','2','"+table+"','"+result_table+"','"+pic_path+"')";
			     	 SQLHelp.update(sql); 
			     	 
			     	//插入分析结果
			     	 sql="create table `"+result_table+"` (`第i组测试数据` int(13) not null,`聚类结果` int(13) not null,`聚类中心` varchar(300) not null)";
			     	 SQLHelp.update(sql);//建结果表
			     	 sql="insert into `"+result_table+"` (`第i组测试数据`,`聚类结果`,`聚类中心`) values";
			     	 for(int i=1;i<cluster.length;i++)
			     	 {
			     		 sql+="('"+String.valueOf(i)+"','"+String.valueOf(cluster[i-1])+"','";
			     		 for(int k=0;k<centers[0].length-1;k++)
			     		 {
			     			 sql+=centers[(int) (cluster[i-1]-1)][k]+",";
			     		 }
			     		 sql+=centers[(int) (cluster[i-1]-1)][centers[0].length-1]+"'),";
			     	 }
			     	 sql+="('"+String.valueOf(cluster.length)+"','"+String.valueOf(cluster[cluster.length-1])+"','";
			      	for(int k=0;k<centers[0].length-1;k++)
		     		 {
		     			 sql+=centers[(int) (cluster[cluster.length-1]-1)][k]+",";
		     		 }
			     	 sql+=centers[(int) (cluster[cluster.length-1-1]-1)][centers[0].length-1]+"')";
			     	 SQLHelp.update(sql);//结果表插入数据
			    	 sql="select * into outfile 'D:/upload/"+result_table+".xls' from `"+result_table+"`";
			        SQLHelp.query(sql);//结果表写入excel
			     	 
			     	 
			     	 
			     	response.sendRedirect("/RPlatform/result.jsp");
		         }
		         else
		         {
		        	 out.print("<script>alert('算法参数有误！');history.back();</script>");
		        	 return;
		         }
				 } catch (SQLException e1) {
						// TODO Auto-generated catch block
					 out.print("<script>alert('测试数据有误！');history.back();</script>");
				}catch(NumberFormatException e){
		    		 out.print("<script>alert('算法参数有误！');history.back();</script>");
		    		 return;
		    	 }
		    	 
				 
		         return;
		     }
		     if(index.equals("3"))//NaiveBayes
		     {
		    	 try {
			         String predict_data_str=request.getParameter("predict_data");//算法参数
			         if(predict_data_str==null)
			         {
			        	 out.print("<script>alert('算法参数有误！');history.back();</script>");
			        	 return;
			         }
			         String[] predict_data=predict_data_str.split(",");
			       
			         String username=(String)request.getSession().getAttribute("username");
			         String sql="select * from analysis_data where username='"+username+"'";
				     ResultSet st=SQLHelp.query(sql);//得到该用户所有测试数据
				     st.absolute(table_index);//定位到行
				     String table=st.getString("input_table");//得到测试数据表名
				     sql="select * from `"+table+"`";
				     st=SQLHelp.query(sql);//得到测试数据
		             st.last();
					 int row = st.getRow(); 
					 st.beforeFirst();
					 int col=st.getMetaData().getColumnCount();
					 if(predict_data.length!=col-1)
			         {//不是N-1维数据
			        	 out.print("<script>alert('算法参数维数有误！');history.back();</script>");
			        	 return;
			         }		 
					 
					 String[][] data=new String[row][col];
					 int j=0;
			         while(st.next())
			         { 
			        	 for(int i=0;i<col;i++)
			        	 {
			        		 data[j][i]=st.getString(i+1);
			        	 }
			        	 j++;
			         }
			         st.close();
			         Map<String,Object>returnmap=re.NaiveBayes(data,predict_data);
			         String result=(String)returnmap.get("result");
			         BufferedImage image=(BufferedImage)returnmap.get("image");
			        
			     	 
			     	  Calendar cal=Calendar.getInstance();    
			    	  int year=cal.get(Calendar.YEAR);    
			    	  int month=cal.get(Calendar.MONTH);    
			    	  int day=cal.get(Calendar.DATE);    
			    	  int hour=cal.get(Calendar.HOUR_OF_DAY);    
			    	  int minute=cal.get(Calendar.MINUTE);    
			    	  int second=cal.get(Calendar.SECOND);
			    	  String time = year+ "_" + (month+1) + "_" + day + "_" + hour + "_" + minute + "_" + second;
			     	
			     	 String result_table=username+"_"+time+"NaiveBayes_result";
			     	
			     	 String pic_path="D:\\\\upload\\\\";
			     	 pic_path+=result_table+"_pic1.jpg";
			     	 ImageIO.write(image,"JPG",new File(pic_path));//写到磁盘
			     	 
			     	
			     	 //插入分析记录
			     	 String sql_record="insert into analysis_record(username,algorithm,input_table,output_table,pic_path1) values('"+username+"','3','"+table+"','"+result_table+"','"+pic_path+"')";
			     	
			     	 
			     	//插入分析结果
			     	 String sql_result_table="create table `"+result_table+"` (`预测结果` varchar(20) not null)";
			     	 
			     	 
			     	 
			     	sql="insert into `"+result_table+"` values('"+result+"')";
			     	
			         SQLHelp.update(sql_record);  //插入分析记录
			     	 SQLHelp.update(sql_result_table);//建结果表
			     	 SQLHelp.update(sql);//结果表插入数据
			     	 
			   
			     	 sql="select * into outfile 'D:/upload/"+result_table+".xls' from `"+result_table+"`";
			     	SQLHelp.query(sql);//结果表写入excel
			     	 
			     	response.sendRedirect("/RPlatform/result.jsp");
					 } catch (SQLException e1) {
							// TODO Auto-generated catch block
						 out.print("<script>alert('测试数据有误！');history.back();</script>");
					}catch(NumberFormatException e){
			    		 out.print("<script>alert('算法参数有误！');history.back();</script>");
			    		 return;
					}catch(ArrayIndexOutOfBoundsException e)
					{
						 out.print("<script>alert('算法参数有误！');history.back();</script>");
						 return;
					}
		    	 return;
		     }
		     if(index.equals("4"))//PCA
		     {
		    	 try {
			         int dimension=Integer.valueOf(request.getParameter("dimension"));//算法参数	
			         if(dimension<1)
			         {
			        	 out.print("<script>alert('算法参数有误！');history.back();</script>");
			        	 return;
			         }
			         String username=(String)request.getSession().getAttribute("username");
			         String sql="select * from analysis_data where username='"+username+"'";
				     ResultSet st=SQLHelp.query(sql);//得到该用户所有测试数据
				     st.absolute(table_index);//定位到行
				     String table=st.getString("input_table");//得到测试数据表名
				     sql="select * from `"+table+"`";
				     st=SQLHelp.query(sql);//得到测试数据
		             st.last();
					 int row = st.getRow();
					 st.beforeFirst();
					 int col=st.getMetaData().getColumnCount();
					 double[][] data=new double[row][col];
					 int j=0;
			         while(st.next())
			         { 
			        	 for(int i=0;i<col;i++)
			        	 {
			        		 data[j][i]=st.getDouble(i+1);
			        	 }
			        	 j++;
			         }
			         st.close();
			         Map<String,Object> map=re.PCA(data, dimension);
			         double[][] newdata=(double[][]) map.get("newdata");
		      		 BufferedImage image1=(BufferedImage) map.get("image1");
		      		 BufferedImage image2=(BufferedImage) map.get("image2");

			     	 
			     	  Calendar cal=Calendar.getInstance();    
			    	  int year=cal.get(Calendar.YEAR);    
			    	  int month=cal.get(Calendar.MONTH);    
			    	  int day=cal.get(Calendar.DATE);    
			    	  int hour=cal.get(Calendar.HOUR_OF_DAY);    
			    	  int minute=cal.get(Calendar.MINUTE);    
			    	  int second=cal.get(Calendar.SECOND);
			    	  String time = year+ "_" + (month+1) + "_" + day + "_" + hour + "_" + minute + "_" + second;
			     	
			     	 String result_table=username+"_"+time+"PCA_result";
			     	 String pic_path="D:\\\\upload\\\\";
			     	 String path1=pic_path+result_table+"_pic1.jpg";
			     	 String path2=pic_path+result_table+"_pic2.jpg";
			     	 ImageIO.write(image1,"JPG",new File(path1));//写到磁盘
			     	 ImageIO.write(image2,"JPG",new File(path2));//写到磁盘
			     	
			     	 //插入分析记录
			     	 String sql_record="insert into analysis_record(username,algorithm,input_table,output_table,pic_path1,pic_path2) values('"+username+"','4','"+table+"','"+result_table+"','"+path1+"','"+path2+"')";
			     	
			     	 
			     	//插入分析结果
			     	 String sql_result_table="create table `"+result_table+"` (";
			     	 for(int i=1;i<dimension;i++)
			     	 {
			     		sql_result_table+="`"+String.valueOf(i)+"` varchar(20) not null,";
			     	 }
			     	sql_result_table+="`"+String.valueOf(dimension)+"` varchar(20) not null)";
			     	 
			     	 
			     	sql="insert into `"+result_table+"` values";
			     	 for(int i=0;i<row;i++)
			     	 {
			     		 sql+="(";
			     		 for(int k=0;k<dimension-1;k++)
			     		 {
			     			 sql+=newdata[i][k]+",";
			     		 }
			     		 if(i==row-1)
			     			sql+=newdata[i][dimension-1]+")";
			     		 else
			     		   sql+=newdata[i][dimension-1]+"),";
			     	 }
			         SQLHelp.update(sql_record);  //插入分析记录
			     	 SQLHelp.update(sql_result_table);//建结果表
			     	 SQLHelp.update(sql);//结果表插入数据
			    	 sql="select * into outfile 'D:/upload/"+result_table+".xls' from `"+result_table+"`";
			         SQLHelp.query(sql);//结果表写入excel
			     	response.sendRedirect("/RPlatform/result.jsp");
					 } catch (SQLException e1) {
							// TODO Auto-generated catch block
						 out.print("<script>alert('测试数据有误！');history.back();</script>");
					}catch(NumberFormatException e){
			    		 out.print("<script>alert('算法参数有误！');history.back();</script>");
			    		 return;
			    	 } catch (InterruptedException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}catch(ArrayIndexOutOfBoundsException e)
					{
						 out.print("<script>alert('算法参数有误！');history.back();</script>");
					}
							
		    	 return;
		     }
	}

	

}
