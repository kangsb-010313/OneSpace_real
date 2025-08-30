package com.javaex.repository;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import com.javaex.vo.PrideVO;

@Mapper
public interface PrideRepository {

    // 카드 목록 (팀자랑 전용)
    List<PrideVO> selectPrideCards(@Param("teamPostType") String teamPostType,
                                   @Param("limit") int limit,
                                   @Param("offset") int offset);

    // 총 개수
    int countPride(@Param("teamPostType") String teamPostType);

    // 상세
    PrideVO selectPrideDetail(@Param("teamPostType") String teamPostType,
                              @Param("id") Long id);

    // 상세 첨부 이미지 경로 리스트
    List<String> selectPrideImages(@Param("id") Long id);
}
