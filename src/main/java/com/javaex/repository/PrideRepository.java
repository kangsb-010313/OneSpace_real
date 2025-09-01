package com.javaex.repository;

import com.javaex.vo.PrideVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;

@Mapper
public interface PrideRepository {

    // 목록(페이징) — teamNo 필터 포함
    List<PrideVO> selectPrideCards(@Param("teamPostType") String teamPostType,
                                   @Param("teamNo") Long teamNo,
                                   @Param("limit") int limit,
                                   @Param("offset") int offset);

    // 총 개수 — teamNo 필터 포함
    int countPride(@Param("teamPostType") String teamPostType,
                   @Param("teamNo") Long teamNo);

    // 상세(단건)
    PrideVO selectPrideDetail(@Param("teamPostType") String teamPostType,
                              @Param("id") Long id);

    // 상세 이미지 URL 목록
    List<String> selectPrideImages(@Param("id") Long id);
}