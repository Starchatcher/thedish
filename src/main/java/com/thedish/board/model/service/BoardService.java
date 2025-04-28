package com.thedish.board.model.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.thedish.board.model.vo.Board;
import com.thedish.common.Paging;
import com.thedish.common.Search;

public interface BoardService {

	int selectBoardCategoryCount(String category);
	int selectBoardListCount();
	ArrayList<Board> selectBoardList(Paging paging);
	List<Board> selectBoardCategoryList(Map<String, Object> param);
	Board selectBoard(int boardId);
	
	void updateViewCount(int boardId);
	int insertBoard(Board board);
	
	int selectSearchTitleCount(Search search);
	int selectSearchWriterCount(Search search);
	ArrayList<Board> selectSearchTitle(Search search);
	ArrayList<Board> selectSearchWriter(Search search);
	
	ArrayList<Board> selectSearchTitleAll(Search search);
	int selectSearchTitleAllCount(String keyword);
	ArrayList<Board> selectSearchWriterAll(Search search);
	int selectSearchWriterAllCount(String keyword);
}
