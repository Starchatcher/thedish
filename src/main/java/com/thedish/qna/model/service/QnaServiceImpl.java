package com.thedish.qna.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.thedish.common.Paging;
import com.thedish.qna.model.dao.QnaDao;
import com.thedish.qna.model.vo.Qna;

@Service("QnaService")
public class QnaServiceImpl implements QnaService{

	@Autowired
	private QnaDao qnaDao;

	@Override
	public List<Qna> selectQnaList(String userId) {
		return qnaDao.selectQnaList(userId);
	}

	@Override
	public int insertQna(Qna qna) {
		return qnaDao.insertQna(qna);
	}

	@Override
	public Qna selectQnaById(int qnaId) {
		return qnaDao.selectQnaById(qnaId);
	}

	@Override
	public int deleteQna(int qnaId) {
		return qnaDao.deleteQna(qnaId);
	}

	@Override
	public int updateQna(Qna qna) {
		return qnaDao.updateQna(qna);
	}

	@Override
	public int answerQna(Qna qna) {
	    return qnaDao.answerQna(qna);
	}

	@Override
	public List<Qna> selectAllQna() {
		return qnaDao.selectAllQna();
	}
	
	@Override
	public int getListCount(String userId) {
	    return qnaDao.getListCount(userId);
	}

	@Override
	public List<Qna> selectList(Paging paging, String userId) {
	    Map<String, Object> map = new HashMap<>();
	    map.put("start", paging.getStartRow());
	    map.put("end", paging.getEndRow());
	    map.put("userId", userId);
	    return qnaDao.selectPageList(map);
	}
}
