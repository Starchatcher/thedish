package com.thedish.notice.controller;

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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.thedish.common.FileNameChange;
import com.thedish.common.Paging;
import com.thedish.common.Search;
import com.thedish.notice.model.service.NoticeService;
import com.thedish.notice.model.vo.Notice;
import com.thedish.users.model.vo.Users;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class NoticeController {
	// 이 클래스 안의 메소드들이 잘 동작하는지, 매개변수 또는 리턴값을 확인하는 용도로 로그 객체 생성
	private static final Logger logger = LoggerFactory.getLogger(NoticeController.class);
	
	@Autowired
	private NoticeService noticeService;
	
	// 새 공지글 등록 페이지로 이동 처리용
		@RequestMapping("moveWrite.do")
		public String moveWritePage() {
			return "notice/noticeWriteView";
		}
		
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
	
	//공지글 상세보기 요청 처리용
		@RequestMapping("ndetail.do")
		public ModelAndView noticeDetailMethod(
				@RequestParam("no") int noticeId, 
				ModelAndView mv,
				HttpSession session) {
			//관리자 상세보기 페이지와 일반회원 상세보기 페이지를 구분해서 응답 처리함
			//관리자인지 확인하기 위해 session 매개변수가 추가됨
			
			logger.info("ndetail.do : " + noticeId); //전송받은 값 확인
			
			Notice notice = noticeService.selectNotice(noticeId);
			
			//조회수 1증가 처리
			noticeService.updateAddReadCount(noticeId);
			
			if(notice != null) {
				mv.addObject("notice", notice);
				
				Users loginUser = (Users)session.getAttribute("loginUser");
				if(loginUser != null && loginUser.getRole().equals("ADMIN")) {
					mv.setViewName("notice/noticeAdminView");
				} else {
					mv.setViewName("notice/noticeDetailView");
				}
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
	    	 mv.addObject("list", list);
		        mv.addObject("paging", paging);
		        mv.addObject("action", action);
		        mv.addObject("keyword", keyword);
		        mv.setViewName("notice/noticeListView");
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
	    	mv.addObject("list", list);
	        mv.addObject("paging", paging);
	        mv.addObject("action", action);
	        mv.addObject("keyword", keyword);
	        mv.setViewName("notice/noticeListView"); // 공통 뷰 사용
	    }

	    return mv;
	   
	}

@RequestMapping(value = "ntop10.do", produces = "application/json; charset=UTF-8")
@ResponseBody
	public ArrayList<Notice> getTop10Notices() {
	    return noticeService.selectTop10();
	}
	
	//메인페이지 목록 출력
	@RequestMapping("mainWithNotice.do")
	public String showMainPage(Model model) {
	    ArrayList<Notice> topNotices = noticeService.selectTop10();
	    model.addAttribute("topNotices", topNotices);
	    return "main"; // 메인 페이지 JSP 파일
	}
	
	// 공지글 수정페이지로 이동 처리용
		@RequestMapping("nmoveup.do")
		public ModelAndView moveUpdatePage(@RequestParam("no") int noticeId, ModelAndView mv) {
			//수정페이지로 수정할 공지글도 함께 내보내기 위해, 전송받은 공지번호에 대한 공지글 조회해 옴
			Notice notice = noticeService.selectNotice(noticeId);
			
			if(notice != null) {
				mv.addObject("notice", notice);
				mv.setViewName("notice/noticeUpdateView");
			} else {
				mv.addObject("message", noticeId + "번 공지글 수정페이지로 이동 실패!");
				mv.setViewName("common/error");
			}
			
			return mv;
		}
	
		// 첨부파일 다운로드 요청 처리용 메소드
		// 스프링에서는 파일 다운로드는 스프링이 제공하는 View 클래스를 상속받은 클래스를 사용하도록 정해 놓았음
		// => 공통모듈로 파일다운로드용 뷰 클래스를 따로 만듦 => 뷰리졸버에서 연결 처리함
		// => 리턴타입은 반드시 ModelAndView 여야 함
		@RequestMapping("nfdown.do")
		public ModelAndView fileDownMethod(
				ModelAndView mv,
				HttpServletRequest request,
				@RequestParam("ofile") String originalFileName,
				@RequestParam("rfile") String renameFileName) {
			
			// 공지사항 첨부파일 저장 폴더 경로 지정
			String savePath = request.getSession().getServletContext().getRealPath("resources/notice_upfiles");
			// 저장 폴더에서 읽을 파일에 대한 File 객체 생성
			File downFile = new File(savePath + "\\" + renameFileName);
			// 파일 다운시 브라우저로 내보낼 원래 파일에 대한 File 객체 생성
			File originFile = new File(originalFileName);
			
			// 파일 다운 처리용 뷰클래스 id명과 다운로드할 File 객체를 ModelAndView 에 담아서 리턴함
			mv.setViewName("filedown");  //뷰클래스의 id명 기입
			mv.addObject("originFile", originFile);
			mv.addObject("renameFile", downFile);
			
			return mv;
		}
	
		// dml ****************************************************
		
		// 새 공지글 등록 요청 처리용 (파일 업로드 기능 포함)
		@RequestMapping(value="ninsert.do", method=RequestMethod.POST)
		public String noticeInsertMethod(
				Notice notice, 
				@RequestParam(name="ofile", required=false) MultipartFile mfile,
				HttpServletRequest request,
				Model model) {
			logger.info("ninsert.do : " + notice);
			
			//공지사항 첨부파일 저장 폴더를 경로 저장
			String savePath = request.getSession().getServletContext().getRealPath("resources/notice_upfiles");
			
			//첨부파일이 있을 때
			if(!mfile.isEmpty()) {
				// 전송온 파일이름 추출함
				String fileName = mfile.getOriginalFilename();
				String renameFileName = null;
				
				//저장 폴더에는 변경된 파일이름을 파일을 저장 처리함
				//바꿀 파일명 : 년월일시분초.확장자
				if(fileName != null && fileName.length() > 0) {
					renameFileName = FileNameChange.change(fileName, "yyyyMMddHHmmss");
					logger.info("변경된 첨부 파일명 확인 : " + renameFileName);
					
					try {
						//저장 폴더에 바뀐 파일명으로 파일 저장하기
						mfile.transferTo(new File(savePath + "\\" + renameFileName));
					} catch (Exception e) {					
						e.printStackTrace();
						model.addAttribute("message", "첨부파일 저장 실패!");
						return "common/error";
					} 
				} //파일명 바꾸어 저장하기
				
				//notice 객체에 첨부파일 정보 저장하기
				notice.setOriginalFileName(fileName);
				notice.setRenameFileName(renameFileName);
			} //첨부파일 있을 때
			
			if(noticeService.insertNotice(notice) > 0) {
				//새 공지글 등록 성공시, 공지 목록 페이지로 이동 처리
				return "redirect:noticeList.do";
			} else {
				model.addAttribute("message", "새 공지글 등록 실패!");
				return "common/error";
			}
			
		}  // ninsert.do closed
		
		// 공지글 삭제 요청 처리용
		@RequestMapping("ndelete.do")
		public String noticeDeleteMethod(
				Model model,
				@RequestParam("no") int noticeId,
				@RequestParam(name="rfile", required=false) String renameFileName,
				HttpServletRequest request) {
			if(noticeService.deleteNotice(noticeId) > 0) {  // 공지글 삭제 성공시
				//공지글 삭제 성공시 저장 폴더에 있는 첨부파일도 삭제 처리함
				if(renameFileName != null && renameFileName.length() > 0) {
					// 공지사항 첨부파일 저장 폴더 경로 지정
					String savePath = request.getSession().getServletContext().getRealPath("resources/notice_upfiles");
					// 저장 폴더에서 파일 삭제함
					new File(savePath + "\\" + renameFileName).delete();
				}
				
				return "redirect:noticeList.do";
			} else {  // 공지글 삭제 실패시
				model.addAttribute("message", noticeId + "번 공지글 삭제 실패!");
				return "common/error";
			}
		}
		
		// 공지글 수정 요청 처리용 (파일 업로드 기능 포함)
		@RequestMapping(value="nupdate.do", method=RequestMethod.POST)
		public String noticeUpdateMethod(
		        Notice notice,
		        Model model,
		        HttpServletRequest request,
		        @RequestParam(name="deleteFlag", required=false) String delFlag,
		        @RequestParam(name="ofile", required=false) MultipartFile mfile,
		        HttpSession session) {  // ✅ 세션 받아오기

		    logger.info("nupdate.do : " + notice);

		    // ✅ 작성자 정보가 빠지는 문제 방지
		    com.thedish.users.model.vo.Users loginUser =
		            (com.thedish.users.model.vo.Users) session.getAttribute("loginUser");
		    if (loginUser != null) {
		        notice.setCreatedBy(loginUser.getLoginId());  // 또는 getUserName()
		    }

		    // 첨부파일 저장 경로
		    String savePath = request.getSession().getServletContext().getRealPath("resources/notice_upfiles");

		    // 1. 삭제 체크 or 새 첨부파일 업로드 시 이전 파일 제거
		    if (notice.getOriginalFileName() != null &&
		        ((delFlag != null && delFlag.equals("yes")) || (!mfile.isEmpty()))) {
		        new File(savePath + "\\" + notice.getRenameFileName()).delete();
		        notice.setOriginalFileName(null);
		        notice.setRenameFileName(null);
		    }

		    // 2. 새 파일이 첨부되었을 경우
		    if (!mfile.isEmpty()) {
		        String fileName = mfile.getOriginalFilename();
		        String renameFileName = null;

		        if (fileName != null && fileName.length() > 0) {
		            renameFileName = FileNameChange.change(fileName, "yyyyMMddHHmmss");
		            logger.info("변경된 첨부 파일명 확인 : " + renameFileName);

		            try {
		                mfile.transferTo(new File(savePath + "\\" + renameFileName));
		            } catch (Exception e) {
		                e.printStackTrace();
		                model.addAttribute("message", "첨부파일 저장 실패!");
		                return "common/error";
		            }
		        }

		        notice.setOriginalFileName(fileName);
		        notice.setRenameFileName(renameFileName);
		    }

		    // 3. DB 업데이트 처리
		    if (noticeService.updateNotice(notice) > 0) {
		        return "redirect:ndetail.do?no=" + notice.getNoticeId();
		    } else {
		        model.addAttribute("message", notice.getNoticeId() + "번 공지글 수정 실패!");
		        return "common/error";
		    }
		}
		
		
}

	
	
	










