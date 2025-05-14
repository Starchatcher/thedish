package com.thedish.qna.controller;

import java.io.File;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.thedish.common.FileNameChange;
import com.thedish.common.Paging;
import com.thedish.qna.model.service.QnaService;
import com.thedish.qna.model.vo.Qna;
import com.thedish.users.model.service.UsersService;
import com.thedish.users.model.vo.Users;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class QnaController {
	
	@Autowired
	private QnaService qnaService;
	
	@Autowired
	private UsersService usersService;
	
	// qna 작성 폼 내보내기용 메소드
	@RequestMapping("qnaWriteForm.do")
	public ModelAndView moveQnaWritePage(ModelAndView mv, HttpSession session) {
		Users loginUser = (Users) session.getAttribute("loginUser");
		
		if(loginUser == null) {
			mv.setViewName("loginPage.do");
			return mv;
		}
		
		mv.setViewName("qna/qnaWriteForm");
		return mv;
	}
	
	// qna 수정 폼 내보내기용 메소드
	@RequestMapping("qnaUpdateForm.do")
	public ModelAndView moveQnaUpdatePage(ModelAndView mv,
			@RequestParam("qnaId") int qnaId) {
		Qna qna = qnaService.selectQnaById(qnaId);
		
		if(qna != null) {
			mv.addObject("qnaId", qnaId);
			mv.addObject("qna",	qna);
			mv.setViewName("qna/qnaUpdateView");
		} else {
			mv.setViewName("common/error");
		}
		return mv;
	}
	
	// 모든 문의 목록 출력 처리용 메소드
	@RequestMapping("qnaList.do")
	public ModelAndView qnaListMethod(ModelAndView mv,
	        @RequestParam(name = "page", required = false) String page,
	        @RequestParam(name = "limit", required = false) String slimit,
	        HttpSession session) {

	    // 로그인 유저 확인
	    Users loginUser = (Users) session.getAttribute("loginUser");
	    if (loginUser == null) {
	        mv.setViewName("redirect:loginPage.do");
	        return mv;
	    }

	    // 현재 페이지와 limit 기본값 처리
	    int currentPage = (page != null) ? Integer.parseInt(page) : 1;
	    int limit = (slimit != null) ? Integer.parseInt(slimit) : 10;

	    // 총 목록 개수 조회
	    int listCount = "ADMIN".equals(loginUser.getRole())
	        ? qnaService.getListCount(null)  // 관리자: 전체
	        : qnaService.getListCount(loginUser.getLoginId()); // 유저: 본인만

	    // 페이징 계산
	    Paging paging = new Paging(listCount, limit, currentPage, "qnaList.do");
	    paging.calculate();

	    // 페이징된 목록 조회
	    List<Qna> qnaList = "ADMIN".equals(loginUser.getRole())
	        ? qnaService.selectList(paging, null)
	        : qnaService.selectList(paging, loginUser.getLoginId());

	    // 결과 전달
	    mv.addObject("qnaList", qnaList);
	    mv.addObject("paging", paging);
	    mv.setViewName("qna/qnaListView");

	    return mv;
	}
	
	// 파일 다운로드 메소드
	@RequestMapping("qnaFileDown.do")
	public ModelAndView fileDownMethod(ModelAndView mv, HttpServletRequest request,
			@RequestParam("ofile") String originalFileName, @RequestParam("rfile") String renameFileName) {

		// 게시글 첨부파일 저장 폴더 경로 지정
		String savePath = request.getSession().getServletContext().getRealPath("resources/qna_upfiles");
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
	
	// 문의 등록 메소드 (파일 업로드 기능 포함)
	@RequestMapping(value="qnaInsert.do", method=RequestMethod.POST)
	public ModelAndView qnaInsertMethod(ModelAndView mv, Qna qna,
			@RequestParam(name="ofile", required=false) MultipartFile mfile,
			HttpServletRequest request, HttpSession session) {
		
		Users loginUser = (Users) session.getAttribute("loginUser");
		
		qna.setUserId(loginUser.getLoginId());
		qna.setCreatedAt(new java.sql.Date(System.currentTimeMillis()));
		
		
		String savePath = request.getSession().getServletContext().getRealPath("resources/qna_upfiles");
		if (!mfile.isEmpty()) {
			String fileName = mfile.getOriginalFilename();
			if (fileName != null && fileName.length() > 0) {
				String renameFileName = FileNameChange.change(fileName, "yyyyMMddHHmmss");
				try {
					File saveDir = new File(savePath);
					if (!saveDir.exists())
						saveDir.mkdirs();
					mfile.transferTo(new File(savePath + "\\" + renameFileName));
					qna.setOriginalFileName(fileName);
					qna.setRenameFileName(renameFileName);
				} catch (Exception e) {
					e.printStackTrace();
					mv.setViewName("common/error");
					mv.addObject("message", "첨부파일 저장 실패!");
					return mv;
				}
			}
		}
		
		if(qnaService.insertQna(qna) > 0) {
			mv.setViewName("redirect:qnaList.do");
		}else {
			mv.addObject("message", "문의 등록 실패. 다시 시도해주세요.");
			mv.setViewName("common/error");
		}
		
		return mv;
	}
	
	@RequestMapping(value = "qnaUpdate.do", method = RequestMethod.POST)
	public ModelAndView qnaUpdateMethod(ModelAndView mv, Qna qna, HttpServletRequest request,
			@RequestParam(name = "deleteFile", required = false) String delFlag,
			@RequestParam(name = "ofile", required = false) MultipartFile mfile) {

		// 첨부파일 관련 변경 사항 처리
		String savePath = request.getSession().getServletContext().getRealPath("resources/qna_upfiles");

		// 1. 원래 첨부파일이 있는데 파일삭제를 원할 경우
		// OR 원래 첨부파일이 있는데 새로운 첨부파일로 변경할 경우
		// => 이전 파일 정보 삭제
		if (qna.getOriginalFileName() != null && ("yes".equals(delFlag) || !mfile.isEmpty())) {
			new File(savePath + "\\" + qna.getRenameFileName()).delete();
			qna.setOriginalFileName(null);
			qna.setRenameFileName(null);
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

			qna.setOriginalFileName(fileName);
			qna.setRenameFileName(renameFileName);
		}

		if (qnaService.updateQna(qna) > 0) {
			mv.addObject("qnaId", qna.getQnaId());
			mv.setViewName("redirect:qnaDetail.do?qnaId=" + qna.getQnaId());
		} else {
			mv.addObject("message", "게시글 수정에 실패하였습니다. 다시 시도해주세요.");
			mv.setViewName("common/error");
		}

		return mv;
	}
	
	@RequestMapping("qnaDetail.do")
	public ModelAndView qnaDetailView(ModelAndView mv,
	        @RequestParam("qnaId") int qnaId) {

	    Qna qna = qnaService.selectQnaById(qnaId);
	    
	    // ✨ 작성자 정보 따로 가져오기
	    Users writer = usersService.selectUserByLoginId(qna.getUserId());

	    mv.addObject("qna", qna);
	    mv.addObject("writer", writer); // ✅ 이거 반드시 있어야 함
	    mv.setViewName("qna/qnaDetailView");

	    return mv;
	}
	
	// 문의 삭제
	@RequestMapping("qnaDelete.do")
	public ModelAndView qnaDeleteMethod(ModelAndView mv,
			HttpServletRequest request,
			@RequestParam("qnaId") int qnaId) {
		
		
		Qna qna = qnaService.selectQnaById(qnaId);
		
		if(qnaService.deleteQna(qnaId) > 0) {
			if(qna.getOriginalFileName() != null && qna.getRenameFileName().length() > 0) {
				String savePath = request.getSession().getServletContext().getRealPath("resources/qna_upfiles");
				new File(savePath + "\\" + qna.getRenameFileName()).delete();
			}
			
			mv.setViewName("redirect:qnaList.do");
		}else {
			mv.addObject("message", "문의글 삭제에 실패하였습니다. 다시 시도해주세요.");
			mv.setViewName("common/error");

		}
		
		return mv;
	}
	
	//관리자 기능 추가 (답변 달기) 
	@RequestMapping(value = "qnaAnswer.do", method = RequestMethod.POST)
	public ModelAndView qnaAnswerMethod(ModelAndView mv,
	        @RequestParam("qnaId") int qnaId,
	        @RequestParam("answer") String answer,
	        HttpSession session) {

	    Users loginUser = (Users) session.getAttribute("loginUser");

	    if (loginUser == null || !"ADMIN".equals(loginUser.getRole())) {
	        mv.setViewName("common/error");
	        mv.addObject("message", "관리자만 답변할 수 있습니다.");
	        return mv;
	    }

	    Qna qna = new Qna();
	    qna.setAnsweredAt(new java.sql.Date(System.currentTimeMillis()));
	    qna.setQnaId(qnaId);
	    qna.setAnswer(answer);
	    qna.setCreatedBy(loginUser.getLoginId());

	    int result = qnaService.answerQna(qna);; // service → dao → mapper 호출

	    if (result > 0) {
	        mv.setViewName("redirect:qnaDetail.do?qnaId=" + qnaId);
	    } else {
	        mv.addObject("message", "답변 등록 실패");
	        mv.setViewName("common/error");
	    }

	    return mv;
	}
	
	
	
}
