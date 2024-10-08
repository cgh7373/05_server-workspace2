package com.kh.common;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.oreilly.servlet.multipart.FileRenamePolicy;

public class MyFileRenamePolicy implements FileRenamePolicy {

	// 원본파일 전달받아 파일명 수정 후 반환
	@Override
	public File rename(File originFile) {
		
		// 원본파일명
		String originName = originFile.getName();
		
		// 수정파일명("2024080515293012345.jpg");
		// 업로드시간(년월일시분초) + 5자리 랜덤값 + 원본확장자
		
		// 1. 업로드시간(년월일시분초)
		String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
		
		// 2. 5자리 랜덤값 (int ranNum)
		int ranNum = (int)(Math.random() * 90000 + 10000);
		
		// 3. 원본파일확장자 (String ext)
		String ext = originName.substring(originName.lastIndexOf("."));
		
		String changeName = currentTime + ranNum + ext;
		
		return new File(originFile.getParent(), changeName);
	}

	
	
	
	
	
}
