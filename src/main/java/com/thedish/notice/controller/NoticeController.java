package com.thedish.notice.controller;

import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.thedish.board.model.vo.Board;
import com.thedish.common.Paging;
import com.thedish.common.Search;
import com.thedish.notice.model.service.NoticeService;
import com.thedish.notice.model.vo.Notice;

@Controller
public class NoticeController {
	// 이 클래스 안의 메소드들이 잘 동작하는지, 매개변수 또는 리턴값을 확인하는 용도로 로그 객체 생성
	private static final Logger logger = LoggerFactory.getLogger(NoticeController.class);
	
	@Autowired
	private NoticeService noticeService;
	
	// 공지사항 전체 목록보기 요청 처리용
	@RequestMapping("noticeList.do")
	public ModelAndView noticeListMethod(ModelAndView mv, @RequestParam(name = "page", required = false) String page,
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
		int listCount = noticeService.selectListCount();
		// 페이지 관련 항목들 계산 처리
		Paging paging = new Paging(listCount, limit, currentPage, "noticeList.do");
		paging.calculate();
		
		// 서비스 모델로 페이징 적용된 목록 조회 요청하고 결과받기
		ArrayList<Notice> list = noticeService.selectList(paging);
		
		if (list != null && list.size() > 0) {
			mv.addObject("list", list);
			mv.addObject("paging", paging);
			
			mv.setViewName("notice/noticeListView");
		} else {
			mv.addObject("message", currentPage + "페이지에 출력할 공지글 목록 조회 실패!");
			mv.setViewName("common/error");
		}
		
		return mv;
	}
	
	@RequestMapping("ndetail.do")
	public ModelAndView noticeDetailMethod(
	    ModelAndView mv,
	    @RequestParam("no") int noticeId) {
	    
	    logger.info("ndetail.do : " + noticeId); // 전송값 확인

	    // 공지 조회
	    Notice notice = noticeService.selectNotice(noticeId);

	    // 조회수 1 증가
	    noticeService.updateAddReadCount(noticeId);

	    if (notice != null) {
	        mv.addObject("notice", notice);
	        mv.setViewName("notice/noticeDetailView");  // ✅ 모든 사용자 공통 뷰로 이동
	    } else {
	        mv.addObject("message", noticeId + "번 공지글 상세보기 요청 실패! 관리자에게 문의하세요.");
	        mv.setViewName("common/error");
	    }

	    return mv;
	}
		//검색용 메소드 -----------------------------------------------------
	
	@RequestMapping("noticeSearchTitle.do")
	public ModelAndView noticeSearchTitleMethod(
	        ModelAndView mv,
	        @RequestParam("action") String action,
	        @RequestParam("keyword") String keyword,
	        @RequestParam(name = "page", required = false) String page,
	        @RequestParam(name = "limit", required = false) String slimit) {

	    int currentPage = (page != null) ? Integer.parseInt(page) : 1;
	    int limit = (slimit != null) ? Integer.parseInt(slimit) : 10;

	    int listCount = noticeService.selectSearchTitleCount(keyword);

	    Paging paging = new Paging(listCount, limit, currentPage, "noticeSearchTitle.do");
	    paging.calculate();

	    Search search = new Search();
	    search.setKeyword(keyword);
	    search.setStartRow(paging.getStartRow());
	    search.setEndRow(paging.getEndRow());

	    ArrayList<Notice> list = noticeService.selectSearchTitle(search);

	    if (list != null && !list.isEmpty()) {
	        mv.addObject("list", list);
	        mv.addObject("paging", paging);
	        mv.addObject("action", action);
	        mv.addObject("keyword", keyword);
	        mv.setViewName("notice/noticeListView"); // 공통 뷰 사용
	    } else {
	        mv.addObject("message", "검색 결과가 존재하지 않습니다.");
	        mv.setViewName("common/error");
	    }

	    return mv;
	}
	
	@RequestMapping("noticeSearchContent.do")
	public ModelAndView noticeSearchContentMethod(
	        ModelAndView mv,
	        @RequestParam("action") String action,
	        @RequestParam("keyword") String keyword,
	        @RequestParam(name = "page", required = false) String page,
	        @RequestParam(name = "limit", required = false) String slimit) {

	    int currentPage = (page != null) ? Integer.parseInt(page) : 1;
	    int limit = (slimit != null) ? Integer.parseInt(slimit) : 10;

	    int listCount = noticeService.selectSearchContentCount(keyword);

	    Paging paging = new Paging(listCount, limit, currentPage, "noticeSearchContent.do");
	    paging.calculate();

	    Search search = new Search();
	    search.setKeyword(keyword);
	    search.setStartRow(paging.getStartRow());
	    search.setEndRow(paging.getEndRow());

	    ArrayList<Notice> list = noticeService.selectSearchContent(search);

	    if (list != null && !list.isEmpty()) {
	        mv.addObject("list", list);
	        mv.addObject("paging", paging);
	        mv.addObject("action", action);
	        mv.addObject("keyword", keyword);
	        mv.setViewName("notice/noticeListView"); // 공통 뷰 사용
	    } else {
	        mv.addObject("message", "검색 결과가 존재하지 않습니다.");
	        mv.setViewName("common/error");
	    }

	    return mv;
	}
	
	}

	
	
	










