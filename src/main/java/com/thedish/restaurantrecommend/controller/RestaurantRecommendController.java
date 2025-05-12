package com.thedish.restaurantrecommend.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.thedish.common.Paging;
import com.thedish.restaurantrecommend.model.service.RestaurantRecommendService;
import com.thedish.restaurantrecommend.model.vo.RestaurantRecommend;

@Controller
public class RestaurantRecommendController {

	 @Autowired
	    private RestaurantRecommendService restaurantRecommendService;
	 
	 
	 
	 
	 
	 @RequestMapping("restaurantRecommendList.do") // 요청 URL 매핑
	  public ModelAndView showRecommendationList(ModelAndView mv,
              @RequestParam(name = "page", required = false) String page,
              @RequestParam(name = "limit", required = false) String slimit) {
		 
		 

	        // 페이징 처리
	        int currentPage = 1;
	        if (page != null) {
	            try {
	                currentPage = Integer.parseInt(page);
	            } catch (NumberFormatException e) {
	                // 숫자로 변환할 수 없는 경우 기본값 1 사용 또는 에러 처리
	                currentPage = 1;
	                // 필요시 로그 기록
	            }
	        }

	        // 한 페이지에 출력할 목록 갯수 기본 10개로 지정 (필요에 따라 변경)
	        int limit = 10;
	        if (slimit != null) {
	             try {
	                limit = Integer.parseInt(slimit);
	            } catch (NumberFormatException e) {
	                // 숫자로 변환할 수 없는 경우 기본값 10 사용 또는 에러 처리
	                limit = 10;
	                // 필요시 로그 기록
	            }
	        }

	        // 총 목록 갯수 조회해서, 총 페이지 수 계산함
	        int listCount = restaurantRecommendService.selectRecommendationCount(); // Service 메소드 호출

	        // 페이지 관련 항목들 계산 처리
	        // Paging 객체 생성 시, urlMapping에 이 목록을 보여주는 컨트롤러 URL을 지정
	        Paging paging = new Paging(listCount, limit, currentPage, "restaurantRecommendList.do");
	        paging.calculate(); // Paging 객체 내부에서 필요한 값들 계산 (startPage, endPage, maxPage, startRow, endRow 등)

	        // 서비스 모델로 페이징 적용된 목록 조회 요청하고 결과받기
	        // DAO/Service 메소드는 Paging 객체에서 startRow, endRow 값을 활용하여 DB에서 해당 범위의 데이터만 가져옴
	        List<RestaurantRecommend> recommendList = restaurantRecommendService.selectRecommendationList(paging); // Service 메소드 호출

	        // ModelAndView : Model + View 정보를 함께 담는 객체
	        if (recommendList != null) { // 목록 조회 성공시 (빈 리스트일 수 있음)
	            mv.addObject("recommendList", recommendList); // 모델에 추천 목록 추가
	            mv.addObject("paging", paging); // 모델에 페이징 정보 추가 (pagingView.jsp에서 사용)

	            mv.setViewName("restaurantrecommend/restaurantRecommendList"); // 뷰 이름 설정 (WEB-INF/views/restaurantRecommendList.jsp)
	        } else { // 조회 실패시 (예: DB 연결 문제 등)
	             // 실제 애플리케이션에서는 에러 처리가 더 상세해야 함
	             mv.addObject("message", "맛집 추천 목록 조회 중 오류가 발생했습니다.");
	             mv.setViewName("common/error"); // 에러 페이지로 이동
	        }

	        return mv;
	    }
	
}
