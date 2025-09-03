package com.javaex.repository;

import com.javaex.vo.PrideVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;

@Mapper
public interface PrideRepository {

    // 목록(페이징) — teamNo 필터 포함
	List<PrideVO> selectPrideCards(
	        @Param("teamPostType") String teamPostType,
	        @Param("teamNo")       Long teamNo,
	        @Param("limit")        int limit,
	        @Param("offset")       int offset
	    );

	    int countPride(
	        @Param("teamPostType") String teamPostType,
	        @Param("teamNo")       Long teamNo
	    );

	    PrideVO selectPrideDetail(
	        @Param("teamPostType") String teamPostType,
	        @Param("id")           Long id
	    );

	    List<String> selectPrideImages(@Param("id") Long id);
}