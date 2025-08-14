package com.javaex.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
    	
    	String osName = System.getProperty("os.name").toLowerCase();
    	String resourceLocation = "";
    	
    	if(osName.contains("win")) { //윈도우
    		resourceLocation = "file:///C:/javaStudy/upload/";
    	}else {
    		resourceLocation = "file:/data/upload/";
    	}
    	
        registry.addResourceHandler("/upload/**")
        .addResourceLocations(resourceLocation);
        
        
        
        
        
        // 윈도우 경로	-> file:///C:/javaStudy/upload/
        // 맥 경로	-> /Users/kangsubin/Desktop/javaStudy/upload/
    }
}