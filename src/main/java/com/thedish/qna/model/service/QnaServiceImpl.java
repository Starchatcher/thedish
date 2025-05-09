package com.thedish.qna.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
}
