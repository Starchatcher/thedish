package com.thedish.board.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.thedish.board.dao.BoardDao;
import com.thedish.board.model.vo.Board;
import com.thedish.common.Paging;

@Service("boardService")
public class BoardServiceImpl implements BoardService{

	@Autowired
	private BoardDao boardDao;
	
	@Override
	public int selectListCount() {
		return boardDao.selectListCount();
	}

	@Override
	public ArrayList<Board> selectList(Paging paging) {
		return boardDao.selectList(paging);
	}

	
}
