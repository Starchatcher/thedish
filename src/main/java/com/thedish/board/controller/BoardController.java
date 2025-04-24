package com.thedish.board.controller;

import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.thedish.board.model.vo.Board;
import com.thedish.board.service.BoardService;
import com.thedish.common.Paging;

@Controller
public class BoardController {
	// 로그 객체 생성
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);

	@Autowired
	private BoardService boardService;

	// 뷰 페이지 내보내기용 메소드 ---------------------------------------

	// 요청 처리용 메소드 -----------------------------------------------
	// 게시글 전체 목록보기 요청 처리용 (페이징 처리 : 한 페이지에 10개씩 출력 처리)
	@RequestMapping("boardList.do")
	public ModelAndView selectListBoard(ModelAndView mv, @RequestParam(name = "page", required = false) String page,
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
		int listCount = boardService.selectListCount();
		// 페이지 관련 항목들 계산 처리
		Paging paging = new Paging(listCount, limit, currentPage, "boardList.do");
		paging.calculate();
		
		// 서비스 모델로 페이징 적용된 목록 조회 요청하고 결과받기
		ArrayList<Board> list = boardService.selectList(paging);
		
		if(list != null && list.size() > 0) {
			mv.addObject("list", list);
			mv.addObject("paging", paging);
			mv.setViewName("board/boardListView");
		} else {
			mv.addObject("message", currentPage + "게시글 목록 조회에 실패하였습니다.");
			mv.setViewName("common/error");
		}
		
		return mv;
	}

}

































