package com.thedish.board.service;

import java.util.ArrayList;

import com.thedish.board.model.vo.Board;
import com.thedish.common.Paging;

public interface BoardService {

	int selectListCount();
	ArrayList<Board> selectList (Paging paging);
}
