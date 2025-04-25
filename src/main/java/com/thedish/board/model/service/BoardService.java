package com.thedish.board.model.service;

import java.util.ArrayList;

import com.thedish.board.model.vo.Board;
import com.thedish.common.Paging;

public interface BoardService {

	int selectBoardListCount();
	int selectFreeBoardListCount();
	int selectReviewBoardListCount();
	int selectTipBoardListCount();
	Board selectBoard(int boardId);
	void updateViewCount(int boardId);
	
	ArrayList<Board> selectBoardList (Paging paging);
	ArrayList<Board> selectFreeBoardList (Paging paging);
	ArrayList<Board> selectReviewBoardList (Paging paging);
	ArrayList<Board> selectTipBoardList (Paging paging);
}
