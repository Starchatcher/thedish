package com.thedish.board.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.thedish.board.model.vo.Board;
import com.thedish.common.Paging;

@Repository("BoardDao")
public class BoardDao {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	
	// 게시판 목록 총 갯수 조회용 쿼리 -----------------------------------------------------
	public int selectBoardListCount() {
		return sqlSessionTemplate.selectOne("boardMapper.selectBoardListCount");
	}
	
	public int selectFreeBoardListCount() {
		return sqlSessionTemplate.selectOne("boardMapper.selectFreeBoardListCount");
	}
	
	public int selectReviewBoardListCount() {
		return sqlSessionTemplate.selectOne("boardMapper.selectReviewBoardListCount");
	}
	
	public int selectTipBoardListCount() {
		return sqlSessionTemplate.selectOne("boardMapper.selectTipBoardListCount");
	}
	
	public Board selectBoard(int boardId) {
		return sqlSessionTemplate.selectOne("boardMapper.selectBoard", boardId);
	}
	
	
	// 게시판 목록 리스트 조회용 쿼리 --------------------------------------------------
	public ArrayList<Board> selectBoardList (Paging paging){
		List<Board> list = sqlSessionTemplate.selectList("boardMapper.selectBoardList", paging);
		return (ArrayList<Board>)list;
	}
	
	public ArrayList<Board> selectFreeBoardList (Paging paging){
		List<Board> list = sqlSessionTemplate.selectList("boardMapper.selectFreeBoardList", paging);
		return (ArrayList<Board>)list;
	}
	
	public ArrayList<Board> selectReviewBoardList(Paging paging){
		List<Board> list = sqlSessionTemplate.selectList("boardMapper.selectReviewBoardList", paging);
		return (ArrayList<Board>)list;
	}
	
	public ArrayList<Board> selectTipBoardList(Paging paging){
		List<Board> list = sqlSessionTemplate.selectList("boardMapper.selectTipBoardList", paging);
		return (ArrayList<Board>)list;
	}
	
	// dml -----------------------------------------------------------------------
	public void updateViewCount(int boardId) {
		sqlSessionTemplate.update("boardMapper.updateViewCount", boardId);
	}
	
}
