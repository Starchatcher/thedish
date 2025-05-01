package com.thedish.board.model.dao;

import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.thedish.board.model.vo.Board;
import com.thedish.comment.model.vo.Comment;
import com.thedish.common.Paging;
import com.thedish.common.Search;

@Repository("BoardDao")
public class BoardDao {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	// 게시판 총 갯수 조회용 쿼리
	public int selectBoardListCount() {
		return sqlSessionTemplate.selectOne("boardMapper.selectBoardListCount");
	}
	
	public int selectBoardCategoryCount(String category) {
	    return sqlSessionTemplate.selectOne("boardMapper.selectBoardCategoryCount", category);
	}
	// 게시판 목록 리스트 조회용 쿼리 --------------------------------------------------
	public List<Board> selectBoardCategoryList(Map<String, Object> param) {
	    return sqlSessionTemplate.selectList("boardMapper.selectBoardCategoryList", param);
	}
	
	public ArrayList<Board> selectBoardList(Paging paging){
		List<Board> list = sqlSessionTemplate.selectList("boardMapper.selectBoardList", paging);
		return (ArrayList<Board>) list;
	}
	
	// 게시글 상세조회용 쿼리
	public Board selectBoard(int boardId) {
		return sqlSessionTemplate.selectOne("boardMapper.selectBoard", boardId);
	}
	
	
	// dml -----------------------------------------------------------------------
	public void updateViewCount(int boardId) {
		sqlSessionTemplate.update("boardMapper.updateViewCount", boardId);
	}
	
	public int insertBoard(Board board) {
		return sqlSessionTemplate.insert("boardMapper.insertBoard", board);
	}
	
	public int updateBoard(Board board) {
		return sqlSessionTemplate.update("boardMapper.updateBoard", board);
	}

	public int deleteBoard(Board board) {
		return sqlSessionTemplate.delete("boardMapper.deleteBoard", board);
	}
	
	// 검색 관련 --------------------------------------------------------------------
	public ArrayList<Board> selectSearchTitleAll(Search search){
		List<Board> list = sqlSessionTemplate.selectList("boardMapper.selectSearchTitleAll", search);
		return (ArrayList<Board>)list;
	}
	
	public int selectSearchTitleAllCount(String keyword) {
		return sqlSessionTemplate.selectOne("boardMapper.selectSearchTitleAllCount", keyword);
	}
	
	public ArrayList<Board> selectSearchWriterAll(Search search){
		List<Board> list = sqlSessionTemplate.selectList("boardMapper.selectSearchWriterAll", search);
		return (ArrayList<Board>)list;
	}
	
	public int selectSearchWriterAllCount(String keyword) {
		return sqlSessionTemplate.selectOne("boardMapper.selectSearchWriterAllCount", keyword);
	}
	
	public int selectSearchTitleCount(Search search) {
		return sqlSessionTemplate.selectOne("boardMapper.selectSearchTitleCount", search);
	}
	
	public int selectSearchWriterCount(Search search) {
		return sqlSessionTemplate.selectOne("boardMapper.selectSearchWriterCount", search);
	}
	
	public ArrayList<Board> selectSearchTitle(Search search){
		List<Board> list = sqlSessionTemplate.selectList("boardMapper.selectSearchTitle", search);
		return (ArrayList<Board>)list;
	}
	
	public ArrayList<Board> selectSearchWriter(Search search){
		List<Board> list = sqlSessionTemplate.selectList("boardMapper.selectSearchWriter", search);
		return (ArrayList<Board>)list;
	}
	
	public int selectSearchContentCount(Search search) {
		return sqlSessionTemplate.selectOne("boardMapper.selectSearchContentCount", search);
	}
	
	public ArrayList<Board> selectSearchContent (Search search){
		List<Board> list = sqlSessionTemplate.selectList("boardMapper.selectSearchContent", search);
		return (ArrayList<Board>)list;
	}
	
	public int selectSearchContentAllCount(String keyword) {
		return sqlSessionTemplate.selectOne("boardMapper.selectSearchContentAllCount", keyword);
	}
	
	public ArrayList<Board> selectSearchContentAll(Search search){
		List<Board> list = sqlSessionTemplate.selectList("boardMapper.selectSearchContentAll", search);
		return (ArrayList<Board>) list;
	}
	
	// 게시판 댓글 조회용 쿼리
	public int selectBoardCommentCount (int targetId) {
		return sqlSessionTemplate.selectOne("commentMapper.selectBoardCommentCount", targetId);
	}
	
	public List<Comment> selectBoardComment (Map<String, Object> param){
		return sqlSessionTemplate.selectList("commentMapper.selectBoardComment", param);
	}
	
	// 댓글 작성용 쿼리
	public int insertBoardComment(Comment comment) {
		return sqlSessionTemplate.insert("commentMapper.insertBoardComment", comment);
	}
	
	// 댓글 수정용 쿼리
	public int updateBoardComment(Comment comment) {
		return sqlSessionTemplate.update("commentMapper.updateBoardComment", comment);
	}
	
	// 댓글 삭제용 쿼리
	public int deleteBoardComment(int commentId) {
		return sqlSessionTemplate.delete("commentMapper.deleteBoardComment", commentId);
	}
	
	
	
	
	
	
	
}
