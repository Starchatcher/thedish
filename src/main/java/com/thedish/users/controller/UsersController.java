package com.thedish.users.controller;

import java.sql.Date;
import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;

import com.thedish.common.Paging;
import com.thedish.common.Search;
import com.thedish.user.model.vo.Users;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class UsersController {
	private static final Logger logger = LoggerFactory.getLogger(UsersController.class);

	@Autowired
	private UsersService usersService;

	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;

	@RequestMapping("loginPage.do")
	public String moveLoginPage() {
		return "users/loginPage";
	}

	@RequestMapping("enrollPage.do")
	public String moveEnrollPage() {
		return "users/enrollPage";
	}

	@RequestMapping(value = "login.do", method = RequestMethod.POST)
	public String loginMethod(Users users, HttpSession session, SessionStatus status, Model model) {
		logger.info("login.do : " + users);
		Users loginUser = usersService.selectUsers(users.getUserId());
		if (loginUser != null && this.bcryptPasswordEncoder.matches(users.getPassword(), loginUser.getPassword())) {
			session.setAttribute("loginUser", loginUser);
			status.setComplete();
			return "common/main";
		} else {
			model.addAttribute("message", "로그인 실패! 아이디나 암호를 다시 확인하세요. 또는 로그인 제한 회원입니다. 관리자에게 문의하세요.");
			return "common/error";
		}
	}

	@RequestMapping("logout.do")
	public String logoutMethod(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession(false);
		if (session != null) {
			session.invalidate();
			return "common/main";
		} else {
			model.addAttribute("message", "로그인 세션이 존재하지 않습니다.");
			return "common/error";
		}
	}

	@RequestMapping(value = "idchk.do", method = RequestMethod.POST)
	@ResponseBody
	public String dupCheckUserIdMethod(@RequestParam("userId") String userId) {
		int result = usersService.selectCheckId(userId);
		return (result == 0) ? "ok" : "dup";
	}

	@RequestMapping(value = "enroll.do", method = RequestMethod.POST)
	public String usersInsertMethod(Users users, Model model, HttpServletRequest request) {
		logger.info("enroll.do : " + users);
		String encodePwd = bcryptPasswordEncoder.encode(users.getPassword());
		logger.info("암호화된 패스워드 : " + encodePwd);
		users.setPassword(encodePwd);

		int result = usersService.insertusers(users);

		if (result > 0) {
			return "users/loginPage";
		} else {
			model.addAttribute("message", "회원 가입 실패! 확인하고 다시 가입해 주세요.");
			return "common/error";
		}
	}

	@RequestMapping("myinfo.do")
	public String usersDetailMethod(@RequestParam("userId") String userId, Model model) {
		logger.info("myinfo.do : " + userId);
		
		Users users = usersService.selectUsers(userId);
		
		if (users != null) {
			model.addAttribute("users", users);
			return "users/infoPage";
		} else {
			model.addAttribute("message", userId + " 에 대한 회원 정보 조회 실패! 아이디를 다시 확인하세요.");
			return "common/error";
		}
	}

	@RequestMapping(value="mupdate.do", method=RequestMethod.POST)
	public String usersUpdateMethod(Users users, Model model, HttpServletRequest request,
			@RequestParam("originalPwd") String originalPassword,
			@RequestParam("ofile") String originalFileName) {
		logger.info("mupdate.do : " + users);
		if (users.getPassword() != null && users.getPassword().length() > 0) {
			users.setPassword(this.bcryptPasswordEncoder.encode(users.getPassword()));
			logger.info("변경된 암호 확인 : " + users.getPassword() + ", length : " + users.getPassword().length());
		} else {
			users.setPassword(originalPassword);
		}

		if (usersService.updateUsers(users) > 0) {
			return "redirect:main.do";
		} else {
			model.addAttribute("message", "회원 정보 수정 실패! 확인하고 다시 가입해 주세요.");
			return "common/error";
		}
	}
	
	@RequestMapping("mdelete.do")
	public String usersDeleteMethod(@RequestParam("userId") int userId, Model model) {
		if(usersService.deleteUsers(userId) > 0) {
			return "redirect:logout.do";
		} else {
			model.addAttribute("message", userId + "님의 회원 탈퇴 실패! 관리자에게 문의하세요");
			return "common/error";
		}
	}
	
	@RequestMapping("mlist.do")
	public ModelAndView usersListMethod(ModelAndView mv, 
			@RequestParam(name="page", required=false) String page,
			@RequestParam(name="limit", required=false) String slimit) {
		int currentPage = 1;
		if (page != null) {
			currentPage = Integer.parseInt(page);
		}
		int limit = 10;
		if (slimit != null) {
			limit = Integer.parseInt(slimit);
		}
		
		int listCount = usersService.selectListCount();
		
		Paging paging = new Paging(listCount, limit, currentPage, "mlist.do");
		paging.calculate();
		
		ArrayList<Users> list = usersService.selectList(paging);
		
		if(list != null && list.size() > 0) {
			mv.addObject("list", list);
			mv.addObject("paging", paging);
			mv.setViewName("users/usersListView");
		} else {
			mv.addObject("message", currentPage + "페이지에 출력할 회원 조회 실패!");
			mv.setViewName("common/error");
		}
		return mv;
	}
	
	@RequestMapping("status.do")
	public String changeStatusMethod(Users users, Model model) {
		if(usersService.updateStatus(users) > 0) {
			return "redirect:mlist.do";
		} else {
			model.addAttribute("message", "로그인 제한/허용 처리 오류 발생");
			return "common/error";
		}
	}
	
	@RequestMapping(value="msearch.do", method= {RequestMethod.POST, RequestMethod.GET})
	public ModelAndView usersSearchMethod(HttpServletRequest request, ModelAndView mv) {
		String action = request.getParameter("action");
		String keyword = request.getParameter("keyword");
		String begin = request.getParameter("begin");
		String end = request.getParameter("end");
		
		Search search = new Search();
		
		if(action.equals("createdAt")) {
			if(begin != null && end != null) {
				search.setBegin(Date.valueOf(begin));
				search.setEnd(Date.valueOf(end));
			}
		
		int currentPage = 1;
		if(request.getParameter("page") != null) {
			currentPage = Integer.parseInt(request.getParameter("page"));
		}
		
		int limit = 10;
		if(request.getParameter("limit") != null) {
			limit = Integer.parseInt(request.getParameter("limit"));
		}
		
		int listCount = 0;
		
		switch(action) {
		case "uid":	listCount = usersService.selectSearchUserIdCount(keyword);		break;
		case "createdAt":	listCount = usersService.selectSearchCreatedAtCount(search);	break;
		case "status":	listCount = usersService.selectSearchStatusCount(keyword);	break;
		}
		
		Paging paging = new Paging(listCount, limit, currentPage, "msearch.do");
		paging.calculate();
		
		ArrayList<Users> list = null;
		search.setStartRow(paging.getStartRow());
		search.setEndRow(paging.getEndRow());
		
		switch(action) {
		case "uid":	list = usersService.selectSearchUserId(search);		break;
		case "createdAt":	list = usersService.selectSearchCreatedAt(search);	break;
		case "status":	list = usersService.selectSearchStatus(search);	break;
		}
		
		if(list != null && list.size() > 0) {
			mv.addObject("list", list);
			mv.addObject("paging", paging);
			mv.addObject("action", action);
			if(keyword != null) {
				mv.addObject("keyword", keyword);
			}else {
				mv.addObject("begin", begin);
				mv.addObject("end", end);
			}
			mv.setViewName("users/usersListView");
		}else {
			mv.addObject("message", "회원 관리 검색 결과가 존재하지 않습니다.");
			mv.setViewName("common/error");
		}
		
		return mv;
		
		}
	}
}

