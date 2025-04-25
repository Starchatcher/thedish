package com.thedish.board.controller;



import java.io.File;
import java.util.ArrayList;

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
import com.thedish.common.Paging;

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
	public ModelAndView selectListBoard(ModelAndView mv, 
			@RequestParam(name = "page", required = false) String page,
			@RequestParam(name = "limit", required = false) String slimit) {
		// 페이징 처리
		int currentPage = 1;
		if (page != null) {
			currentPage = Integer.parseInt(page);
		}

		// 한 페이지에 출력할 목록 갯수 기본 10개로 지정함
		int limit = 10;
		if (slimit != null) {
			limit = Integer.parseInt(slimit);
		}

		// 총 목록 갯수 조회해서, 총 페이지 수 계산함
		int listCount = boardService.selectBoardListCount();
		// 페이지 관련 항목들 계산 처리
		Paging paging = new Paging(listCount, limit, currentPage, "boardList.do");
		paging.calculate();

		// 서비스 모델로 페이징 적용된 목록 조회 요청하고 결과받기
		ArrayList<Board> list = boardService.selectBoardList(paging);

		if (list != null && list.size() > 0) {
			mv.addObject("list", list);
			mv.addObject("paging", paging);
			mv.setViewName("board/boardListView");
		} else {
			mv.addObject("message", currentPage + "게시글 목록 조회에 실패하였습니다.");
			mv.setViewName("common/error");
		}

		return mv;
	}

	// 자유게시판 전체 목록보기 요청 처리용 (페이징 처리 : 한 페이지에 10개씩 출력 처리)
	@RequestMapping("freeBoardList.do")
	public ModelAndView selectListFreeBoard(ModelAndView mv, 
			@RequestParam(name = "page", required = false) String page,
			@RequestParam(name = "limit", required = false) String slimit) {
		// 페이징 처리
		int currentPage = 1;
		if (page != null) {
			currentPage = Integer.parseInt(page);
		}

		// 한 페이지에 출력할 목록 갯수 기본 10개로 지정함
		int limit = 10;
		if (slimit != null) {
			limit = Integer.parseInt(slimit);
		}

		// 총 목록 갯수 조회해서, 총 페이지 수 계산함
		int listCount = boardService.selectFreeBoardListCount();
		// 페이지 관련 항목들 계산 처리
		Paging paging = new Paging(listCount, limit, currentPage, "freeBoardList.do");
		paging.calculate();

		// 서비스 모델로 페이징 적용된 목록 조회 요청하고 결과받기
		ArrayList<Board> list = boardService.selectFreeBoardList(paging);

		if (list != null && list.size() > 0) {
			mv.addObject("list", list);
			mv.addObject("paging", paging);
			mv.setViewName("board/freeBoardListView");
		} else {
			mv.addObject("message", currentPage + "게시글 목록 조회에 실패하였습니다.");
			mv.setViewName("common/error");
		}

		return mv;
	}

	// 후기게시판 전체 목록보기 요청 처리용 (페이징 처리 : 한 페이지에 10개씩 출력 처리)
	@RequestMapping("reviewBoardList.do")
	public ModelAndView selectListReviewBoard(ModelAndView mv,
			@RequestParam(name = "page", required = false) String page,
			@RequestParam(name = "limit", required = false) String slimit) {
		// 페이징 처리
		int currentPage = 1;
		if (page != null) {
			currentPage = Integer.parseInt(page);
		}

		// 한 페이지에 출력할 목록 갯수 기본 10개로 지정함
		int limit = 10;
		if (slimit != null) {
			limit = Integer.parseInt(slimit);
		}

		// 총 목록 갯수 조회해서, 총 페이지 수 계산함
		int listCount = boardService.selectReviewBoardListCount();
		// 페이지 관련 항목들 계산 처리
		Paging paging = new Paging(listCount, limit, currentPage, "reviewBoardList.do");
		paging.calculate();

		// 서비스 모델로 페이징 적용된 목록 조회 요청하고 결과받기
		ArrayList<Board> list = boardService.selectReviewBoardList(paging);

		if (list != null && list.size() > 0) {
			mv.addObject("list", list);
			mv.addObject("paging", paging);
			mv.setViewName("board/reviewBoardListView");
		} else {
			mv.addObject("message", currentPage + "게시글 목록 조회에 실패하였습니다.");
			mv.setViewName("common/error");
		}

		return mv;
	}

	// 팁 공유게시판 전체 목록보기 요청 처리용 (페이징 처리 : 한 페이지에 10개씩 출력 처리)
	@RequestMapping("tipBoardList.do")
	public ModelAndView selectListTipBoard(ModelAndView mv, 
			@RequestParam(name = "page", required = false) String page,
			@RequestParam(name = "limit", required = false) String slimit) {
		// 페이징 처리
		int currentPage = 1;
		if (page != null) {
			currentPage = Integer.parseInt(page);
		}

		// 한 페이지에 출력할 목록 갯수 기본 10개로 지정함
		int limit = 10;
		if (slimit != null) {
			limit = Integer.parseInt(slimit);
		}

		// 총 목록 갯수 조회해서, 총 페이지 수 계산함
		int listCount = boardService.selectTipBoardListCount();
		// 페이지 관련 항목들 계산 처리
		Paging paging = new Paging(listCount, limit, currentPage, "tipBoardList.do");
		paging.calculate();

		// 서비스 모델로 페이징 적용된 목록 조회 요청하고 결과받기
		ArrayList<Board> list = boardService.selectTipBoardList(paging);

		if (list != null && list.size() > 0) {
			mv.addObject("list", list);
			mv.addObject("paging", paging);
			mv.setViewName("board/tipBoardListView");
		} else {
			mv.addObject("message", currentPage + "게시글 목록 조회에 실패하였습니다.");
			mv.setViewName("common/error");
		}

		return mv;
	}

	@RequestMapping("boardDetail.do")
	public ModelAndView boardDetailView(
			@RequestParam("bno") int boardId,
			@RequestParam(name = "page", required = false) String page, 
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
			mv.setViewName("board/boardDetailView");
		} else {
			mv.addObject("message", boardId + "번 게시글 상세보기 요청 실패!");
			mv.setViewName("common/error");
		}

		return mv;
	}
	
	// 새 게시글 원글 등록 요청 처리용 (파일 업로드 기능 포함)
	@RequestMapping(value = "boardInsert.do", method = RequestMethod.POST)
	public String boardInsertMethod(Board board, @RequestParam(name = "ofile", required = false) MultipartFile mfile,
			HttpServletRequest request, Model model) {
//		// 게시 원글 첨부파일 저장 폴더를 경로 저장
//		String savePath = request.getSession().getServletContext().getRealPath("resources/board_upfiles");
//
//		// 첨부파일이 있을 때
//		if (!mfile.isEmpty()) {
//			// 전송온 파일이름 추출함
//			String fileName = mfile.getOriginalFilename();
//			String renameFileName = null;
//
//			// 저장 폴더에는 변경된 파일이름으로 파일을 저장 처리함
//			// 바꿀 파일명 : 년월일시분초.확장자
//			if (fileName != null && fileName.length() > 0) {
//				renameFileName = FileNameChange.change(fileName, "yyyyMMddHHmmss");
//				logger.info("변경된 첨부 파일명 확인 : " + renameFileName);
//
//				try {
//					// 저장 폴더에 바뀐 파일명으로 파일 저장하기
//					mfile.transferTo(new File(savePath + "\\" + renameFileName));
//				} catch (Exception e) {
//					e.printStackTrace();
//					model.addAttribute("message", "첨부파일 저장 실패!");
//					return "common/error";
//				}
//			} // 파일명 바꾸어 저장하기
//
//			// board 객체에 첨부파일 정보 저장하기
//			board.setBoardOriginalFileName(fileName);
//			board.setBoardRenameFileName(renameFileName);
//		} // 첨부파일 있을 때

		if (boardService.insertBoard(board) > 0) {
			// 새 게시 원글 등록 성공시, 공지 목록 페이지로 이동 처리
			return "redirect:boardList.do";
		} else {
			model.addAttribute("message", "새 게시글 등록 실패!");
			return "common/error";
		}

	} // binsert.do closed
	

}
