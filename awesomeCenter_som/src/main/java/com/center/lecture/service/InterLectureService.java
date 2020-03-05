package com.center.lecture.service;

import java.util.HashMap;
import java.util.List;

import com.center.lecture.model.LectureVO;
import com.center.lecture.model.PreBoardVO;
import com.center.lecture.model.PreCommnetVO;

public interface InterLectureService {
	
   	/////////////////////////////////////////////////////////////////////////////////////////////////////
   	//////소미 service//////////////////////////////////////////////////////////////////////////////
   	////////////////////////////////////////////////////////////////////////////////////////////////////
 
	// 1. 검색어 없는 강좌리스트 불러오기
	List<LectureVO> lectureApply(HashMap<String, String> pageMap);

	// 2. 총 강좌 수 구하기
	int getTotalPage(HashMap<String, String> pageMap);
	
	// 3. 강좌 상세 페이지 정보 가져오기
	LectureVO lectureDetail(String class_seq);

	// 4. 접수날짜 가져오기
	String lectureRegister_term();

	// 5. 강사 정보 가져오기
	HashMap<String, String> getTeacherInfo(int fk_teacher_seq);

	// 6. 강좌스케쥴 정보 가져오기
	List<LectureVO> lectureScheduleJSON(HashMap<String, String> scheduleMap);
	////////////1차 합치기/////////////////////////////////////////////////////////////////////////////////
	
	// 7. 좋아요 게시판에 insert 하기
	void likeLecture(HashMap<String, String> likeMap);
	
	// 8. 좋아요 게시판에서 delete 하기
	void dislikeLecture(HashMap<String, String> likeMap);
	
	// 9. 좋아요 게시판에 있는지 찾아오기
	int checkHeart(HashMap<String, String> likeMap);
	
	// 10. 대기자 List에 insert하기 
	void registerWait(HashMap<String, String> waitMap);
	
	// 11. 해당 강좌에 접수하였는지 알아온다
	int checkWaiting(HashMap<String, String> waitMap);
	
	// 12. 매월 1일 전월의 모든 강의를 접수마감으로 변경
	void closeLecture() throws Exception;
	
	// 13. 상세페이지에 총 리뷰갯수 가져오기
	int checkReviewNum(String class_seq);
	
	// 14. 수강후기 가져오기
	List<HashMap<String, String>> getReviewDetail(String class_seq);
	
	// 15. 강좌컬럼하트 insert
	void likeLectureCol(HashMap<String, String> likeMap);
	
	// 16. 강좌컬럼하트 delete
	void dislikeLectureCol(HashMap<String, String> likeMap);
	
	// 17. 회원별 관심강좌 가져오기
	List<String> getLikeCat(String userno);
	
	// 18. 인기강사 가져오기
	List<HashMap<String, String>> getGoodTea(List<String> catList);
	
	// 19. 해당 회원이 좋아요한 모든 강좌의 갯수를 불러온다
	int totalLikeCnt(String userno);
	
	// 20. 페이징 처리한 좋아요 리스트 불러오기
	List<LectureVO> myLikeLecturesList(HashMap<String, String> likeMap);
	
	// 21.해당 클래스에 수강중인지 확인
	int checkThisClass(HashMap<String, String> checkMap);
	
	// 22. 첨부파일 없는 글쓰기
	int addPreBoard(PreBoardVO pbvo);
	
	// 23. 첨부파일 있는 글쓰기
	int addPreBoard_withFile(PreBoardVO pbvo);
	
	// 24. 게시판 글 목록 가져오기
	List<PreBoardVO> getPrepareList(HashMap<String, String> pageMap);
	
	// 25. 게시판 글 삭제
	int deletePreBoard(String preSeq);
	
	// 26. 글 상세 가져오기
	PreBoardVO prepareDetail(String preSeq);
	
	// 27. 글 수정하기
	void editPre(PreBoardVO preboardvo);
	
	// 28. 글 수정하기 (첨부파일)
	void editPre_withFile(PreBoardVO preboardvo);
	
	// 29. 재료준비 게시판 총 페이지 수 구해오기
	int getPretotalPage(HashMap<String, String> pageMap);
	
	// 30. 댓글 insert
	int writePreComment(HashMap<String, String> commentMap);
	
	// 31. 댓글 불러오기
	List<PreCommnetVO> getCommentList(HashMap<String, String> commentMap);
	
	// 32. 게시글 댓글 수 카운트하기
	void preCountComment(HashMap<String, String> commentMap);
	
	// 33. 답글 insert하기
	void writePreReply(HashMap<String, String> commentMap);
	
	// 34. 비밀글 변경
	void simpleLock(HashMap<String, String> commentMap);
	
	// 35. 댓글 수정하기
	void editPreReply(HashMap<String, String> commentMap);
	
	// 36. 리댓글 있는 댓글 삭제(status변경)
	void deletePreReply(String preComSeq);
	
	// 37. 리댓글 달렸는지 아닌지 확인
	int chkforDel(String preComSeq);
	
	// 38. 리댓글 없는 댓글 삭제(delete)
	void purgePreReply(String preComSeq);
	
	// 39. 해당댓글의 원글 번호 가져오기
	String getOriginNo(String preComSeq);
	
	// 40. 해당 글이 삭제상태인지 확인
	int chkforStat(String originno);
	
	// 41. 댓글 총 갯수 변경
	void reduceReplyCount(String fk_preSeq);
	
	// 42. 대기접수 신청 확인
	int checkWaitingList(HashMap<String, String> waitMap);
	
	
   	/////////////////////////////////////////////////////////////////////////////////////////////////////
   	//////승헌님의 service//////////////////////////////////////////////////////////////////////////////
   	////////////////////////////////////////////////////////////////////////////////////////////////////
 
	// 검색해서 강좌리스트 뽑아오기
	List<HashMap<String, String>> getSearchList(HashMap<String, String> paramap);

	// 검색 카테고리 가져오기
	List<HashMap<String, String>> getLecCate(String cate_code);
	
	// pagination 처리 안 되어진 상품 목록갯수를 가져온다
	int totalCount(HashMap<String, String> paramap);
	////////////1차 합치기/////////////////////////////////////////////////////////////////////////////////

	// 회원별 관심카테고리 가져오기(추천강좌)
	List<String> getWishList(String userid);

	// 카테고리 별 랜덤 강좌 불러오기(추천강좌)
	List<LectureVO> getRandomLec(HashMap<String, Object> map);

   	// 인기강좌 
	List<LectureVO> populLec();

	/// >> 차트 << 카테고리 별로 하트 점유율 가져오기
	List<HashMap<String, String>> cate_heart();

	/// >> 차트 << 카테고리 내 인기 강좌 차트 가져오기
	List<HashMap<String, String>> class_heart(String fk_cate_no);

	

	

	

	

	

	

	

	

	

	

	


	

	

	

	

	

	

	
	

	

	

	
	
}
