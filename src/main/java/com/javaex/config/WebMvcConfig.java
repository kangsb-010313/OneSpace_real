package com.javaex.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

    @Value("${file.upload-dir}")
    private String resourcePath;
	
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
    	
        // ===================================================================
        // [파일 경로 설정] - 개발 환경과 배포 환경에 맞게 하나만 주석 해제하여 사용
        // ===================================================================

        // 1. EC2(리눅스) 서버에 배포할 때 사용할 경로
        //String resourceLocation = "file:/home/ubuntu/onespace_uploads/";
        
        // 2. 윈도우에서 로컬 테스트를 할 때 사용할 경로
        //String resourceLocation = "file:///C:/onespace_uploads/"; 
        // ===================================================================

        // '/uploads/**' 라는 웹 경로(URL)로 요청이 오면,
        // 위에서 설정한 실제 물리적 폴더(resourceLocation)에서 파일을 찾아 제공합니다.
        registry.addResourceHandler("/uploads/**") 
                .addResourceLocations("file:" + resourcePath); 
        		//.addResourceLocations(resourceLocation); 
        
    }
    
        // 맥 경로	-> /Users/kangsubin/Desktop/javaStudy/upload/
    
}