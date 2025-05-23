package com.thedish.board.model.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.thedish.board.model.dao.BoardDao;
import com.thedish.board.model.vo.Board;
import com.thedish.comment.model.vo.Comment;
import com.thedish.common.Paging;
import com.thedish.common.Search;
import com.thedish.reportPost.model.vo.ReportPost;

@Service("boardService")
public class BoardServiceImpl implements BoardService{

	@Autowired
	private BoardDao boardDao;

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

	@Override
	public ArrayList<Board> selectSearchTitle(Search search) {
		return boardDao.selectSearchTitle(search);
	}

	@Override
	public ArrayList<Board> selectSearchWriter(Search search) {
		return boardDao.selectSearchWriter(search);
	}

	@Override
	public int selectSearchTitleCount(Search search) {
		return boardDao.selectSearchTitleCount(search);
	}

	@Override
	public int selectSearchWriterCount(Search search) {
		return boardDao.selectSearchWriterCount(search);
	}

	@Override
	public int selectBoardCategoryCount(String category) {
		return boardDao.selectBoardCategoryCount(category);
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
	public List<Board> selectBoardCategoryList(Map<String, Object> param) {
		return boardDao.selectBoardCategoryList(param);
	}

	@Override
	public ArrayList<Board> selectSearchTitleAll(Search search) {
		return boardDao.selectSearchTitleAll(search);
	}

	@Override
	public int selectSearchTitleAllCount(String keyword) {
		return boardDao.selectSearchTitleAllCount(keyword);
	}

	@Override
	public ArrayList<Board> selectSearchWriterAll(Search search) {
		return boardDao.selectSearchWriterAll(search);
	}

	@Override
	public int selectSearchWriterAllCount(String keyword) {
		return boardDao.selectSearchWriterAllCount(keyword);
	}

	@Override
	public int selectSearchContentCount(Search search) {
		return boardDao.selectSearchContentCount(search);
	}

	@Override
	public ArrayList<Board> selectSearchContent(Search search) {
		return boardDao.selectSearchContent(search);
	}

	@Override
	public int selectSearchContentAllCount(String keyword) {
		return boardDao.selectSearchContentAllCount(keyword);
	}

	@Override
	public ArrayList<Board> selectSearchContentAll(Search search) {
		return boardDao.selectSearchContentAll(search);
	}

	@Override
	public int updateBoard(Board board) {
		return boardDao.updateBoard(board);
	}

	@Override
	public int deleteBoard(Board board) {
		return boardDao.deleteBoard(board);
	}

	@Override
	public int selectBoardCommentCount(int targetId) {
		return boardDao.selectBoardCommentCount(targetId);
	}

	@Override
	public List<Comment> selectBoardComment(Map<String, Object> param) {
		return boardDao.selectBoardComment(param);
	}

	@Override
	public int insertBoardComment(Comment comment) {
		return boardDao.insertBoardComment(comment);
	}

	@Override
	public int updateBoardComment(Comment comment) {
		return boardDao.updateBoardComment(comment);
	}

	@Override
	public int deleteBoardComment(Map<String, Object> param) {
		return boardDao.deleteBoardComment(param);
	}

	@Override
	public int deleteCommentsByBoardId(Map<String, Object> param) {
		return boardDao.deleteCommentsByBoardId(param);
	}

	@Override
	public int deleteBoardReports(Board board) {
		return boardDao.deleteBoardReports(board);
	}

	@Override
	public List<Comment> selectRepliesByBoardId(int boardId) {
		return boardDao.selectRepliesByBoardId(boardId);
	}

	@Override
	public int selectMyBoardListCount(String loginId) {
		return boardDao.selectMyBoardListCount(loginId);
	}

	@Override
	public List<Board> selectMyBoardList(Map<String, Object> param) {
		return boardDao.selectMyBoardList(param);
	}

	@Override
	public List<ReportPost> selectListReportedPost(Map<String, Object> param) {
		return boardDao.selectListReportedPost(param);
	}

	@Override
	public int selectReportedPostCount() {
		return boardDao.selectReportedPostCount();
	}

	@Override
	public int updateReportChecked(int reportId) {
		return boardDao.updateReportChecked(reportId);
	}

	@Override
	public int insertBoardReport(ReportPost reportPost) {
		return boardDao.insertBoardReport(reportPost);
	}

}
