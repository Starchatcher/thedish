package com.thedish.qna.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.thedish.qna.model.vo.Qna;

@Repository("QnaDao")
public class QnaDao {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	// 내 문의 목록 출력
	public List<Qna> selectQnaList (String userId){
		return sqlSessionTemplate.selectList("qnaMapper.selectQnaList", userId);
	}
	
	// 문의 등록
	public int insertQna (Qna qna) {
		return sqlSessionTemplate.insert("qnaMapper.insertQna", qna);
	}
	
	// 문의 상세보기
	public Qna selectQnaById (int qnaId) {
		return sqlSessionTemplate.selectOne("qnaMapper.selectQnaById", qnaId);
	}
	
	// 문의 삭제
	public int deleteQna (int qnaId) {
		return sqlSessionTemplate.delete("qnaMapper.deleteQna", qnaId);
	}
}
