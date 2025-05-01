package com.thedish.recipe.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thedish.comment.model.service.CommentService;
import com.thedish.comment.model.vo.Comment;
import com.thedish.common.Allergy;
import com.thedish.common.Paging;
import com.thedish.common.Search;
import com.thedish.image.model.service.ImageService;
import com.thedish.image.model.vo.Image;
import com.thedish.recipe.model.vo.Recipe;
import com.thedish.recipe.service.impl.RecipeService;
import com.thedish.users.model.vo.Users;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;


class RecipeStep implements Comparable<RecipeStep> {
    int stepNumber;
    String stepContent;

    public RecipeStep(int stepNumber, String stepContent) {
        this.stepNumber = stepNumber;
        this.stepContent = stepContent;
    }

    public int getStepNumber() {
        return stepNumber;
    }

    public String getStepContent() {
        return stepContent;
    }

    // 번호를 기준으로 오름차순 정렬하기 위한 compareTo 메소드 구현
    @Override
    public int compareTo(RecipeStep other) {
        return Integer.compare(this.stepNumber, other.stepNumber);
    }
}

@Controller
public class RecipeController {

	private static final Logger logger = LoggerFactory.getLogger(RecipeController.class);
	@Autowired
	private RecipeService recipeService;
	
	@Autowired
	private ImageService imageService;
	
	@Autowired
	private CommentService commentService;	 
	 
	// 레시피 전체 목록보기 요청 처리용 (페이징 처리 : 한 페이지에 12개씩 출력 처리)
		@RequestMapping("recipeList.do")
		public ModelAndView recipeListMethod(ModelAndView mv, 
				@RequestParam(name = "page", required = false) String page,
				@RequestParam(name = "limit", required = false) String slimit) {
			// 페이징 처리
			int currentPage = 1;
			if (page != null) {
				currentPage = Integer.parseInt(page);
			}

			// 한 페이지에 출력할 목록 갯수 기본 12개로 지정함
			int limit = 12;
			if (slimit != null) {
				limit = Integer.parseInt(slimit);
			}

			// 총 목록 갯수 조회해서, 총 페이지 수 계산함
			int listCount = recipeService.selectListCount();
			// 페이지 관련 항목들 계산 처리
			Paging paging = new Paging(listCount, limit, currentPage, "recipeList.do");
			paging.calculate();

			// 서비스 모델로 페이징 적용된 목록 조회 요청하고 결과받기
			ArrayList<Recipe> list = recipeService.selectListRecipe(paging);

			if (list != null && list.size() > 0) { // 조회 성공시
				// ModelAndView : Model + View
				mv.addObject("list", list); // request.setAttribute("list", list) 와 같음
				mv.addObject("paging", paging);

				mv.setViewName("recipe/recipeList");
			} else { // 조회 실패시
				mv.addObject("message", currentPage + "페이지에 출력할 레시피 목록 조회 실패!");
				mv.setViewName("common/error");
			}

			return mv;
		}
		
		// 레시피 상세보기 요청 처리용
		@RequestMapping("/recipeDetail.do")
		public ModelAndView recipeDetailMethod(
		    @RequestParam("no") int recipeId, 
		    ModelAndView mv, 
		    HttpSession session,
		    @RequestParam(value = "page", required = false, defaultValue = "1") int page
		) {
		    logger.info("recipeDetail.do 호출 - recipeId: {}", recipeId);

		    // 레시피 조회
		    Recipe recipe = recipeService.selectRecipe(recipeId);
		    recipeService.updateAddReadCount(recipeId); // 조회수 증가   

		    
		    if (recipe != null) {
		    	logger.info("레시피 데이터 조회 성공. 파싱 및 정렬 로직 시작.");

		        String rawInstructions = recipe.getInstructions();
		        if (rawInstructions != null && !rawInstructions.trim().isEmpty()) {
		        	  List<RecipeStep> steps = new ArrayList<>();
		              // 줄 단위로 분리합니다. (다양한 줄 바꿈 문자 처리)
		              String[] lines = rawInstructions.split("\\r?\\n");

		              // 줄의 시작이 "숫자. " 패턴인지 확인하는 패턴
		              Pattern stepStartPattern = Pattern.compile("^(\\d+)\\.\\s*(.*)");

		              int currentStepNumber = -1;
		              StringBuilder currentStepContent = new StringBuilder();

		              for (String line : lines) {
		                  line = line.trim(); // 각 줄의 앞뒤 공백 제거
		                  if (line.isEmpty()) {
		                      continue; // 빈 줄은 건너뜁니다.
		                  }

		                  Matcher matcher = stepStartPattern.matcher(line);

		                  if (matcher.find()) {
		                      // 현재 줄이 새로운 단계의 시작인 경우
		                      // 이전까지 모아둔 내용이 있다면, 이전 단계를 확정하고 리스트에 추가
		                      if (currentStepContent.length() > 0 && currentStepNumber != -1) {
		                           steps.add(new RecipeStep(currentStepNumber, currentStepContent.toString().trim()));
		                           currentStepContent = new StringBuilder(); // 새로운 단계 내용을 모을 StringBuilder 초기화
		                      } else if (currentStepContent.length() > 0 && currentStepNumber == -1) {
		                           
		                           // 현재 로직에서는 새로운 단계로 시작하는 것으로 간주합니다.
		                           logger.warn("번호 없이 시작하는 내용 후 새로운 단계 시작: {}", line);
		                           currentStepContent = new StringBuilder(); // 새로운 단계 내용을 모을 StringBuilder 초기화
		                      }

		                      try {
		                          currentStepNumber = Integer.parseInt(matcher.group(1)); // 새로운 단계 번호 추출
		                          currentStepContent.append(matcher.group(2).trim()); // 새로운 단계 내용의 첫 부분 추가
		                      } catch (NumberFormatException e) {
		                          logger.error("조리법 번호 파싱 오류 (새로운 단계 시작 시): {}", matcher.group(1), e);
		                        
		                           currentStepNumber = -1; // 번호 오류이므로 유효한 단계 번호가 아닙니다.
		                           
		                      }
		                  } else {
		                     
		                      if (currentStepContent.length() > 0) {
		                          // 이전 단계의 내용이 있다면, 현재 줄을 추가합니다.
		                          currentStepContent.append("\n").append(line); // 줄 바꿈으로 구분하여 추가
		                      } else {
		                         
		                           logger.warn("처리되지 않은 조리법 줄 (내용 없음): {}", line);
		                      }
		                  }
		              }

		              // 반복문이 끝난 후, 마지막으로 모아둔 내용을 리스트에 추가합니다.
		              if (currentStepContent.length() > 0 && currentStepNumber != -1) {
		                  steps.add(new RecipeStep(currentStepNumber, currentStepContent.toString().trim()));
		              } else if (currentStepContent.length() > 0 && currentStepNumber == -1) {
		                   
		                   logger.warn("처리되지 않은 조리법 내용 (마지막 부분): {}", currentStepContent.toString());
		              }


		              // 번호를 기준으로 오름차순 정렬
		              Collections.sort(steps); // RecipeStep 클래스에 compareTo 메소드가 구현되어 있어 바로 정렬 가능

		              // 정렬된 단계를 다시 하나의 문자열로 조합 (번호와 함께)
		              StringBuilder sortedInstructionsBuilder = new StringBuilder();
		              for (int i = 0; i < steps.size(); i++) {
		                  sortedInstructionsBuilder.append(steps.get(i).getStepNumber())
		                                            .append(". ")
		                                            .append(steps.get(i).getStepContent().trim()); // 최종 내용 앞뒤 공백 다시 제거
		                  if (i < steps.size() - 1) {
		                      sortedInstructionsBuilder.append("\n"); // 각 단계별 줄 바꿈
		                  }
		              }
		               

		              // Recipe 객체의 instructions 필드를 정렬된 문자열로 업데이트
		              recipe.setInstructions(sortedInstructionsBuilder.toString());

		          } 

		          mv.addObject("recipe", recipe);

		          if (rawInstructions != null && !rawInstructions.trim().isEmpty()) {
		              // 파싱 및 정렬이 성공적으로 수행되어 recipe 객체가 업데이트된 경우
		              mv.addObject("sortedInstructions", recipe.getInstructions()); // 업데이트된 recipe 객체의 instructions 사용
		          } else {
		              // 파싱 로직이 실행되지 않은 경우 (instructions가 비어있거나 null)
		              mv.addObject("sortedInstructions", ""); // 또는 원본 내용 mv.addObject("sortedInstructions", rawInstructions);
		          }
		          
		          
		        // 알러지 정보 조회
		        List<Allergy> allergyList = recipeService.selectAllergyByRecipeId(recipeId);
		        if (allergyList != null && !allergyList.isEmpty()) {
		            logger.info("조회된 알러지 리스트: {}", allergyList);
		            mv.addObject("allergyList", allergyList);
		        } else {
		            logger.warn("알러지 리스트가 비어 있습니다!");
		            mv.addObject("allergyList", new ArrayList<>());
		        }

		        // 댓글 관련 처리
		        int commentsPerPage = 10;
		        String targetType = "recipe";

		        // 댓글 총 개수 조회
		        int totalComments = commentService.selectCommentCount(recipeId, targetType);
		        logger.info("조회된 댓글 총 개수: {}", totalComments);

		        int totalPages = (int) Math.ceil((double) totalComments / commentsPerPage);
		        if (totalPages == 0) totalPages = 1;

		        if (page < 1) page = 1;
		        if (page > totalPages) page = totalPages;

		        int offset = (page - 1) * commentsPerPage;

		        // 댓글 리스트 조회
		        List<Comment> comments = commentService.selectComments(recipeId, targetType, offset, commentsPerPage);
		        if (comments == null) {
		            logger.warn("commentService.selectComments()가 null을 반환했습니다.");
		            comments = new ArrayList<>();
		        }
		        logger.info("조회된 댓글 리스트 크기: {}", comments.size());
		        for (Comment c : comments) {
		            logger.info("댓글 ID: {}, 내용: {}", c.getCommentId(), c.getContent());
		        }

		        mv.addObject("comments", comments);
		        mv.addObject("page", page);
		        mv.addObject("totalPages", totalPages);

		        mv.setViewName("recipe/recipeDetail");
		    } else {
		        logger.error("{}번 레시피가 존재하지 않습니다!", recipeId);
		        mv.addObject("message", recipeId + "번 레시피가 존재하지 않습니다.");
		        mv.setViewName("common/error");
		    }

		    return mv;
		}



		// 레시피 검색 기능
		@RequestMapping("recipeSearch.do")
		public ModelAndView recipeSearchTitleMethod(ModelAndView mv, @RequestParam("action") String action,
				@RequestParam("keyword") String keyword, @RequestParam(name = "page", required = false) String page,
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

			// 검색결과가 적용된 총 목록 갯수 조회해서, 총 페이지 수 계산함
			int listCount = recipeService.selectSearchTitleCount(keyword);
			// 페이지 관련 항목들 계산 처리
			Paging paging = new Paging(listCount, limit, currentPage, "recipeSearch.do");
			paging.calculate();

			// 마이바티스 매퍼에서 사용되는 메소드는 Object 1개만 전달할 수 있음
			// paging.startRow, paging.endRow, keyword 같이 전달해야 하므로 => 객체 하나를 만들어서 저장해서 보냄
			Search search = new Search();
			search.setKeyword(keyword);
			search.setStartRow(paging.getStartRow());
			search.setEndRow(paging.getEndRow());

			// 서비스 모델로 페이징 적용된 목록 조회 요청하고 결과받기
			ArrayList<Recipe> list = recipeService.selectSearchTitle(search);
			

			if (list != null && list.size() > 0) { // 조회 성공시
				// ModelAndView : Model + View
				
				mv.addObject("list", list); // request.setAttribute("list", list) 와 같음
				mv.addObject("paging", paging);
				mv.addObject("action", action);
				mv.addObject("keyword", keyword);

				mv.setViewName("recipe/recipeList");
			} else { // 조회 실패시
				mv.addObject("message", action + "에 대한 " + keyword + " 검색 결과가 존재하지 않습니다.");
				mv.setViewName("common/error");
			}

			return mv;
		}

		@RequestMapping("moveInsertRecipePage.do")
		public String moveInsertRecipe() {
			return "recipe/insertRecipe";
		}

		// 새 레시피 원글 등록 요청 처리용(이미지 업로드 기능 포함)	

		@RequestMapping(value = "insertRecipe.do", method = RequestMethod.POST)
		public String insertRecipe(
		        Recipe recipe,
		        @RequestParam(name = "imageFile", required = false) MultipartFile imageFile,
		        Model model) {

		    // 1. 레시피 저장 (자동 생성된 ID를 recipe.id에 세팅)
		    recipeService.insertRecipe(recipe);

		    // 2. 이미지 파일이 있을 경우 이미지 저장
		    if (imageFile != null && !imageFile.isEmpty()) {
		        try {
		        	 byte[] imageBytes = imageFile.getBytes();

		            Image image = new Image();
		            image.setTargetId(recipe.getRecipeId());
		            image.setTargetType("recipe");
		            image.setImageData(imageBytes);
		            image.setDescription("레시피 이미지");

		            imageService.insertImage(image);
		        } catch (IOException e) {
		            e.printStackTrace();
		            // 예외 처리 로직 추가 (예: 에러 메시지 모델에 담기, 로그 기록 등)
		            model.addAttribute("msg", "이미지 업로드 중 오류가 발생했습니다.");
		            return "errorPage";  // 적절한 에러 페이지로 이동
		        }
		    }


		    return "redirect:recipeList.do";
		}
		
		// 레시피 수정 페이지로 이동 처리용
		@RequestMapping("moveUpdateRecipePage.do")
		public String moveBoardUpdatePage(Model model, 
				@RequestParam("recipeId") int recipeId,
				@RequestParam("page") int currentPage) {

			// 수정 페이지로 전달할 board 정보 조회함
			Recipe recipe = recipeService.selectRecipe(recipeId);

			if (recipe != null) {
				model.addAttribute("recipe", recipe);
				model.addAttribute("currentPage", currentPage);
				return "recipe/recipeUpdate";
			} else {
				model.addAttribute("message", recipeId + "번 레시피 수정페이지로 이동 실패!");
				return "common/error";
			}
		}
		
		// 레시피 수정 처리용 메소드
		@RequestMapping(value="recipeUpdate.do",
				method=RequestMethod.POST)
		public String recipeUpdateMethod(Recipe recipe, Model model,
				HttpServletRequest request,
				@RequestParam("imageFile") MultipartFile imageFile)
				
				 {
			logger.info("recipeUpdate.do : " + recipe);	
				

			try {
		        // 1. 레시피 기본 정보 수정
		        int result = recipeService.updateRecipe(recipe);

		        if (result <= 0) {
		            model.addAttribute("message", "레시피 수정 실패");
		            return "common/error";
		        }

		        // 2. 이미지 파일이 새로 업로드 되었으면 처리
		        if (imageFile != null && !imageFile.isEmpty()) {
		            byte[] imageBytes = imageFile.getBytes();

		            Image image = new Image();
		            image.setTargetId(recipe.getRecipeId());
		            image.setTargetType("recipe");
		            image.setImageData(imageBytes);
		            image.setDescription("레시피 이미지");

		            // 기존 이미지가 있을 경우 삭제 로직(필요시) 수행 후 새 이미지 저장
		            imageService.deleteImageByTargetIdAndType(recipe.getRecipeId(), "recipe");
		            imageService.insertImage(image);
		        }

		        // 수정 성공 후 상세 페이지로 리다이렉트
		        return "redirect:recipeDetail.do?no=" + recipe.getRecipeId();

		    } catch (IOException e) {
		        e.printStackTrace();
		        model.addAttribute("message", "이미지 업로드 중 오류가 발생했습니다.");
		        return "common/error";
		    } catch (Exception e) {
		        e.printStackTrace();
		        model.addAttribute("message", "레시피 수정 중 오류가 발생했습니다.");
		        return "common/error";
		}
				 }
		// 레시피 삭제
		 @RequestMapping(value = "deleteRecipe.do", method = RequestMethod.POST)
		    public String deleteRecipe(
		            @RequestParam("recipeId") int recipeId,
		            @RequestParam(value = "page", defaultValue = "1") int page,
		            RedirectAttributes redirectAttrs) {

		        try {
		            recipeService.deleteRecipe(recipeId);
		            redirectAttrs.addFlashAttribute("message", "레시피가 성공적으로 삭제되었습니다.");
		        } catch (Exception e) {
		            redirectAttrs.addFlashAttribute("errorMessage", "삭제 중 오류가 발생했습니다.");
		            e.printStackTrace();
		        }

		        return "redirect:/recipeList.do?page=" + page;
		    }
		
		 // 레시피 평점 기능
		 @RequestMapping(value = "rateRecipe.do", method = RequestMethod.POST)
		  
		    public String rateRecipe(
		            @RequestParam("recipeId") int recipeId,
		            @RequestParam(value = "rating", defaultValue = "0") double ratingScore, // 평점 값, 기본값을 0으로 설정
		            HttpSession session,
		            RedirectAttributes redirectAttributes) {

			

		        // 1. 로그인한 사용자 정보 가져오기
		        Users loggedInUser = (Users) session.getAttribute("loginUser");

		        // 2. 로그인 상태 확인
		     

		        String loginId = loggedInUser.getLoginId(); // 로그인 ID 가져오기

		        // 평점이 이미 존재하는지 확인
		        int existingRatingCount = recipeService.selectUserRating(loginId, recipeId);
		        if (existingRatingCount > 0) {
		            // 이미 평점을 부여한 경우, 업데이트
		            recipeService.updateRating(loginId, recipeId, ratingScore, "recipe");
		            redirectAttributes.addFlashAttribute("message", "평점이 수정되었습니다.");
		        } else {
		            // 평점을 새로 추가
		            recipeService.insertRating(loginId, recipeId, ratingScore, "recipe");
		            redirectAttributes.addFlashAttribute("message", "평점이 등록되었습니다.");
		        }

		        // 평균 평점 업데이트
		        double averageRating = recipeService.getAverageRating(recipeId);
		        recipeService.updateAverageRating(recipeId, averageRating); // 평균 평점 업데이트

		        redirectAttributes.addFlashAttribute("avgRating", averageRating); // 평균 평점 반환

		        return "redirect:/recipeDetail.do?no=" + recipeId; // 레시피 상세 페이지로 리다이렉션

		 }
		 
		 
		 


}

