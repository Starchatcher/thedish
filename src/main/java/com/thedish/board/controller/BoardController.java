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
import com.thedish.common.FileNameChange;
import com.thedish.common.Paging;
import com.thedish.common.Search;
import com.thedish.users.model.vo.Users;

import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.HttpServletRequest;

@Controller
public class BoardController {
	// 로그 객체 생성
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);

	@Autowired
	private BoardService boardService;

	// 뷰 페이지 내보내기용 메소드 ---------------------------------------

	// 게시글 작성 페이지 내보내기
	@RequestMapping("boardWritePage.do")
	public String moveWritePage() {
		return "board/boardWriteView";
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

		mv.addObject("list", list);
		mv.addObject("paging", paging);
		mv.addObject("category", category);
		mv.setViewName("board/boardListView");
		return mv;
	}

	@RequestMapping("boardDetail.do")
	public ModelAndView boardDetailView(@RequestParam("bno") int boardId,
			@RequestParam(name = "page", required = false) String page, @RequestParam("category") String category,
			ModelAndView mv) {

		logger.info("boardDetail.do : " + boardId);

		int currentPage = 1; // 상세보기 페이지에서 목록 버튼 누르면, 보고있던 목록 페이지로 돌아가기 위해 저장함
		if (page != null) {
			currentPage = Integer.parseInt(page);
		}

		Board board = boardService.selectBoard(boardId);

		// 조회수 1증가 처리
		boardService.updateViewCount(boardId);

		if (board != null) {
			mv.addObject("board", board);
			mv.addObject("currentPage", currentPage);
			mv.addObject("category", category);
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
			Model model) {

		// ✅ 로그인 유저 세션에서 가져와 작성자 세팅
		Users loginUser = (Users) session.getAttribute("loginUser");
		if (loginUser == null) {
			model.addAttribute("message", "로그인이 필요합니다.");
			return "common/error";
		}
		board.setWriter(loginUser.getLoginId()); // ← writer를 여기서 세팅
		board.setBoardCategory(category);

		// 파일 저장 로직은 그대로 유지
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
					model.addAttribute("message", "첨부파일 저장 실패!");
					return "common/error";
				}
			}
		}

		if (boardService.insertBoard(board) > 0) {
			return "redirect:boardList.do";
		} else {
			model.addAttribute("message", "새 게시글 등록 실패!");
			return "common/error";
		}
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

}
