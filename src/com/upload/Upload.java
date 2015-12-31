package com.upload;


import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.Read.ExcelToSQL;

public class Upload extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	/**
	 * Constructor of the object.
	 */
	  private String uploadPath = "D:\\upload"; // 上传文件的目录 
	
	 private String fileName;
	  
	
	/**
	 * The doGet method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to get.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	
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
		 try {	 
			 //response.setCharacterEncoding("UTF-8");
			 HttpSession session = request.getSession(); 
			 String username=(String)session.getAttribute("username");
			 
			 
			 
			 DiskFileItemFactory fileFactory = new DiskFileItemFactory();  
			
		       
		        // 设置缓冲区大小，这里是4kb   
		        fileFactory.setSizeThreshold(5*1024);  
		        //设置临时文件目录  
		      // fileFactory.setRepository(new File(tempPath));  
		        
		        ServletFileUpload fileupload = new ServletFileUpload(fileFactory);
		        // 设置最大文件尺寸，这里是4MB   
		        fileupload.setFileSizeMax(4194304);   
	
		       
		        
		        
		        List<FileItem> fileItems = fileupload.parseRequest(request);   
	
		        Iterator<FileItem> i = fileItems.iterator();   
		
		        while(i.hasNext())
		        {
		        	FileItem item = (FileItem)i.next();
		        	
		        	if (!item.isFormField())//不是普通项  
		        	{
		        		//针对不同浏览器路径问题
		        		String filename1=item.getName();
		        		fileName = new String(filename1.getBytes(),"UTF-8");
		        		
		                String[] files=fileName.split("\\\\");
		                fileName=files[files.length-1];
		        		
			            String fileType=fileName.substring(fileName.lastIndexOf("."));
			            
			            if (!fileType.equals(".xls") && !fileType.equals(".xlsx"))
			            {
			            	out.print("<script>alert('文件类型错误，请上传Excel文件');history.back();</script>");
			            }
			            else
			            {
			            	
			        		//构建输入流
				            InputStream in=item.getInputStream();  	            	                     
		                    //构建输出流
				       
				            
		                    FileOutputStream fos=new FileOutputStream(uploadPath+"/"+fileName);  
		                    byte[] buffer=new byte[1024]; 
		                    int len = 0;
		                    while((len = in.read(buffer))>0)
		                    {  
		                        fos.write(buffer, 0, len);  
		                    
		                    }  
		                    in.close();  
		                    fos.close();  
		               
		                    item.delete();//在关闭流之后，删除临时缓存文件
		                    ExcelToSQL read = new ExcelToSQL(username,uploadPath, fileName);
				        	
		                 
		                    read.ImportToSQL();
				        	response.sendRedirect("/RPlatform/analysis.jsp?first=1");
				        	
			            }
		        	}
		        	
		        }
		    }   
		    catch(Exception e) {   
		        // 中文乱码 
		    	 out.print("<script>alert('文件类型错误，请上传Excel文件');history.back();</script>");
		    }  
		
		 
		
	}

	

}
