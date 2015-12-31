package com.R_algorithm;

public  class R_Rengine {
	private static R_call re;
	public static R_call get_re()
	{
		if(re==null)
		   re=new R_call();
		return  re;
	}
}
