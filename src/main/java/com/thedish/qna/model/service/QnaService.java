package com.thedish.qna.model.service;

import java.util.List;

import com.thedish.common.Paging;
import com.thedish.qna.model.vo.Qna;

public interface QnaService {

	List<Qna> selectQnaList (String userId);
	int insertQna (Qna qna);
	Qna selectQnaById (int qnaId);
	int deleteQna (int qnaId);
	int updateQna (Qna qna);
	int answerQna(Qna qna);
	List<Qna> selectAllQna ();
	int getListCount(String userId);
	List<Qna> selectList(Paging paging, String userId);
}
