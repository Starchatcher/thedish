package com.thedish.board.model.service;

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
	public int selectFreeBoardListCount() {
		return boardDao.selectFreeBoardListCount();
	}

	@Override
	public ArrayList<Board> selectFreeBoardList(Paging paging) {
		return boardDao.selectFreeBoardList(paging);
	}

	@Override
	public int selectReviewBoardListCount() {
		return boardDao.selectReviewBoardListCount();
	}

	@Override
	public int selectTipBoardListCount() {
		return boardDao.selectTipBoardListCount();
	}

	@Override
	public ArrayList<Board> selectReviewBoardList(Paging paging) {
		return boardDao.selectReviewBoardList(paging);
	}

	@Override
	public ArrayList<Board> selectTipBoardList(Paging paging) {
		return boardDao.selectTipBoardList(paging);
	}

	@Override
	public int selectBoardListCount() {
		return boardDao.selectBoardListCount();
	}

	@Override
	public ArrayList<Board> selectBoardList(Paging paging) {
		return boardDao.selectBoardList(paging);
	}

	@Override
	public Board selectBoard(int boardId) {
		return boardDao.selectBoard(boardId);
	}

	@Override
	public void updateViewCount(int boardId) {
		boardDao.updateViewCount(boardId);
		
	}

	@Override
	public int insertBoard(Board board) {
		return boardDao.insertBoard(board);
	}
	
	

	
}
