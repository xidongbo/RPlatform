package com.Read;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;
import java.util.Calendar;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.RPlatform.SQLHelp;

public class ExcelToSQL 
{
	private String filename;
	private String path;
	private String username;
	public ExcelToSQL(String username, String path, String filename)
	{
		this.username = username;
		this.filename = filename;
		this.path = path;
	}
	 public void ImportToSQL() throws  IOException, SQLException
	 {
		  
		
		InputStream is = new FileInputStream(path + "\\" + filename);
		 
	       
	      String[] names = filename.split("\\.");
	       
	      Calendar cal=Calendar.getInstance();    
    	  int year=cal.get(Calendar.YEAR);    
    	  int month=cal.get(Calendar.MONTH);    
    	  int day=cal.get(Calendar.DATE);    
    	  int hour=cal.get(Calendar.HOUR_OF_DAY);    
    	  int minute=cal.get(Calendar.MINUTE);    
    	  int second=cal.get(Calendar.SECOND);
    	  String time = year+ "_" + (month+1) + "_" + day + "_" + hour + "_" + minute + "_" + second;
    	  
    	  String tablename = "`" + username+ "_" + time + "_" + names[0] + "`";
    	  String sql="insert into analysis_data(username,input_table) values('"+username+"','"+tablename.substring(1,tablename.length()-1)+"')";
    	  SQLHelp.update(sql); 
    	  SQLHelp.update("create table " + tablename + " (col_0 varchar(20))");
    	
    	  if (names[1].equals("xls"))
    	  {
    		  HSSFWorkbook Workbook = null;
    		  HSSFSheet sheet;
    		  HSSFCell cell;
	    	  try {
		          Workbook = new HSSFWorkbook(is);
		        } catch (IOException e) {
		            e.printStackTrace();
		        }
	    	  sheet = Workbook.getSheetAt(0);
	    	  String keywords = "(col_0";
	    	  for (int j=1; j<sheet.getRow(0).getLastCellNum(); j++)
	    	  {
	    		  keywords = keywords + ",col_" + j;
	    		  SQLHelp.update("alter table " + tablename + " add col_" + j + " varchar(20)");
	    	  }
	    	  keywords = keywords + ")";
	   

	    	  for (int i=0; i<=sheet.getLastRowNum(); i++)
	    	  {
	    		  String values = "(" + "'" + sheet.getRow(i).getCell(0).toString() + "'";
	    		  for (int j=1; j<sheet.getRow(0).getLastCellNum(); j++)
	    		  {
	    			  cell = sheet.getRow(i).getCell(j);
	    		
	    			  if (cell != null)
	    			  {
	    				  values = values + "," + "'" + cell.toString() + "'";
	    			  }
	    			  else
	    			  {
	    				  values = values + "," + "''";
	    			  }
	    		  }
	    		  values  = values + ")";
	    		 
	    		  SQLHelp.update("insert into " + tablename + keywords + "values" + values);
	    		
	    	  }
    	  }
	      else
	      {
	    	  XSSFWorkbook Workbook = null;
    		  XSSFSheet sheet;
    		  XSSFCell cell;
	    	  try {
		            Workbook = new XSSFWorkbook(path + "\\" + filename);
		        } catch (IOException e) {
		            e.printStackTrace();
		        }
	    	  sheet = Workbook.getSheetAt(0);
	    	  String keywords = "(col_0";
	    	  for (int j=1; j<sheet.getRow(0).getLastCellNum(); j++)
	    	  {
	    		  keywords = keywords + ",col_" + j;
	    		  SQLHelp.update("alter table " + tablename + " add col_" + j + " varchar(20)");
	    	  }
	    	  keywords = keywords + ")";
	  
	    	  for (int i=0; i<=sheet.getLastRowNum(); i++)
	    	  {
	    		  String values = "(" + "'" + sheet.getRow(i).getCell(0).toString() + "'";
	    		  for (int j=1; j<sheet.getRow(0).getLastCellNum(); j++)
	    		  {
	    			  cell = sheet.getRow(i).getCell(j);
	    		
	    			  if (cell != null)
	    			  {
	    				  values = values + "," + "'" + cell.toString() + "'";
	    			  }
	    			  else
	    			  {
	    				  values = values + "," + "''";
	    			  }
	    		  }
	    		  values  = values + ")";
	    		  SQLHelp.update("insert into " + tablename + keywords + "values" + values);
	    		
	    	  }
	      }
	 }
	 
	 
}
