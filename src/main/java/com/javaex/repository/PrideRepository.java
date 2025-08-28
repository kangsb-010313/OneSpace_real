package com.javaex.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.javaex.vo.PrideVO;

@Mapper
public interface PrideRepository {

    
     // 팀자랑 게시글 목록 조회 (페이징)
     
    List<PrideVO> selectPridePage(@Param("offset") int offset, @Param("size") int size); 
    
    //팀자랑 게시글 총 개수 조회
    long countPride();                                                                    

    
     //특정 게시글 상세 조회
    PrideVO selectPrideOne(@Param("teamPostNo") Long teamPostNo);                       

    
    //게시글 등록
    int insertPride(PrideVO pride);                                                       
}
