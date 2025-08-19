package com.javaex.repository;

import com.javaex.vo.PrideVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;

@Mapper
public interface PrideRepository {

    // 게시글 페이지 조회 (무한스크롤용)
    List<PrideVO> selectPage(@Param("offset") int offset, @Param("size") int size);

    // 게시글 전체 개수 (무한스크롤 마지막 페이지 판별용)
    int countAll();

    // 게시글 상세 조회
    PrideVO selectOne(@Param("id") Long id);

    // 게시글 등록
    int insert(PrideVO pride);
}
