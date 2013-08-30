package com.ht2000.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import sun.misc.BASE64Encoder;

public class Encryption {
	
	public static String md5(String str){
		if(str==null){
			return "";
		}else{
			String value = null;
			MessageDigest md5 = null;
			try {
				md5 = MessageDigest.getInstance("MD5");
			}catch (NoSuchAlgorithmException ex) {
				ex.printStackTrace();
			}
			BASE64Encoder baseEncoder = new BASE64Encoder();
			try {
				value = baseEncoder.encode(md5.digest(str.getBytes("utf-8")));
			} catch (Exception ex) {
				ex.printStackTrace();
			}
			return value;
		}
	}
	
	public static void main(String[] args){
		System.out.println(md5("2012-12-26"));
	}
}
