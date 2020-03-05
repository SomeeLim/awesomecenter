package com.center.lecture.model;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class LectureDAO implements InterLectureDAO {
	
	@Autowired   // Type에 따라 알아서 Bean 을 주입해준다.
	private SqlSessionTemplate sqlsession;
	
	/////////////////////////////////////////////////////////////////////////////////////////////////////
	//////소미 DAO//////////////////////////////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////////////////////////////////////////

	// 1. 검색어 없는 강좌리스트 불러오기
	@Override
	public List<LectureVO> lectureApply(HashMap<String, String> pageMap) {
		List<LectureVO> lectureList = sqlsession.selectList("awesomeLecture.lectureApply", pageMap);
		return lectureList; 
	}
	
	// 2. 총 강좌 수 구하기
	@Override
	public int getTotalPage(HashMap<String, String> pageMap) {
		int totalPage = sqlsession.selectOne("awesomeLecture.getTotalPage", pageMap);
		return totalPage;
	}
	
	// 3. 강좌 상세 페이지 정보 가져오기
	@Override
	public LectureVO lectureDetail(String class_seq) {
		LectureVO lecturevo = sqlsession.selectOne("awesomeLecture.lectureDetail", class_seq);
		return lecturevo;
	}

	// 4. 접수날짜 가져오기
	@Override
	public String lectureRegister_term() {
		String register_term = sqlsession.selectOne("awesomeLecture.lectureRegister_term");
		return register_term;
	}

	// 5. 강사 정보 가져오기
	@Override
	public HashMap<String, String> getTeacherInfo(int fk_teacher_seq) {
		HashMap<String, String> teacherMap = sqlsession.selectOne("awesomeLecture.getTeacherInfo", fk_teacher_seq);
		return teacherMap;
	}

	// 6. 강좌스케쥴 정보 가져오기
	@Override
	public List<LectureVO> lectureScheduleJSON(HashMap<String, String> scheduleMap) {
		List<LectureVO> scheduleList = sqlsession.selectList("awesomeLecture.lectureScheduleJSON", scheduleMap);
		return scheduleList;
	}
	////////////1차 합치기/////////////////////////////////////////////////////////////////////////////////
	
	// 7. 좋아요 게시판에 insert 하기
	@Override
	public void likeLecture(HashMap<String, String> likeMap) {
		sqlsession.insert("awesomeLecture.likeLecture", likeMap);
	}
	
	// 8. 좋아요 게시판에서 delete 하기
	@Override
	public void dislikeLecture(HashMap<String, String> likeMap) {
		sqlsession.delete("awesomeLecture.dislikeLecture", likeMap);
	}
	
	// 9. 좋아요 게시판에 있는지 찾아오기
	@Override
	public int checkHeart(HashMap<String, String> likeMap) {
		int n = sqlsession.selectOne("awesomeLecture.checkHeart", likeMap);
		return n;
	}
	
	// 10. 대기자 List에 insert하기 
	@Override
	public void registerWait(HashMap<String, String> waitMap) {
		System.out.println("강좌번호 : " + waitMap.get("class_seq")); 
		sqlsession.insert("awesomeLecture.registerWait", waitMap);
	}
	
	// 11. 해당 강좌에 접수하였는지 알아온다
	@Override
	public int checkWaiting(HashMap<String, String> waitMap) {
		int n = sqlsession.selectOne("awesomeLecture.checkWaiting", waitMap);
		return n;
	}
	
	// 12. 매월 1일 전월의 모든 강의를 접수마감으로 변경
	@Override
	public void closeLecture() {
		sqlsession.update("awesomeLecture.closeLecture");
	}
	
	// 13. 상세페이지에 총 리뷰갯수 가져오기
	@Override
	public int checkReviewNum(String class_seq) {
		int num = sqlsession.selectOne("awesomeLecture.checkReviewNum", class_seq);
		return num;
	}
	
	// 14. 수강후기 가져오기
	@Override
	public List<HashMap<String, String>> getReviewDetail(String class_seq) {
		List<HashMap<String, String>> lectureList = sqlsession.selectList("awesomeLecture.getReviewDetail", class_seq);
		return lectureList;
	}

	// 15. 강좌컬럼하트 insert
	@Override
	public void likeLectureCol(HashMap<String, String> likeMap) {
		sqlsession.update("awesomeLecture.likeLectureCol", likeMap);
	}
	
	// 16. 강좌컬럼하트 delete
	@Override
	public void dislikeLectureCol(HashMap<String, String> likeMap) {
		sqlsession.update("awesomeLecture.dislikeLectureCol", likeMap);
	}
	
	// 17. 회원별 관심강좌 가져오기
	@Override
	public List<String> getLikeCat(String userno) {
		List<String> catList = sqlsession.selectList("awesomeLecture.getLikeCat", userno);
		return catList;
	}
	
	// 18. 인기강사 가져오기
	@Override
	public List<HashMap<String, String>> getGoodTea(List<String> catList) {
		
		HashMap<String, Object> paraMap = new HashMap<String, Object>();
		paraMap.put("catList", catList);		
		
		List<HashMap<String, String>> teacherList = sqlsession.selectList("awesomeLecture.getGoodTea", paraMap);
		return teacherList;
	}

	// 19. 해당 회원이 좋아요한 모든 강좌의 갯수를 불러온다
	@Override
	public int totalLikeCnt(String userno) {
		int totalLikeCnt = sqlsession.selectOne("awesomeLecture.totalLikeCnt", userno);
		return totalLikeCnt;
	}
	
	// 20. 페이징 처리한 좋아요 리스트 불러오기
	@Override
	public List<LectureVO> myLikeLecturesList(HashMap<String, String> likeMap) {
		List<LectureVO> likeList = sqlsession.selectList("awesomeLecture.myLikeLecturesList", likeMap);
		return likeList;
	}
	
	// 21.해당 클래스에 수강중인지 확인
	@Override
	public int checkThisClass(HashMap<String, String> checkMap) {
		int n = sqlsession.selectOne("awesomeLecture.checkThisClass", checkMap);
		return n;
	}
	
	// 22. 첨부파일 없는 글쓰기
	@Override
	public int addPreBoard(PreBoardVO pbvo) {
		int n = sqlsession.insert("awesomeLecture.addPreBoard", pbvo);
		return n;
	}
	
	// 23. 첨부파일 있는 글쓰기
	@Override
	public int addPreBoard_withFile(PreBoardVO pbvo) {
		int n = sqlsession.insert("awesomeLecture.addPreBoard_withFile", pbvo);
		return n;
	}
	
	// 24. 게시판 글 목록 가져오기
	@Override
	public List<PreBoardVO> getPrepareList(HashMap<String, String> pageMap) {
		List<PreBoardVO> preboardList = sqlsession.selectList("awesomeLecture.getPrepareList", pageMap);
		return preboardList;
	}
	
	// 25. 게시판 글 삭제
	@Override
	public int deletePreBoard(String preSeq) {
		int n= sqlsession.update("awesomeLecture.deletePreBoard", preSeq);
		return n;
	}
	
	// 26. 글 상세 가져오기
	@Override
	public PreBoardVO prepareDetail(String preSeq) {
		PreBoardVO preboardvo = sqlsession.selectOne("awesomeLecture.prepareDetail", preSeq);
		return preboardvo;
	}
	
	// 27. 글 수정하기
	@Override
	public void editPre(PreBoardVO preboardvo) {
		sqlsession.update("awesomeLecture.editPre", preboardvo);
	}
	
	// 28. 글 수정하기 (첨부파일)
	@Override
	public void editPre_withFile(PreBoardVO preboardvo) {
		sqlsession.update("awesomeLecture.editPre_withFile", preboardvo);
	}
	
	// 29. 재료준비 게시판 총 페이지 수 구해오기
	@Override
	public int getPretotalPage(HashMap<String, String> pageMap) {
		int preTotalPage = sqlsession.selectOne("awesomeLecture.getPretotalPage", pageMap);
		return preTotalPage;
	}
	
	// 30. 댓글 insert
	@Override
	public int writePreComment(HashMap<String, String> commentMap) {
		int n = sqlsession.insert("awesomeLecture.writePreComment", commentMap);
		return n;
	}
	
	// 31. 댓글 불러오기
	@Override
	public List<PreCommnetVO> getCommentList(HashMap<String, String> commentMap) {
		List<PreCommnetVO> commentList = sqlsession.selectList("awesomeLecture.getCommentList", commentMap);
		return commentList;
	}

	// 32. 게시글 댓글 수 카운트하기
	@Override
	public void preCountComment(HashMap<String, String> commentMap) {
		sqlsession.update("awesomeLecture.preCountComment", commentMap);
	}
	
	// 33. 답글 insert하기
	@Override
	public void writePreReply(HashMap<String, String> commentMap) {
		sqlsession.insert("awesomeLecture.writePreReply", commentMap);
	}
	
	// 34. 비밀글 변경
	@Override
	public void simpleLock(HashMap<String, String> commentMap) {
		sqlsession.update("awesomeLecture.simpleLock", commentMap);
	}

	// 35. 댓글 수정하기
	@Override
	public void editPreReply(HashMap<String, String> commentMap) {
		sqlsession.update("awesomeLecture.editPreReply", commentMap);
	}
	
	// 36. 리댓글 있는 댓글 삭제(status변경)
	@Override
	public void deletePreReply(String preComSeq) {
		sqlsession.update("awesomeLecture.deletePreReply", preComSeq);
	}
	
	// 37. 리댓글 달렸는지 아닌지 확인
	@Override
	public int chkforDel(String preComSeq) {
		int n = sqlsession.selectOne("awesomeLecture.chkforDel", preComSeq);
		return n;
	}
	
	// 38. 리댓글 없는 댓글 삭제(delete)
	@Override
	public void purgePreReply(String preComSeq) {
		sqlsession.delete("awesomeLecture.purgePreReply", preComSeq);
	}
	
	// 39. 해당댓글의 원글 번호 가져오기
	@Override
	public String getOriginNo(String preComSeq) {
		String originno = sqlsession.selectOne("awesomeLecture.getOriginNo", preComSeq);
		return originno;
	}
	
	// 40. 해당 글이 삭제상태인지 확인
	@Override
	public int chkforStat(String originno) {
		int m = sqlsession.selectOne("awesomeLecture.chkforStat", originno);
		return m;
	}
	
	// 41. 댓글 총 갯수 변경
	@Override
	public void reduceReplyCount(String fk_preSeq) {
		sqlsession.update("awesomeLecture.reduceReplyCount", fk_preSeq);
	}
	
	// 42. 대기접수 신청 확인
	@Override
	public int checkWaitingList(HashMap<String, String> waitMap) {
		int m = sqlsession.selectOne("awesomeLecture.checkWaitingList", waitMap);
		return m;
	}
	
	/////////////////////////////////////////////////////////////////////////////////////////////////////
	//////승헌 DAO//////////////////////////////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////////////////////////////////////////

	// 검색 카테고리 가져오기
	@Override
	public List<HashMap<String, String>> getLecCate(String cate_code) {

		List<HashMap<String, String>> cateList = sqlsession.selectList("awesomeLecture.getLecCate", cate_code);

		System.out.println(cateList);
		
		return cateList;
	}
	
	// 검색해서 강좌리스트 뽑아오기
	@Override
	public List<HashMap<String, String>> getSearchList(HashMap<String, String> paramap) {
		
		List<HashMap<String, String>> lecList = sqlsession.selectList("awesomeLecture.getSearchList", paramap);
		
		return lecList;
	}

	// pagination 처리 안 되어진 상품 목록갯수를 가져온다
	@Override
	public int totalCount(HashMap<String, String> paramap) {

		int totalCount = sqlsession.selectOne("awesomeLecture.totalCount", paramap);
		
		return totalCount;
	}
	////////////1차 합치기/////////////////////////////////////////////////////////////////////////////////

	// 회원별 관심카테고리 가져오기(추천강좌)
	@Override
	public List<String> getWishList(String userid) {

		List<String> wishList = sqlsession.selectList("awesomeLecture.getWishList",userid);
		
		return wishList;
	}

	// 카테고리 별 랜덤 강좌 불러오기(추천강좌)
	@Override
	public List<LectureVO> getRandomLec(HashMap<String,Object> wishArr) {

		List<LectureVO> lectureList = sqlsession.selectList("awesomeLecture.getRandomLec", wishArr);
		
		return lectureList;
	}

	// 인기강좌(order by class_heart)
	@Override
	public List<LectureVO> populLec() {

		List<LectureVO> lectureList = sqlsession.selectList("awesomeLecture.populLec");
		
		return lectureList;
	}

	/// >> 차트 << 카테고리 별로 하트 점유율 가져오기
	@Override
	public List<HashMap<String, String>> cate_heart() {
		
		List<HashMap<String, String>> cate_heartList = sqlsession.selectList("awesomeLecture.cate_heart");
		
		return cate_heartList;
	}

	/// >> 차트 << 카테고리 내 인기 강좌 차트 가져오기
	@Override
	public List<HashMap<String, String>> class_heart(String fk_cate_no) {

		List<HashMap<String, String>> class_heartList = sqlsession.selectList("awesomeLecture.class_heart", fk_cate_no);
		
		return class_heartList;
	}

	



}
