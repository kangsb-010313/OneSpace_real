package com.javaex.repository;

import com.javaex.vo.PrideVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;


@Mapper
public interface PrideRepository {
    List<PrideVO> selectPridePage(@Param("offset") int offset, @Param("size") int size); 
    long countPride();                                                                    
    PrideVO selectPrideOne(@Param("teamPostNo") Long teamPostNo);                       
    int insertPride(PrideVO pride);                                                       
}
