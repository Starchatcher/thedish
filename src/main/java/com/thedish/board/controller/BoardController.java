package com.thedish.board.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.thedish.board.model.service.BoardService;
import com.thedish.board.model.vo.Board;
import com.thedish.comment.model.vo.Comment;
import com.thedish.common.FileNameChange;
import com.thedish.common.Paging;
import com.thedish.common.Search;
import com.thedish.like.model.service.LikeService;
import com.thedish.reportPost.model.service.ReportPostService;
import com.thedish.reportPost.model.vo.ReportPost;
import com.thedish.users.model.vo.Users;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class BoardController {
	// 로그 객체 생성
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);

	@Autowired
	private BoardService boardService;
	
	@Autowired
	private LikeService likeService;
	
	@Autowired
	private ReportPostService reportPostService;
	// 뷰 페이지 내보내기용 메소드 ---------------------------------------

	// 게시글 작성 페이지 내보내기
	@RequestMapping("boardWritePage.do")
	public String moveWritePage() {
		return "board/boardWriteView";
	}
	
	// 게시글 신고 페이지 내보내기
	@RequestMapping("boardReportPage.do")
	public ModelAndView moveReportPage(
	        @RequestParam("targetId") int targetId,
	        @RequestParam("category") String category,
	        ModelAndView mv) {

	    mv.addObject("targetId", targetId);
	    mv.addObject("category", category);
	    mv.setViewName("board/boardReportView");
	    return mv;
	}
	
	// 게시글 수정 페이지 내보내기
	@RequestMapping("boardUpdatePage.do")
	public String moveUpdatePage(Model model, @RequestParam("boardId") int boardId,
			@RequestParam("page") int currentPage) {

		// 수정 페이지로 전달할 board 정보 조회
		Board board = boardService.selectBoard(boardId);
		if (board != null) {
			model.addAttribute("board", board);
			model.addAttribute("page", currentPage);
			return "board/boardUpdateView";
		} else {
			model.addAttribute("message", boardId + "번 게시글 수정페이지로 이동하는 것을 실패하였습니다. 관리자에게 문의하세요.");
			return "common/error";
		}

	}

	// 요청 처리용 메소드 ----------------------------------------------
	@RequestMapping("boardList.do")
	public ModelAndView selectListBoard(ModelAndView mv, @RequestParam(name = "page", required = false) String page,
			@RequestParam(name = "limit", required = false) String slimit,
			@RequestParam(name = "category", required = false) String category) {

		int currentPage = (page != null) ? Integer.parseInt(page) : 1;
		int limit = (slimit != null) ? Integer.parseInt(slimit) : 10;

		int listCount = (category != null) ? boardService.selectBoardCategoryCount(category)
				: boardService.selectBoardListCount();

		Paging paging = new Paging(listCount, limit, currentPage, "boardList.do");
		paging.calculate();

		List<Board> list;
		if (category != null) {
			Map<String, Object> param = new HashMap<>();
			param.put("startRow", paging.getStartRow());
			param.put("endRow", paging.getEndRow());
			param.put("category", category);

			list = boardService.selectBoardCategoryList(param);
		} else {
			list = boardService.selectBoardList(paging);
		}
		
		for (Board board : list) {
		    int likeCount = likeService.countLikes(board.getBoardId());
		    board.setLikeCount(likeCount);  // Board VO에 likeCount 필드 필요
		}
		
		for (Board board : list) {
		    int commentCount = boardService.selectBoardCommentCount(board.getBoardId());
		    board.setCommentCount(commentCount);
		}

		mv.addObject("list", list);
		mv.addObject("paging", paging);
		mv.addObject("category", category);
		mv.setViewName("board/boardListView");
		return mv;
	}

	// 게시글 상세보기 (댓글 목록 포함)
	@RequestMapping("boardDetail.do")
	public ModelAndView boardDetailView(
			@RequestParam("boardId") int boardId,
			@RequestParam(name = "page", required = false) String page, 
			@RequestParam("category") String category,
			@RequestParam(name = "editCommentId", required = false) Integer editCommentId,
			ModelAndView mv, HttpSession session, HttpServletRequest request) {

		logger.info("boardDetail.do : " + boardId);

		Users loginUser = (Users) session.getAttribute("loginUser");
		
		if(loginUser != null) {
			boolean liked = likeService.isLiked(loginUser.getLoginId(), boardId);
			request.setAttribute("liked", liked);
		}
		
		int currentPage = 1; // 상세보기 페이지에서 목록 버튼 누르면, 보고있던 목록 페이지로 돌아가기 위해 저장함
		if (page != null) {
			currentPage = Integer.parseInt(page);
		}

		Board board = boardService.selectBoard(boardId);
		board.setLikeCount(likeService.countLikes(boardId));
		// 조회수 1증가 처리
		boardService.updateViewCount(boardId);

		if (board != null) {
			// 댓글 개수 조회
			int commentCount = boardService.selectBoardCommentCount(boardId);

			int limit = 10; // 한 페이지에 보일 댓글 수
			// 페이징 객체 생성해서 댓글 갯수에 따른 페이징 처리
			Paging commentPaging = new Paging(commentCount, limit, currentPage, "boardDetail.do");
			commentPaging.calculate();

			// 댓글 목록 조회용 파라미터 구성
			Map<String, Object> commentParam = new HashMap<>();
			commentParam.put("targetId", boardId); // 대상 아이디
			commentParam.put("startRow", commentPaging.getStartRow()); // 페이징 시작행
			commentParam.put("endRow", commentPaging.getEndRow()); // 페이징 끝행

			List<Comment> commentList = boardService.selectBoardComment(commentParam);

			if (editCommentId != null) {
				mv.addObject("editCommentId", editCommentId);
			}
			mv.addObject("commentCount", commentCount); // 댓글의 총 개수
			mv.addObject("commentList", commentList); // 댓글 리스트
			mv.addObject("board", board); // 게시글 객체
			mv.addObject("currentPage", currentPage); // 게시글 페이지 정보
			mv.addObject("category", category); // 게시글 카테고리
			mv.addObject("commentPaging", commentPaging); // 댓글 페이징 객체
			mv.setViewName("board/boardDetailView");
		} else {
			mv.addObject("message", boardId + "번 게시글 상세보기 요청 실패!");
			mv.setViewName("common/error");
		}

		return mv;
	}

	// 첨부파일 다운로드 요청 처리용 메소드
	// 스프링에서 파일 다운로드는 스프링이 제공하는 View 클래스를 상속받은 클래스를 사용하도록 정함
	// => 파일다운로드용 뷰 클래스를 따로 만듦 => 뷰리졸버에서 연결 처리함
	// => 리턴타입은 반드시 ModelAndView 여야 함
	@RequestMapping("boardFileDown.do")
	public ModelAndView fileDownMethod(ModelAndView mv, HttpServletRequest request,
			@RequestParam("ofile") String originalFileName, @RequestParam("rfile") String renameFileName) {

		// 게시글 첨부파일 저장 폴더 경로 지정
		String savePath = request.getSession().getServletContext().getRealPath("resources/board_upfiles");
		// 저장 폴더에서 읽을 파일에 대한 File 객체 생성
		File downFile = new File(savePath + "\\" + renameFileName);
		// 파일 다운시 브라우저로 내보낼 원래 파일에 대한 File 객체 생성
		File originFile = new File(originalFileName);

		// 파일 다운 처리용 뷰클래스 id명과 다운로드할 File 객체를 ModelAndView 에 담아서 리턴함
		mv.setViewName("filedown"); // 뷰클래스의 id명 기입
		mv.addObject("originFile", originFile);
		mv.addObject("renameFile", downFile);

		return mv;
	}

	// 새 게시글 원글 등록 요청 처리용 (파일 업로드 기능 포함)
	@RequestMapping(value = "boardInsert.do", method = RequestMethod.POST)
	public String boardInsertMethod(Board board, @RequestParam(name = "ofile", required = false) MultipartFile mfile,
			@RequestParam(name = "boardType") String category, HttpServletRequest request, HttpSession session,
			ModelAndView mv) {

		// 로그인 유저 세션에서 가져와 작성자 세팅
		Users loginUser = (Users) session.getAttribute("loginUser");
		if (loginUser == null) {
			mv.setViewName("common/error");
			mv.addObject("message", "로그인이 필요합니다.");
			return "common/error"; // String 반환 형식은 변경되지 않음
		}
		board.setWriter(loginUser.getLoginId());
		board.setBoardCategory(category);

		// 현재 시간 자동 설정
		board.setCreatedAt(new java.sql.Date(System.currentTimeMillis()));
		board.setUpdatedAt(new java.sql.Date(System.currentTimeMillis()));

		// 파일 저장 로직
		String savePath = request.getSession().getServletContext().getRealPath("resources/board_upfiles");
		if (!mfile.isEmpty()) {
			String fileName = mfile.getOriginalFilename();
			if (fileName != null && fileName.length() > 0) {
				String renameFileName = FileNameChange.change(fileName, "yyyyMMddHHmmss");
				try {
					File saveDir = new File(savePath);
					if (!saveDir.exists())
						saveDir.mkdirs();
					mfile.transferTo(new File(savePath + "\\" + renameFileName));
					board.setOriginalFileName(fileName);
					board.setRenameFileName(renameFileName);
				} catch (Exception e) {
					e.printStackTrace();
					mv.setViewName("common/error");
					mv.addObject("message", "첨부파일 저장 실패!");
					return "common/error";
				}
			}
		}

		// 게시글 등록
		if (boardService.insertBoard(board) > 0) {
			mv.setViewName("redirect:boardList.do");
		} else {
			mv.setViewName("common/error");
			mv.addObject("message", "새 게시글 등록 실패!");
		}

		return mv.getViewName(); // ModelAndView 객체의 viewName을 리턴
	}

	// 게시글 수정 메소드
	@RequestMapping(value = "boardUpdate.do", method = RequestMethod.POST)
	public ModelAndView boardUpdateMethod(ModelAndView mv, Board board, HttpServletRequest request,
			@RequestParam(name = "deleteFile", required = false) String delFlag,
			@RequestParam(name = "ofile", required = false) MultipartFile mfile,
			@RequestParam(name = "page", required = false) String page) {

		int currentPage = 1;
		if (page != null && !page.trim().isEmpty()) {
			currentPage = Integer.parseInt(page.trim());
		}

		// 첨부파일 관련 변경 사항 처리
		String savePath = request.getSession().getServletContext().getRealPath("resources/board_upfiles");

		// 1. 원래 첨부파일이 있는데 파일삭제를 원할 경우
		// OR 원래 첨부파일이 있는데 새로운 첨부파일로 변경할 경우
		// => 이전 파일 정보 삭제
		if (board.getOriginalFileName() != null && ("yes".equals(delFlag) || !mfile.isEmpty())) {
			new File(savePath + "\\" + board.getRenameFileName()).delete();
			board.setOriginalFileName(null);
			board.setRenameFileName(null);
		}

		// 2. 첨부파일이 있을 때 (변경 OR 추가)
		if (!mfile.isEmpty()) {
			// 전송 온 파일이름 추출
			String fileName = mfile.getOriginalFilename();
			String renameFileName = null;

			// 저장 폴더에는 변경된 파일이름으로 파일을 저장 처리함
			// 바꿀 파일명 : 년월일시분초.확장자
			if (fileName != null && fileName.length() > 0) {
				renameFileName = FileNameChange.change(fileName, "yyyyMMddHHmmss");

				try {
					mfile.transferTo(new File(savePath + "\\" + renameFileName));
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
					mv.addObject("message", "첨부파일 저장에 실패하였습니다. 다시 시도해주세요.");
					mv.setViewName("common/error");

					return mv;
				}
			} // 파일명 바꾸어 저장

			board.setOriginalFileName(fileName);
			board.setRenameFileName(renameFileName);
		}

		if (boardService.updateBoard(board) > 0) {
			mv.addObject("boardId", board.getBoardId());
			mv.setViewName("redirect:boardDetail.do?boardId=" + board.getBoardId() + "&page=" + currentPage
					+ "&category=" + board.getBoardCategory());
		} else {
			mv.addObject("message", "게시글 수정에 실패하였습니다. 다시 시도해주세요.");
			mv.setViewName("common/error");
		}

		return mv;
	}

	// 게시글 삭제용 메소드
	@RequestMapping("boardDelete.do")
	public ModelAndView boardDeleteMethod(@RequestParam("boardId") int boardId,
			@RequestParam(name = "page", required = false) String page,
			@RequestParam(name = "category", required = false) String category, HttpServletRequest request,
			ModelAndView mv,
			HttpSession session) {

		Users loginUser = (Users) session.getAttribute("loginUser");
	    if (loginUser == null) {
	        mv.setViewName("redirect:loginPage.do");
	        return mv;
	    }

	    // 댓글 & 대댓글 먼저 삭제
	    Map<String, Object> param = new HashMap<>();
	    param.put("targetType", "board");
	    param.put("targetId", boardId);

	    boardService.deleteCommentsByBoardId(param);
		
		Board board = boardService.selectBoard(boardId); // 게시글 정보 조회

		if (boardService.deleteBoard(board) > 0) {
			// 첨부파일 삭제
			if (board.getOriginalFileName() != null && board.getRenameFileName().length() > 0) {
				String savePath = request.getSession().getServletContext().getRealPath("resources/board_upfiles");
				new File(savePath + "\\" + board.getRenameFileName()).delete();
			}

			// 리다이렉트 경로 설정
			String redirectUrl = "redirect:boardList.do";
			if (category != null && !category.trim().isEmpty()) {
				redirectUrl += "?category=" + category;
				if (page != null && !page.trim().isEmpty()) {
					redirectUrl += "&page=" + page;
				}
			} else if (page != null && !page.trim().isEmpty()) {
				redirectUrl += "?page=" + page;
			}

			mv.setViewName(redirectUrl);
		} else {
			mv.addObject("message", boardId + "번 게시글 삭제 실패!");
			mv.setViewName("common/error");
		}

		return mv;
	}
	
	// 댓글 작성용 메소드
	@RequestMapping(value = "boardCommentInsert.do", method = RequestMethod.POST)
	public ModelAndView insertComment(ModelAndView mv, HttpSession session,
	        @RequestParam("boardId") int boardId,
	        @RequestParam("content") String content,
	        @RequestParam("category") String category) {

	    // 로그인 체크
	    Users loginUser = (Users) session.getAttribute("loginUser");
	    if (loginUser == null) {
	        mv.setViewName("redirect:loginPage.do");
	        return mv;
	    }

	    // 댓글 객체 생성
	    Comment comment = new Comment();
	    comment.setTargetId(boardId);
	    comment.setContent(content);
	    comment.setLoginId(loginUser.getLoginId());
	    comment.setTargetType("board"); // 대상이 게시판
	    comment.setParentId(null); // 일반 댓글

	    int result = boardService.insertBoardComment(comment);
	    if (result > 0) {
	        mv.setViewName("redirect:boardDetail.do?boardId=" + boardId + "&category=" + category);
	    } else {
	        mv.addObject("message", "댓글 등록에 실패하였습니다. 다시 시도해주세요.");
	        mv.setViewName("common/error");
	    }
	    return mv;
	}
	
	// 대댓글 작성 메소드
	@RequestMapping(value = "boardReplyInsert.do", method = RequestMethod.POST)
	public ModelAndView insertReply(ModelAndView mv, HttpSession session,
	        @RequestParam("boardId") int boardId,
	        @RequestParam("content") String content,
	        @RequestParam("parentId") int parentId, // 필수!
	        @RequestParam("category") String category) {

	    // 로그인 체크
	    Users loginUser = (Users) session.getAttribute("loginUser");
	    if (loginUser == null) {
	        mv.setViewName("redirect:loginPage.do");
	        return mv;
	    }

	    // 대댓글 객체 생성
	    Comment comment = new Comment();
	    comment.setTargetId(boardId);
	    comment.setContent(content);
	    comment.setLoginId(loginUser.getLoginId());
	    comment.setTargetType("board");
	    comment.setParentId(parentId); // 대댓글임을 명시

	    int result = boardService.insertBoardComment(comment);
	    if (result > 0) {
	        mv.setViewName("redirect:boardDetail.do?boardId=" + boardId + "&category=" + category);
	    } else {
	        mv.addObject("message", "답글 등록에 실패하였습니다. 다시 시도해주세요.");
	        mv.setViewName("common/error");
	    }
	    return mv;
	}

	

	// 댓글 수정용 메소드
	@RequestMapping(value = "boardCommentUpdate.do", method = RequestMethod.POST)
	public ModelAndView updateBoardCommentMethod(ModelAndView mv, HttpSession session,
			@RequestParam("commentId") int commentId,
			@RequestParam("content") String content,
			@RequestParam("boardId") int boardId,
			@RequestParam("category") String category) {

		Users loginUser = (Users) session.getAttribute("loginUser");
		if (loginUser == null) {
			mv.setViewName("redirect:loginPage.do");
			return mv;
		}

		Comment comment = new Comment();
		comment.setCommentId(commentId);
		comment.setContent(content);
		comment.setLoginId(loginUser.getLoginId()); // 로그인 사용자 확인 용도

		int result = boardService.updateBoardComment(comment);
		if (result > 0) {
			mv.setViewName("redirect:boardDetail.do?boardId=" + boardId + "&category=" + category);
		} else {
			mv.addObject("message", "댓글 수정에 실패하였습니다. 다시 시도해주세요.");
			mv.setViewName("common/error");
		}

		return mv;
	}
	
	// 댓글 삭제용 메소드
	@RequestMapping(value = "boardCommentDelete.do", method = RequestMethod.POST)
	public ModelAndView deleteBoardCommentMethod(ModelAndView mv, HttpSession session,
			@RequestParam("commentId") int commentId,
			@RequestParam("boardId") int boardId,
			@RequestParam("category") String category) {

		Users loginUser = (Users) session.getAttribute("loginUser");
		if (loginUser == null) {
			mv.setViewName("redirect:loginPage.do");
			return mv;
		}
		
		Map<String, Object> param = new HashMap<>();
		param.put("commentId", commentId);
		param.put("targetType", "board");

		int result = boardService.deleteBoardComment(param);
		if (result > 0) {
			mv.setViewName("redirect:boardDetail.do?boardId=" + boardId + "&category=" + category);
		} else {
			mv.addObject("message", "댓글 삭제에 실패하였습니다. 다시 시도해주세요.");
			mv.setViewName("common/error");
		}

		return mv;
	}
	
	// 검색용 메소드 ------------------------------------------------------------------
	// 전체 게시판 내용 검색 메소드
	@RequestMapping("boardSearchContentAll.do")
	public ModelAndView boardSearchContentAllMethod(ModelAndView mv, @RequestParam("action") String action,
			@RequestParam("keyword") String keyword, @RequestParam(name = "page", required = false) String page,
			@RequestParam(name = "limit", required = false) String slimit) {

		int currentPage = (page != null) ? Integer.parseInt(page) : 1;
		int limit = (slimit != null) ? Integer.parseInt(slimit) : 10;

		int listCount = boardService.selectSearchContentAllCount(keyword);

		Paging paging = new Paging(listCount, limit, currentPage, "boardSearchContentAll.do");
		paging.calculate();

		Search search = new Search();
		search.setKeyword(keyword);
		search.setStartRow(paging.getStartRow());
		search.setEndRow(paging.getEndRow());

		ArrayList<Board> list = boardService.selectSearchContentAll(search);

		if (list != null && !list.isEmpty()) {
			mv.addObject("list", list);
			mv.addObject("paging", paging);
			mv.addObject("action", action);
			mv.addObject("keyword", keyword);
			mv.setViewName("board/boardListView"); // 공통 뷰 사용
		} else {
			mv.addObject("message", "검색 결과가 존재하지 않습니다.");
			mv.setViewName("common/error");
		}

		return mv;
	}

	// 전체 게시판 제목 검색 메소드
	@RequestMapping("boardSearchTitleAll.do")
	public ModelAndView boardSearchTitleAllMethod(ModelAndView mv, @RequestParam("action") String action,
			@RequestParam("keyword") String keyword, @RequestParam(name = "page", required = false) String page,
			@RequestParam(name = "limit", required = false) String slimit) {

		int currentPage = (page != null) ? Integer.parseInt(page) : 1;
		int limit = (slimit != null) ? Integer.parseInt(slimit) : 10;

		int listCount = boardService.selectSearchTitleAllCount(keyword);

		Paging paging = new Paging(listCount, limit, currentPage, "boardSearchTitleAll.do");
		paging.calculate();

		Search search = new Search();
		search.setKeyword(keyword);
		search.setStartRow(paging.getStartRow());
		search.setEndRow(paging.getEndRow());

		ArrayList<Board> list = boardService.selectSearchTitleAll(search);

		if (list != null && !list.isEmpty()) {
			mv.addObject("list", list);
			mv.addObject("paging", paging);
			mv.addObject("action", action);
			mv.addObject("keyword", keyword);
			mv.setViewName("board/boardListView"); // 공통 뷰 사용
		} else {
			mv.addObject("message", "검색 결과가 존재하지 않습니다.");
			mv.setViewName("common/error");
		}

		return mv;
	}

	// 전체 게시판 작성자 검색 메소드
	@RequestMapping("boardSearchWriterAll.do")
	public ModelAndView boardSearchWriterAllMethod(ModelAndView mv, @RequestParam("action") String action,
			@RequestParam("keyword") String keyword, @RequestParam(name = "page", required = false) String page,
			@RequestParam(name = "limit", required = false) String slimit) {

		int currentPage = (page != null) ? Integer.parseInt(page) : 1;
		int limit = (slimit != null) ? Integer.parseInt(slimit) : 10;

		int listCount = boardService.selectSearchWriterAllCount(keyword);

		Paging paging = new Paging(listCount, limit, currentPage, "boardSearchWriterAll.do");
		paging.calculate();

		Search search = new Search();
		search.setKeyword(keyword);
		search.setStartRow(paging.getStartRow());
		search.setEndRow(paging.getEndRow());

		ArrayList<Board> list = boardService.selectSearchWriterAll(search);

		if (list != null && !list.isEmpty()) {
			mv.addObject("list", list);
			mv.addObject("paging", paging);
			mv.addObject("action", action);
			mv.addObject("keyword", keyword);
			mv.setViewName("board/boardListView"); // 공통 뷰 사용
		} else {
			mv.addObject("message", "검색 결과가 존재하지 않습니다.");
			mv.setViewName("common/error");
		}

		return mv;
	}

	// 게시판 유형에 따른 제목 검색 메소드
	@RequestMapping("boardSearchTitle.do")
	public ModelAndView boardSearchTitleMethod(ModelAndView mv, @RequestParam("action") String action,
			@RequestParam("keyword") String keyword, @RequestParam("category") String category,
			@RequestParam(name = "page", required = false) String page,
			@RequestParam(name = "limit", required = false) String slimit) {

		// 1. 페이지 설정
		int currentPage = 1;
		if (page != null) {
			currentPage = Integer.parseInt(page);
		}

		int limit = 10;
		if (slimit != null) {
			limit = Integer.parseInt(slimit);
		}

		// 2. 총 검색 결과 수 조회
		Search searchCount = new Search();
		searchCount.setKeyword(keyword);
		searchCount.setBoardCategory(category);

		int listCount = boardService.selectSearchTitleCount(searchCount);

		// 3. 페이징 객체 생성
		Paging paging = new Paging(listCount, limit, currentPage, "boardSearchTitle.do");
		paging.calculate();

		// 4. 실제 검색 조건 설정
		Search search = new Search();
		search.setKeyword(keyword);
		search.setBoardCategory(category);
		search.setStartRow(paging.getStartRow());
		search.setEndRow(paging.getEndRow());

		// 5. 검색 결과 조회
		ArrayList<Board> list = boardService.selectSearchTitle(search);

		if (list != null && list.size() > 0) {
			mv.addObject("list", list);
			mv.addObject("paging", paging);
			mv.addObject("action", action);
			mv.addObject("keyword", keyword);
			mv.addObject("category", category); // 카테고리 유지
			mv.setViewName("board/boardListView");
		} else {
			mv.addObject("message", action + "에 대한 " + keyword + " 검색 결과가 존재하지 않습니다.");
			mv.setViewName("common/error");
		}

		return mv;
	}

	// 게시판 유형에 따른 작성자 검색 메소드
	@RequestMapping("boardSearchWriter.do")
	public ModelAndView boardSearchWriterMethod(ModelAndView mv, @RequestParam("action") String action,
			@RequestParam("keyword") String keyword, @RequestParam("category") String category,
			@RequestParam(name = "page", required = false) String page,
			@RequestParam(name = "limit", required = false) String slimit) {

		// 1. 페이지 설정
		int currentPage = 1;
		if (page != null) {
			currentPage = Integer.parseInt(page);
		}

		int limit = 10;
		if (slimit != null) {
			limit = Integer.parseInt(slimit);
		}

		// 2. 총 검색 결과 수 조회
		Search searchCount = new Search();
		searchCount.setKeyword(keyword);
		searchCount.setBoardCategory(category);

		int listCount = boardService.selectSearchWriterCount(searchCount);

		// 3. 페이징 객체 생성
		Paging paging = new Paging(listCount, limit, currentPage, "boardSearchWriter.do");
		paging.calculate();

		// 4. 실제 검색 조건 설정
		Search search = new Search();
		search.setKeyword(keyword);
		search.setBoardCategory(category);
		search.setStartRow(paging.getStartRow());
		search.setEndRow(paging.getEndRow());

		// 5. 검색 결과 조회
		ArrayList<Board> list = boardService.selectSearchWriter(search);

		if (list != null && list.size() > 0) {
			mv.addObject("list", list);
			mv.addObject("paging", paging);
			mv.addObject("action", action);
			mv.addObject("keyword", keyword);
			mv.addObject("category", category); // 카테고리 유지
			mv.setViewName("board/boardListView");
		} else {
			mv.addObject("message", action + "에 대한 " + keyword + " 검색 결과가 존재하지 않습니다.");
			mv.setViewName("common/error");
		}

		return mv;
	}

	// 게시판 유형에 따른 내용 검색 메소드
	@RequestMapping("boardSearchContent.do")
	public ModelAndView boardSearchContentMethod(ModelAndView mv, @RequestParam("action") String action,
			@RequestParam("keyword") String keyword, @RequestParam("category") String category,
			@RequestParam(name = "page", required = false) String page,
			@RequestParam(name = "limit", required = false) String slimit) {

		// 1. 페이지 설정
		int currentPage = 1;
		if (page != null) {
			currentPage = Integer.parseInt(page);
		}

		int limit = 10;
		if (slimit != null) {
			limit = Integer.parseInt(slimit);
		}

		// 2. 총 검색 결과 수 조회
		Search searchCount = new Search();
		searchCount.setKeyword(keyword);
		searchCount.setBoardCategory(category);

		int listCount = boardService.selectSearchContentCount(searchCount);

		// 3. 페이징 객체 생성
		Paging paging = new Paging(listCount, limit, currentPage, "boardSearchContent.do");
		paging.calculate();

		// 4. 실제 검색 조건 설정
		Search search = new Search();
		search.setKeyword(keyword);
		search.setBoardCategory(category);
		search.setStartRow(paging.getStartRow());
		search.setEndRow(paging.getEndRow());

		// 5. 검색 결과 조회
		ArrayList<Board> list = boardService.selectSearchContent(search);

		if (list != null && list.size() > 0) {
			mv.addObject("list", list);
			mv.addObject("paging", paging);
			mv.addObject("action", action);
			mv.addObject("keyword", keyword);
			mv.addObject("category", category); // 카테고리 유지
			mv.setViewName("board/boardListView");
		} else {
			mv.addObject("message", action + "에 대한 " + keyword + " 검색 결과가 존재하지 않습니다.");
			mv.setViewName("common/error");
		}

		return mv;
	}
	
	// 게시글 신고 처리용 메소드
	@RequestMapping(value = "boardReportInsert.do", method = RequestMethod.POST)
	public ModelAndView insertBoardReport(ModelAndView mv, HttpSession session,
	                                      @RequestParam("targetId") int boardId,
	                                      @RequestParam("category") String category,
	                                      @RequestParam("reason") String reason) {

	    Users loginUser = (Users) session.getAttribute("loginUser");
	    if (loginUser == null) {
	        mv.setViewName("redirect:loginPage.do");
	        return mv;
	    }

	    ReportPost report = new ReportPost();
	    report.setBoardId(boardId);
	    report.setReason(reason);
	    report.setReporterId(loginUser.getLoginId());

	    int result = reportPostService.insertBoardReport(report);

	    if (result > 0) {
	    	mv.setViewName("redirect:boardDetail.do?boardId=" + boardId + "&category=" + category + "&reportSuccess=true");
	    } else {
	        mv.addObject("message", "신고 등록 실패! 다시 시도해주세요.");
	        mv.setViewName("common/error");
	    }

	    return mv;
	}
	
}
