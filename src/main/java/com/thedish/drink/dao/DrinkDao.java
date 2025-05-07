package com.thedish.drink.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.thedish.common.Paging;
import com.thedish.common.Pairing;
import com.thedish.common.Search;
import com.thedish.drink.model.vo.Drink;
import com.thedish.drink.model.vo.DrinkStore;

@Repository("drinkDao")
public class DrinkDao {
	
	 private static final Logger logger = LoggerFactory.getLogger(DrinkDao.class);
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	public int selectListCount() {
		return sqlSessionTemplate.selectOne("drinkMapper.selectListCount");
	}
	
	
	
	public ArrayList<Drink> selectListDrink(Paging paging) {
		List<Drink> list = sqlSessionTemplate.selectList("drinkMapper.selectListDrink", paging);
		return(ArrayList<Drink>) list;
	}
	
	public Drink selectDrink(int drinkId) {
		return sqlSessionTemplate.selectOne("drinkMapper.selectDrink", drinkId);
	}
	
	public void updateAddReadCount(int drinkId) {
		sqlSessionTemplate.update("drinkMapper.updateAddReadCount", drinkId);
	}

	
	
	public int selectSearchTitleCount(String keyword) {
		return sqlSessionTemplate.selectOne("drinkMapper.selectSearchTitleCount", keyword);
	}
	
	public ArrayList<Drink> selectSearchTitle(Search search){
		List<Drink> list = sqlSessionTemplate.selectList("drinkMapper.selectSearchTitle", search);
		return (ArrayList<Drink>)list;
	}
	
	
	public int insertDrink(Drink drink) {
		return sqlSessionTemplate.insert("drinkMapper.insertDrink", drink);
	}
	
	
	public int updateDrink(Drink drink) {
		return sqlSessionTemplate.update("drinkMapper.updateDrink", drink);
	}
	public int deleteDrink(int drinkId) {
	    return sqlSessionTemplate.delete("drinkMapper.deleteDrink", drinkId);
	}
	
	
	
    public boolean incrementRecommendationCount(int drinkId) {
        int rowsAffected = sqlSessionTemplate.update("drinkMapper.incrementRecommendationCount", drinkId);
        return rowsAffected > 0; // 업데이트 성공 여부 반환
    }

    public int getRecommendationCount(int drinkId) {
    	return sqlSessionTemplate.selectOne("drinkMapper.getRecommendationCount", drinkId);
    }
    
    
    
    public List<Pairing> selectPairingsByDrinkId(int drinkId) {        
        return sqlSessionTemplate.selectList("drinkMapper.selectPairingsByDrinkId", drinkId);
    }
    
    
    // 특정 사용자가 특정 레시피에 대한 평점이 있는지 확인
    public int selectUserRating(String loginId, int drinkId) {
        Map<String, Object> params = new HashMap<>();
        params.put("loginId", loginId);
        params.put("drinkId", drinkId);
        return sqlSessionTemplate.selectOne("drinkMapper.selectUserRating", params);
    }

    // 평점 추가
    public void insertRating(String loginId, int drinkId, double ratingScore, String targetType) {
        Map<String, Object> params = new HashMap<>();
        params.put("loginId", loginId);
        params.put("drinkId", drinkId);
        params.put("ratingScore", ratingScore);
        params.put("targetType", targetType);
        sqlSessionTemplate.insert("drinkMapper.insertRating", params);
    }

    // 평점 수정
    public void updateRating(String loginId, int drinkId, double ratingScore, String targetType) {
        Map<String, Object> params = new HashMap<>();
        params.put("loginId", loginId);
        params.put("drinkId", drinkId);
        params.put("ratingScore", ratingScore);
        params.put("targetType", targetType);
        sqlSessionTemplate.update("drinkMapper.updateRating", params);
    }
    
    public void updateAverageRating(int drinkId, double avgRating) {
        Map<String, Object> params = new HashMap<>();
        params.put("drinkId", drinkId);
        params.put("avgRating", avgRating);
        sqlSessionTemplate.update("drinkMapper.updateAverageRating", params);
    }
    
    public double getAverageRating(int drinkId) {
        return sqlSessionTemplate.selectOne("drinkMapper.getAverageRating", drinkId);
    }
    
    public Map<String, Object> selectStoreInfoByDrinkId(int drinkId) { // 메소드 이름도 변경하는 것이 더 의미 명확
        // 또는 public Map<String, String> selectStoreInfoByDrinkId(int drinkId) { ... }

            // sqlSessionTemplate.selectOne 호출 시 매퍼 ID는 그대로 사용
            // 매퍼의 resultType이 Map이므로 반환 타입을 Map으로 받습니다.
            Map<String, Object> storeInfo = sqlSessionTemplate.selectOne("drinkMapper.selectStoreAddressByDrinkId", drinkId);
            // Map<String, String> storeInfo = sqlSessionTemplate.selectOne("drinkMapper.selectStoreAddressByDrinkId", drinkId);


            if (storeInfo != null) {
                logger.info("DAO에서 조회된 스토어 정보: " + storeInfo.toString());
                // 조회된 정보 (예: storeInfo.get("STORE_ADDRESS"), storeInfo.get("STORE_NAME")) 사용 가능
            } else {
                logger.info("DAO에서 조회된 스토어 정보가 없습니다.");
            }

            return storeInfo; // Map 객체 자체를 반환
        }

    public List<DrinkStore> selectDrinkStoresByDrinkId(int drinkId) { // *** String drinkName을 파라미터로 받음 ***
        // "drinkMapper.selectDrinkStoresByDrinkName"는 drinkMapper.xml 파일에 정의될 select 쿼리의 id
        // resultType/resultMap은 DrinkStore 타입으로 지정해야 합니다.
        return sqlSessionTemplate.selectList("drinkMapper.selectDrinkStoresByDrinkId", drinkId);
    }

    public int insertDrinkStore(DrinkStore drinkStore) { // *** DrinkStore 객체를 파라미터로 받음 ***
        // "drinkMapper.insertDrinkStore"는 drinkMapper.xml 파일에 정의될 insert 쿼리의 id 입니다.
        // 쿼리에서는 DrinkStore 객체의 drinkName 필드를 사용하도록 수정해야 합니다.
        return sqlSessionTemplate.insert("drinkMapper.insertDrinkStore", drinkStore);
    }
    
    // *** 특정 Store ID에 해당하는 판매처 삭제 메소드 추가 ***
    public int deleteDrinkStore(int storeId) { // *** int storeId를 파라미터로 받음 ***
        // "drinkMapper.deleteDrinkStore"는 drinkMapper.xml 파일에 정의될 delete 쿼리의 id
        return sqlSessionTemplate.delete("drinkMapper.deleteDrinkStore", storeId);
    }
 
}
