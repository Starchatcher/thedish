package com.thedish.faq.controller;

import java.util.List;

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

import com.thedish.faq.model.service.FAQService;
import com.thedish.faq.model.vo.FAQ;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class FAQController {

    private static final Logger logger = LoggerFactory.getLogger(FAQController.class);

    @Autowired
    private FAQService faqService;

    // 새 FAQ 글 등록 페이지 이동
    @RequestMapping("FAQWrite.do")
    public String moveWritePage() {
        return "faq/FAQWriteView";
    }

    // FAQ 수정페이지로 이동 처리용
    @RequestMapping("faqmoveup.do")
    public ModelAndView moveUpdatePage(@RequestParam("no") int faqId, ModelAndView mv) {
        FAQ faq = faqService.selectFAQ(faqId);
        if (faq != null) {
            mv.addObject("faq", faq);
            mv.setViewName("faq/FAQUpdateView");
        } else {
            mv.addObject("message", faqId + "번 FAQ 수정페이지로 이동 불가");
            mv.setViewName("common/error");
        }
        return mv;
    }

    // FAQ 목록 출력 (공통)
    @RequestMapping("FAQList.do")
    public ModelAndView faqListMethod(ModelAndView mv, HttpSession session) {
        logger.info("FAQ 목록 페이지 요청");
        List<FAQ> faqList = faqService.selectFAQList();
        mv.addObject("faqList", faqList);
        mv.setViewName("faq/FAQListView"); // 항상 같은 View 사용
        return mv;
    }

    // 새 FAQ 등록
    @RequestMapping(value = "faqinsert.do", method = RequestMethod.POST)
    public String faqInsertMethod(FAQ faq, Model model) {
        logger.info("faqinsert.do : " + faq);
        if (faqService.insertFAQ(faq) > 0) {
            return "redirect:FAQList.do";
        } else {
            model.addAttribute("message", "새 FAQ 등록 실패!");
            return "common/error";
        }
    }

    // FAQ 삭제
    @RequestMapping("faqdelete.do")
    public String faqDeleteMethod(Model model, @RequestParam("Id") int faqId) {
        if (faqService.deleteFAQ(faqId) > 0) {
            return "redirect:FAQList.do";
        } else {
            model.addAttribute("message", faqId + "번 FAQ 삭제 실패!");
            return "common/error";
        }
    }

    // FAQ 수정
    @RequestMapping(value = "faqupdate.do", method = RequestMethod.POST)
    public String faqUpdateMethod(FAQ faq, Model model) {
        logger.info("faqupdate.do : " + faq);
        if (faqService.updateFAQ(faq) > 0) {
            return "redirect:FAQList.do";
        } else {
            model.addAttribute("message", faq.getFaqId() + "번 FAQ 수정 실패!");
            return "common/error";
        }
    }

}
