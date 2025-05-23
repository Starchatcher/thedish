package com.thedish.board.model.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.thedish.board.model.vo.Board;
import com.thedish.comment.model.vo.Comment;
import com.thedish.common.Paging;
import com.thedish.common.Search;
import com.thedish.reportPost.model.vo.ReportPost;

public interface BoardService {

	int selectBoardCategoryCount(String category);
	int selectBoardListCount();
	int selectMyBoardListCount(String loginId);
	
	List<Board> selectMyBoardList (Map<String, Object> param);
	ArrayList<Board> selectBoardList(Paging paging);
	List<Board> selectBoardCategoryList(Map<String, Object> param);
	Board selectBoard(int boardId);
	
	void updateViewCount(int boardId);
	int insertBoard(Board board);
	int updateBoard(Board board);
	int deleteBoard(Board board);
	int deleteBoardReports (Board board);
	
	int selectSearchTitleCount(Search search);
	int selectSearchWriterCount(Search search);
	ArrayList<Board> selectSearchTitle(Search search);
	ArrayList<Board> selectSearchWriter(Search search);
	
	ArrayList<Board> selectSearchTitleAll(Search search);
	int selectSearchTitleAllCount(String keyword);
	ArrayList<Board> selectSearchWriterAll(Search search);
	int selectSearchWriterAllCount(String keyword);
	
	int selectSearchContentCount(Search search);
	ArrayList<Board> selectSearchContent(Search search);
	int selectSearchContentAllCount(String keyword);
	ArrayList<Board> selectSearchContentAll(Search search);
	
	int selectBoardCommentCount (int targetId);
	List<Comment> selectBoardComment (Map<String, Object> param);
	List<Comment> selectRepliesByBoardId (int boardId);
	int insertBoardComment(Comment comment);
	
	int updateBoardComment(Comment comment);
	int deleteBoardComment(Map<String, Object> param);
	int deleteCommentsByBoardId(Map<String, Object> param);
	List<ReportPost> selectListReportedPost(Map<String, Object> param);
	int selectReportedPostCount ();
	int updateReportChecked (int reportId);
	int insertBoardReport(ReportPost reportPost);
}
