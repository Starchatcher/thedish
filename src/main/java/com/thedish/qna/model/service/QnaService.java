package com.thedish.qna.model.service;

import java.util.List;

import com.thedish.qna.model.vo.Qna;

public interface QnaService {

	List<Qna> selectQnaList (String userId);
	int insertQna (Qna qna);
	Qna selectQnaById (int qnaId);
	int deleteQna (int qnaId);
}
