package com.thedish.qna.model.dao;

import java.util.List;
import java.util.Map;

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
	
	// 문의 수정
	public int updateQna (Qna qna) {
		return sqlSessionTemplate.update("qnaMapper.updateQna", qna);
	}
	
	// 문의 상세보기
	public Qna selectQnaById (int qnaId) {
		return sqlSessionTemplate.selectOne("qnaMapper.selectQnaById", qnaId);
	}
	
	// 문의 삭제
	public int deleteQna (int qnaId) {
		return sqlSessionTemplate.delete("qnaMapper.deleteQna", qnaId);
	}
	
	// 문의 답변
	public int answerQna(Qna qna) {
	    return sqlSessionTemplate.update("qnaMapper.answerQna", qna);
	}
	
	// 모든 qna 목록 조회(관리자)
	public List<Qna> selectAllQna() {
		return sqlSessionTemplate.selectList("qnaMapper.selectAllQna");
	}
	
	public int getListCount(String userId) {
	    return sqlSessionTemplate.selectOne("qnaMapper.getListCount", userId);
	}

	public List<Qna> selectPageList(Map<String, Object> map) {
	    return sqlSessionTemplate.selectList("qnaMapper.selectPageList", map);
	}

}
