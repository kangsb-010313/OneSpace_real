package com.javaex.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.javaex.vo.PrideVO;

@Mapper
public interface PrideRepository {

    
	List<PrideVO> selectPridePage(@Param("offset") int offset, @Param("size") int size);
	long countPride();
	PrideVO selectPrideOne(@Param("teamPostNo") Long teamPostNo);
	void insertPride(PrideVO pride);
}
