package com.thedish;

import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.thedish.image.model.service.ImageService;
import com.thedish.image.model.vo.Image;
import com.thedish.notice.model.service.NoticeService;
import com.thedish.notice.model.vo.Notice;
import com.thedish.recipe.model.vo.Recipe;
import com.thedish.recipe.service.impl.RecipeService;

@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	@Autowired
	private NoticeService noticeService;
	
	   @Autowired
	    private RecipeService recipeService;

	 @Autowired
	    private ImageService imageService; 
	
	@RequestMapping("main.do")
	public String forwardMainView(Model model) {
		// 최신 공지사항 10개 조회해서 모델에 담기
	
		try {
		ArrayList<Notice> topNotices = noticeService.selectTop10();
		model.addAttribute("topNotices", topNotices);

		Recipe randomRecipe = recipeService.selectRandomRecipe();
		Image randomRecipeImage = null; // 랜덤 레시피의 이미지 정보를 담을 변수

		if (randomRecipe != null) {
			logger.info("랜덤으로 조회된 레시피 객체 ID: " + randomRecipe.getRecipeId());
			logger.info("랜덤으로 조회된 레시피 이름: " + randomRecipe.getName());
			
			// 3. *** 조회된 레시피 ID로 IMAGE 테이블에서 이미지 조회 (ImageService 사용) ***
			// ImageService에 selectImageByTarget(int targetId, String targetType) 메서드가 정의되어 있어야 합니다.
			int recipeId = randomRecipe.getRecipeId();
			String targetType = "recipe"; // 레시피 타입 지정 (실제 DB 저장 값 확인 필요)

			// ImageService를 통해 이미지 정보 조회
			
			randomRecipeImage = imageService.selectImageByTarget(recipeId, targetType);

			if (randomRecipeImage != null) {
				logger.info("조회된 랜덤 레시피 이미지 URL: " + randomRecipeImage.getImageUrl());
				// BLOB 데이터는 여기서 조회하지 않음 (image/view.do 에서 처리)
			} else {
				logger.warn(recipeId + "번 레시피에 해당하는 이미지 정보를 찾을 수 없습니다.");
			}

		} else {
			 logger.warn("랜덤 레시피를 조회하지 못했습니다. 메인 배너에 기본 이미지를 표시합니다.");
		}

		// 4. *** 조회된 랜덤 레시피 객체와 이미지 정보를 Model에 추가하여 JSP로 전달 ***
		model.addAttribute("randomRecipe", randomRecipe); // 랜덤 레시피 객체
		model.addAttribute("randomRecipeImage", randomRecipeImage); // 이미지 정보 객체


		// 5. 뷰 이름 반환
		return "common/main"; // → /WEB-INF/views/common/main.jsp

	} catch (Exception e) {
		// 예외 발생 시 처리
		logger.error("main.do 처리 중 오류 발생", e);
		// 에러 정보를 모델에 담아 에러 페이지로 포워딩하거나,
		// 메인 페이지에 오류 메시지를 표시하도록 처리할 수 있습니다.
		model.addAttribute("message", "메인 페이지 정보를 가져오는 중 오류가 발생했습니다.");
		
		
		return "common/main"; // → /WEB-INF/views/common/main.jsp
	}
}
	

  @RequestMapping("/terms.do") public String showTerms() { return
  "common/terms"; }
 

	@RequestMapping("/privacy.do")
	public String showPrivacy() {
	    return "common/privacy";
	}
	
}