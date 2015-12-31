package com.R_algorithm;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Vector;

import javax.imageio.ImageIO;

import org.rosuda.JRI.REXP;
import org.rosuda.JRI.RFactor;
import org.rosuda.JRI.RVector;
import org.rosuda.JRI.Rengine;
import org.rosuda.REngine.REXPVector;


public class R_call {
	
	private Rengine re;
	public R_call()
	{
		this.re=new Rengine(null,false,null);
		
	}
	protected void  finalize()
	{
		this.re.end();
	}
	
	public Map<String,Object> k_means(double matrix_array[],int row,int kind ) throws IOException
	{
		
		
		
		
		Map<String,Object>  map =new HashMap<String,Object>();
		String matrix_string="";
		for(int i=0;i<matrix_array.length;i++)
		{
			matrix_string+=matrix_array[i];
			if(i!=matrix_array.length-1)
				matrix_string+=',';
		}
         this.re.eval("a=c("+matrix_string+")");
         REXP mrex=re.eval("x=matrix(a,byrow=T,nrow="+row+")");
         re.eval("t=kmeans(x,"+kind+")");
         REXP center_rex=re.eval("t$centers");
         if(center_rex!=null)
         {
	         double[][] centers=center_rex.asDoubleMatrix();
	         String centers_str=center_rex.toString();
	         
	         centers_str=centers_str.replace("[REAL* ", " ");
	         centers_str=centers_str.replace("]", " ");
	         
	         REXP cluster_rex=re.eval("t$cluster");
	         double [] cluster=cluster_rex.asDoubleArray();
	        
	         
	         String yin="\"";
	         String code="jpeg(file="+yin+"kmeanplot.jpeg"+yin+")";
	        // System.out.print(code);
	          re.eval(code);
	      
	         re.eval( " plot(x,col=t$cluster)");
	          re.eval("  points(t$centers,pch=8,col=t$cluster) ");
	          re.eval("dev.off()");
	          
	
	         
	         
	         BufferedImage image=ImageIO.read(new File("kmeanplot.jpeg"));
	         map.put("centers", centers);
	         map.put("centers_str", centers_str);
	         map.put("cluster", cluster);
	         map.put("image",image);
	         
	        
	         
	        
	        
			return map;		
         }
         else
        	   return null;
	}
	
	public String NaiveBayes(String [][] data_str,String [] predict_str)
	{
		this.re=new Rengine(null,false,null);
		boolean isload=re.waitForR();
		if(isload==true)System.out.println("R is ready");
		re.eval("library(e1071)");
		Vector<String> data_vec=new Vector<String>();
		int row=data_str.length;
		int colum=data_str[0].length;
		for(int i=0;i<colum;i++)
		{
			String temp="";
			for(int j=0;j<row;j++)
			{
				data_str[j][i]="'"+data_str[j][i]+"'";
				temp+=data_str[j][i];
				if(j!=row-1)temp+=",";
				
			}
			data_vec.add(temp);
		}
        Vector<String>type=new Vector<String>();
        for(int i=0;i<colum;i++)
        {
        	type.add( String.valueOf((char)(i+97)) );        	
        }
        String type_str="";
		for(int i=0;i<colum;i++)
		{
			
			type_str+=type.get(i);
			if(i!=colum-1)
			{
				type_str+=",";
				
			}
			re.eval(type.get(i)+"=c("+ data_vec.get(i)  +")" );
			//System.out.println(type.get(i)+"=c("+  data_vec.get(i)  +")");
			
			
		}
		REXP data_rex=re.eval(" dataset=data.frame(" + type_str + ")" );
		//System.out.println(" dataset=data.frame(" + type_str + ")");
	    REXP crex=re.eval("classifier<-naiveBayes(dataset[,1:"+ Integer.toString(colum-1) +"],dataset[,"+Integer.toString(colum)+"])");  
		//System.out.println("classifier<-naiveBayes(dataset[,1:"+ Integer.toString(colum-1) +"],dataset[,"+Integer.toString(colum)+"])");
		
		//System.out.print(classifier_rex.asString());
		
		String newdata_str="";
		for(int i=0;i<colum-1;i++)
		{
			newdata_str+=type.get(i);
			newdata_str+="=";
			newdata_str+="'"+predict_str[i]+"'";
			if(i!=colum-2)newdata_str+=",";
			
		}
		
		
	    re.eval(" new_data=data.frame("+newdata_str+")");
	   // System.out.println(" new_data=data.frame("+newdata_str+")");
		REXP RE=re.eval(" predict(classifier, new_data)" );
	//	 System.out.println(" predict(classifier, new_data)");
		re.end();
		RFactor rf= RE.asFactor();
		//System.out.println(rf.toString());
		String result=rf.at(0);
		//System.out.println(result);
		 return result;
		//System.out.println(p[0]);
		
	}
	
	public double[] linearRegression(double[][] data,double[] predict_data)
	{
		
		int row=data.length;
		int colum=data[0].length;
		Vector<String> data_vec=new Vector<String>();
		for(int i=0;i<colum;i++)
		{
			String item="";
			for(int j=0;j<row;j++)
			{
			   item+=data[j][i];
			   if(j!=row-1)item+=",";
			}
			data_vec.add(item);			
		}
		Vector<String>type=new Vector<String>();
	        for(int i=0;i<colum;i++)
	        {
	        	type.add( String.valueOf((char)(i+97)) );        	
	        }
	 
		for(int i=0;i<colum;i++)
		{
			re.eval(type.get(i)+"=c("+data_vec.get(i)+")");
			//System.out.println(type.get(i)+"=c("+data_vec.get(i)+")");
			
			
		}
		String dataset_str="";
		for(int i=0;i<colum;i++)
		{
			dataset_str+=type.get(i);
			if(i!=colum-1)dataset_str+=",";
		}
		re.eval("dataset=data.frmae("+dataset_str+")");
	//	System.out.println("dataset=data.frame("+dataset_str+")");
		
		
	          
		String lm_str="";
		lm_str+=type.get(colum-1);
		lm_str+="~";
		for(int i=0;i<colum-1;i++)
		{
			lm_str+=type.get(i);
			if(i!=colum-2)
			{
				lm_str+="+";
			}
		}
	   re.eval("mod=lm("+lm_str+")");
	  // System.out.println("mod=lm("+lm_str+")");
	   
	   String yin="\"";
		
       String code="jpeg(file="+yin+"linearplot.jpeg"+yin+")";
       String code2="jpeg(file="+yin+"linearplot2.jpeg"+yin+")";
    //   System.out.println(code);
        re.eval(code);
        re.eval("plot(mod)");	       
        re.eval("dev.off()");
		 
	   String pre_str="";
	   for(int i=0;i<colum-1;i++)
	   {
		   pre_str+=type.get(i);
		   pre_str+="=";
		   pre_str+=predict_data[i];
		   if(i!=colum-2)pre_str+=",";
	   }
	 re.eval("newd=data.frame("+pre_str+")");
	//System.out.println("newd=data.frame("+pre_str+")");
	REXP RE=re.eval("predict(mod,newdata=newd,interval="+yin+"prediction"+yin+",level=0.95"+")");
	//System.out.println("predict(mod,newdata=newd,interval="+yin+"prediction"+yin+",level=0.95"+")");
   //System.out.println(RE.toString());
	
	double []result=RE.asDoubleArray();
	 return result;
	
   
	}
	
	public  Map<String,Object> PCA(double[][] data,int k) throws InterruptedException, IOException
	{
		
	
		
		
		int row=data.length;
		int colum=data[0].length;
		Map<String,Object>map=new HashMap<String,Object>();
		
		Vector<String> data_vec=new Vector<String>();
		for(int i=0;i<colum;i++)
		{
			String item="";
			for(int j=0;j<row;j++)
			{
			   item+=data[j][i];
			   if(j!=row-1)item+=",";
			}
			data_vec.add(item);			
		}
		Vector<String>type=new Vector<String>();
	        for(int i=0;i<colum;i++)
	        {
	        	type.add( String.valueOf((char)(i+97)));        	
	        }
	 
		for(int i=0;i<colum;i++)
		{
			re.eval(type.get(i)+"=c("+data_vec.get(i)+")");
		//	System.out.println(type.get(i)+"=c("+data_vec.get(i)+")");
			
		}
		
		String dataset_str="";
		for(int i=0;i<colum;i++)
		{
			dataset_str+=type.get(i);
			if(i!=colum-1)dataset_str+=",";
		}
		REXP RE =re.eval("dataset=data.frame("+dataset_str+")");
	//	System.out.println("dataset=data.frame("+dataset_str+")");
	
		re.eval("sdata=scale(dataset)");
		//System.out.println("sdata=scale(dataset)");
		
		re.eval("pca=princomp(sdata)");
		//System.out.println("pca=princomp(sdata)");
		
		
		 String yin="\"";
			
	      String code="jpeg(file="+yin+"pcaplot1.jpeg"+yin+")";
	      re.eval(code);
	      
	     
	      re.eval("plot(pca,type="+yin+"line"+yin+",main="+yin+"碎石图"+yin+","+"lwd=2"+")");	       
	    //  System.out.println("plot(pca,type="+yin+"line"+yin+",main="+yin+"��ʯͼ"+yin+","+"lwd=2"+")");
	      re.eval("dev.off()");
		
	      BufferedImage image=ImageIO.read(new File("pcaplot1.jpeg"));
		  map.put("image1", image);
		  
		  re.eval("dcor=cor(sdata)");
		//  System.out.println("dcor=cor(sdata)");
		  
		  re.eval("deig=eigen(dcor)");
		 // System.out.println("deig=eigen(dcor)");
		  
		  re.eval("tz=pca$loadings[,1:"+k+"]");
		//  System.out.println("tz=pca$loadings[,1:"+k+"]");
		  
		  re.eval("mdata=as.matrix(dataset)");
		//  System.out.println("mdata=as.matrix(dataset)");
		  
		  re.eval("tzm=as.matrix(tz)");
		//  System.out.println("tzm=as.matrix(tz)");
		  
		  REXP newdata_rex=re.eval("mdata %*% tzm ");
		  
		  //System.out.println("newdata=mdata %*% tzm ");
		  double[][] newdata=newdata_rex.asMatrix();
		  map.put("newdata", newdata);
		  
		  
		  
		  String code1="jpeg(file="+yin+"pcaplot2.jpeg"+yin+")";
	      re.eval(code1);
	      re.eval("plot(mdata %*% tzm)");
	      re.eval("dev.off()");
		
	      BufferedImage image2=ImageIO.read(new File("pcaplot2.jpeg"));
		  map.put("image2", image2);
		  
		
	      
			
	      return map;
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	}
	
	public void saveplot()
	{
		this.re=new Rengine(null,false,null);
		boolean isload=re.waitForR();
		if(isload==true)
			System.out.println("R is ready");
		      
		 String yin="\"";
         
	        
         String code="jpeg(file="+yin+"kmeanplot.jpeg"+yin+")";
         
         re.eval("code");
         re.eval( " plot(1:10)");
        //����ͼ��
         re.eval("dev.off()");
		
		re.end();
	}
	public void end()
	{
		this.re.end();
	}

}
