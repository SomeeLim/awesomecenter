package com.center.lecture.controller;

import java.io.File;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.util.SystemOutLogger;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.center.lecture.model.LectureVO;
import com.center.lecture.model.PreBoardVO;
import com.center.lecture.model.PreCommnetVO;
import com.center.lecture.service.InterLectureService;
import com.center.member.model.MemberVO;
import com.center.common.MyUtil;
import com.center.common.FileManager;

@Controller
public class LectureController {
	
	@Autowired
	private InterLectureService service;
	
	@Autowired
	private FileManager fileManager;
	
	//////////////////////////////////////////////////////////////////////////////////////////////////

	//////////////////////////////////////////////////////////////////////////////////////////////////
	///////승헌이랑 소미랑 List/////////////////////////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////////////////////////////////////////	
	// 파이널 수강신청 
	@RequestMapping(value="/lectureApply.to") 
	public ModelAndView lectureApply(HttpServletRequest request, ModelAndView mav, LectureVO lvo) {
		
		// pagination에 필요한 정보를 HashMap에 담는다. (1차 검색)
		HashMap<String, String> pageMap = new HashMap<String, String>();
		String currentShowPageNo = request.getParameter("currentShowPageNo");
		String cate_no = request.getParameter("cate_no");
		
		if(lvo.getCate_code()==null)
   			lvo.setCate_code("");   		
   		if(cate_no==null)
   			cate_no = "";
   		if(lvo.getClass_status()==null)
   			lvo.setClass_status("");
   		if(lvo.getClass_semester()==null)
   			lvo.setClass_semester("");
   		if(lvo.getClass_day()==null)
   			lvo.setClass_day("");
   		
		pageMap.put("cate_code", lvo.getCate_code());
		pageMap.put("cate_no",cate_no);
		pageMap.put("class_status", lvo.getClass_status());
		pageMap.put("class_semester", lvo.getClass_semester());
		pageMap.put("class_day", lvo.getClass_day());
	
		String searchType = request.getParameter("searchType");		
		String searchWord = request.getParameter("searchLecWord");
		
		if(searchWord==null || searchWord.trim().isEmpty()) {
			searchWord="";
		}
		
		pageMap.put("searchType", searchType);
		pageMap.put("searchWord", searchWord);
		
		// pagination에 필요한 정보를 HashMap에 담는다. (2차 필터)
		String listfilter = request.getParameter("listfilter");
		
		if("최신등록순".equals(listfilter) || "1".equals(listfilter)) {
			listfilter = "1";
		}
		else if("낮은 가격순".equals(listfilter) || "3".equals(listfilter)) {
			listfilter = "3";	
		}
		else if("높은 가격순".equals(listfilter) || "4".equals(listfilter)) {
			listfilter = "4";
		}
		else if(listfilter == null || "".equals(listfilter)) { 
			listfilter = "1";
		}
		
		pageMap.put("listfilter", listfilter);
		
		
		
		// 총 강좌 수를 구해온다
		int totalPage = service.getTotalPage(pageMap);
		
		if(currentShowPageNo==null) {
		
			currentShowPageNo = "1";
		
		}
		else {
			try {
					int int_currentShowPageNo = Integer.parseInt(currentShowPageNo);
					
					if(int_currentShowPageNo < 1 || int_currentShowPageNo >totalPage) {
						currentShowPageNo = "1";
					}
				
				} catch (NumberFormatException e) {
					currentShowPageNo = "1";
				}
		}
		
		String sizePerPage = "12";
		
		pageMap.put("currentShowPageNo", currentShowPageNo);
		pageMap.put("sizePerPage", sizePerPage);
		
		// pagination 처리되어진 상품 목록을 가져온다
		List<LectureVO> lectureList = service.lectureApply(pageMap);
		
		int pageNo = 1; // 페이지 바에서 보여지는 페이지 번호		
		int blockSize = 10; // 블럭(토막)당 보여지는 페이지 번호의 갯수		
		int loop =1; // 1부터 증가하여 1개 블럭을 이루는 페이지번호의 갯수(지금은 10개)까지만 증가하는 용도
		pageNo = ( (Integer.parseInt(currentShowPageNo)-1)/blockSize )*blockSize +1; // 처음 페이지 NO를 구하는 공식
		
		String pageBar = "";
		
		// 페이지 바 만들기
		
		// *** [맨처음] 만들기 *** //
		pageBar += "<a href='lectureApply.to?cate_code="+lvo.getCate_code()+"&cate_no="+cate_no+"&class_status="+lvo.getClass_status()+"&class_semester="+lvo.getClass_semester()+"&class_day="+lvo.getClass_day()+"&searchType="+searchType+"&searchWord="+searchWord+"&listfilter="+listfilter+"&currentShowPageNo=1'><img class='pagebar-btn' src='resources/images/pagebar-left-double-angle.png' /></a>";
		
		// *** [이전] 만들기 *** //
		if(pageNo!=1) {
			pageBar += "<a href='lectureApply.to?cate_code="+lvo.getCate_code()+"&cate_no="+cate_no+"&class_status="+lvo.getClass_status()+"&class_semester="+lvo.getClass_semester()+"&class_day="+lvo.getClass_day()+"&searchType="+searchType+"&searchWord="+searchWord+"&listfilter="+listfilter+"&currentShowPageNo="+ (pageNo-1) +"'><img class='pagebar-btn' src='resources/images/pagebar-left-angle.png' /></a>";
		}
		else {
			pageBar += "<a href='lectureApply.to?cate_code="+lvo.getCate_code()+"&cate_no="+cate_no+"&class_status="+lvo.getClass_status()+"&class_semester="+lvo.getClass_semester()+"&class_day="+lvo.getClass_day()+"&searchType="+searchType+"&searchWord="+searchWord+"&listfilter="+listfilter+"&currentShowPageNo=1'><img class='pagebar-btn' src='resources/images/pagebar-left-angle.png' /></a>&nbsp;&nbsp;&nbsp;&nbsp;";
		}
		
		// *** [번호] 만들기 *** //
		while(!(loop > blockSize || pageNo>totalPage)) {
		
			if(pageNo == Integer.parseInt(currentShowPageNo)) {
				pageBar += "<a class='pagebar-number' style='font-weight: bold; color: red;'>"+pageNo+"</a>&nbsp;&nbsp;&nbsp;&nbsp;";
			}
			else {
				pageBar += "<a class='pagebar-number' href='lectureApply.to?cate_code="+lvo.getCate_code()+"&cate_no="+cate_no+"&class_status="+lvo.getClass_status()+"&class_semester="+lvo.getClass_semester()+"&class_day="+lvo.getClass_day()+"&searchType="+searchType+"&searchWord="+searchWord+"&listfilter="+listfilter+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a>&nbsp;&nbsp;&nbsp;&nbsp;"; 
			}		
				pageNo++; // 1 2 3 4 5 6 7 8 9 10 11
				loop++;	  // 1 2 3 4 5 6 7 8 9 10 11
			
		}
		
		// *** [다음] 만들기 *** //
		pageBar += "&nbsp;<a href = 'lectureApply.to?cate_code="+lvo.getCate_code()+"&cate_no="+cate_no+"&class_status="+lvo.getClass_status()+"&class_semester="+lvo.getClass_semester()+"&class_day="+lvo.getClass_day()+"&searchType="+searchType+"&searchWord="+searchWord+"&listfilter="+listfilter+"&currentShowPageNo="+ pageNo +"'><img class='pagebar-btn' src='resources/images/pagebar-right-angle.png' /></a>&nbsp;";
		
		// *** [맨마지막] 만들기 *** //
		pageBar += "&nbsp;<a href = 'lectureApply.to?cate_code="+lvo.getCate_code()+"&cate_no="+cate_no+"&class_status="+lvo.getClass_status()+"&class_semester="+lvo.getClass_semester()+"&class_day="+lvo.getClass_day()+"&searchType="+searchType+"&searchWord="+searchWord+"&listfilter="+listfilter+"&currentShowPageNo="+totalPage+"'><img class='pagebar-btn' src='resources/images/pagebar-right-double-angle.png' /></a>&nbsp;";
		
		mav.addObject("lectureList",lectureList);
		mav.addObject("pageBar",pageBar);
		mav.addObject("cate_code", lvo.getCate_code());
		mav.addObject("cate_no",cate_no);
		mav.addObject("class_status", lvo.getClass_status());
		mav.addObject("class_semester", lvo.getClass_semester());
		mav.addObject("class_day", lvo.getClass_day());
		mav.addObject("searchType", searchType);
		mav.addObject("searchWord", searchWord);
		mav.addObject("listfilter", listfilter);
		mav.setViewName("lecture/lectureApply.tiles1");
		
		return mav;
	}

	
	//////////////////////////////////////////////////////////////////////////////////////////////////
	///////소미 controller/////////////////////////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////////////////////////////////////////
	
   	// 강좌 상세 페이지 
   	@RequestMapping(value="/lectureDetail.to")
	public ModelAndView lectureDetail(HttpServletRequest request, ModelAndView mav) {
		
   		String class_seq = request.getParameter("class_seq");
   		
   		if(class_seq == null) {
   			
   			mav.addObject("msg", "해당 강좌는 존재하지 않습니다.");
   			mav.addObject("loc", "javascript:history.back()");
   			
   			mav.setViewName("msg");
   			
   			return mav;
   			
   		}
   		else {
   			
   			try {
		   		// 강좌 상세 페이지 정보 가져오기
   				Integer.parseInt(class_seq);
		   		LectureVO lecturevo = service.lectureDetail(class_seq);   		
		   		mav.addObject("lecturevo", lecturevo);
		   		
		   		if(lecturevo == null) {
		   			
		   			mav.addObject("msg", "해당 강좌는 존재하지 않습니다.");
		   			mav.addObject("loc", "javascript:history.back()");
		   			
		   			mav.setViewName("msg");
		   			
		   			return mav;
		   			
		   		}
		   		else {
		   			// 매월 접수기간 가져오기
			   		String register_term = service.lectureRegister_term();
			   		mav.addObject("register_term", register_term);
			   		
			   		// 강사 정보 가져오기
			   		HashMap<String, String> teacherMap = service.getTeacherInfo(lecturevo.getFk_teacher_seq());
			   		mav.addObject("teacherMap", teacherMap);
			   		
			   		mav.setViewName("lecture/lectureDetail.tiles1");
			   		
					return mav;
		   		}
	   		
   			} catch (NumberFormatException e) {
   				mav.addObject("msg", "해당 강좌는 존재하지 않습니다.");
	   			mav.addObject("loc", "javascript:history.back()");
	   			
	   			mav.setViewName("msg");
	   			
	   			return mav;
			}
		
   		}
	}
   	
   	// 강좌 스케쥴 페이지 
   	@RequestMapping(value="/lectureSchedule.to")
   	public ModelAndView lectureSchedule(HttpServletRequest request, ModelAndView mav) {
   	
   		
   		mav.setViewName("lecture/lectureSchedule.tiles1");
   		
   		return mav;
   	}
   	
   	// 강좌 스케쥴 ajax
   	@ResponseBody
   	@RequestMapping(value="/lectureScheduleJSON.to",  produces="text/plain;charset=UTF-8")
   	public String lectureScheduleJSON(HttpServletRequest request) {
   		
   		String selectedCat = request.getParameter("selectedCat");
   		String selectedDay = request.getParameter("selectedDay");
   		
   		String catNum1 = "1";
   		String catNum2 = "9";

   		if("전체".equals(selectedCat)) {
   			catNum1 = "1";
   	   		catNum2 = "9";
   		}
   		else if("성인강좌".equals(selectedCat)) {
   			catNum1 = "1";
   	   		catNum2 = "6";
   		}
   		else if("아동강좌".equals(selectedCat)) {
   			catNum1 = "7";
   	   		catNum2 = "9";
   		}
   		
   		HashMap<String, String> scheduleMap = new HashMap<String, String>();
   		scheduleMap.put("selectedDay",selectedDay);
   		scheduleMap.put("catNum1",catNum1);
   		scheduleMap.put("catNum2",catNum2);
   		
   		// 해당 조건에 일치하는 강좌 리스트를 불러온다.
   		List<LectureVO> scheduleList = service.lectureScheduleJSON(scheduleMap);
   		
   		JSONArray jsonArr = new JSONArray();
   		
   		for(LectureVO lecvo : scheduleList) {
   			JSONObject jsObj = new JSONObject();
   			jsObj.put("class_seq", lecvo.getClass_seq());
   			jsObj.put("class_title", lecvo.getClass_title());
   			jsObj.put("class_day", lecvo.getClass_day());
   			jsObj.put("class_place", lecvo.getClass_place());
   			jsObj.put("class_time", lecvo.getClass_time());
   			jsonArr.put(jsObj);
   		}
   		
   		return jsonArr.toString(); 
   	} 
   	////////////1차 합치기/////////////////////////////////////////////////////////////////////////////////
   	
   	// 강좌 좋아요 누르기
   	@ResponseBody
   	@RequestMapping(value="/likeLecture.to",  produces="text/plain;charset=UTF-8", method= {RequestMethod.POST})
   	public String likeLecture(HttpServletRequest request, HttpServletResponse response) {
   		
   		// 로그인한 유저의 유저번호 알아오기
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");	
		
		if(loginuser!=null) {
			
			String userno = loginuser.getUserno();
			
			String class_seq = request.getParameter("class_seq");
			
			HashMap<String, String> likeMap = new HashMap<String, String>();
			likeMap.put("userno", userno);
			likeMap.put("class_seq", class_seq);
			
			// 좋아요 게시판에 insert 하기
			service.likeLecture(likeMap);
			
			// 강좌 하트 컬럼에 insert 하기
			service.likeLectureCol(likeMap);
			
			String msg = "내가 좋아하는 강좌는 마이페이지에서 확인하실 수 있습니다.";
			
			JSONObject jsobj = new JSONObject();
			jsobj.put("msg", msg);
			
			return jsobj.toString();
			
		}
		else {
			String login = "먼저 로그인 하세요";
			
			JSONObject jsobj = new JSONObject();
			jsobj.put("login", login);
			
			return jsobj.toString();
		}

   	}
   	
   	// 강좌 좋아요 해제하기
   	@ResponseBody
   	@RequestMapping(value="/dislikeLecture.to",  produces="text/plain;charset=UTF-8", method= {RequestMethod.POST})
   	public String dislikeLecture(HttpServletRequest request, HttpServletResponse response) {

   		// 로그인한 유저의 유저번호 알아오기
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");	
		
		if(loginuser!=null) {
			
			String userno = loginuser.getUserno();
			
			String class_seq = request.getParameter("class_seq");
			
			HashMap<String, String> likeMap = new HashMap<String, String>();
			likeMap.put("userno", userno);
			likeMap.put("class_seq", class_seq);
			
			// 좋아요 게시판에 delete하기
			service.dislikeLecture(likeMap);
			
			// 강좌 컬럼에서 delete하기
			service.dislikeLectureCol(likeMap);
			
			String msg = "강좌 좋아요를 취소하셨습니다.";
			
			JSONObject jsobj = new JSONObject();
			jsobj.put("msg", msg);
			
			return jsobj.toString();
			
		}
		else {
			String login = "로그인 후 이용하실 수 있습니다.";
			
			JSONObject jsobj = new JSONObject();
			jsobj.put("login", login);
			
			return jsobj.toString();
		}
   	}
   	
   	// 좋아요 눌렀는지 안눌렀는지 불러오기
   	@ResponseBody
   	@RequestMapping(value="/checkHeart.to",  produces="text/plain;charset=UTF-8", method= {RequestMethod.POST})
   	public String checkHeart(HttpServletRequest request, HttpServletResponse response) {
   		
   		// 로그인한 유저의 유저번호 알아오기
   		HttpSession session = request.getSession();
   		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
   		
   		if(loginuser!=null) {
   			String userno = loginuser.getUserno();			
			String class_seq = request.getParameter("class_seq");
			
			HashMap<String, String> likeMap = new HashMap<String, String>();
			likeMap.put("userno", userno);
			likeMap.put("class_seq", class_seq);
			
			// 좋아요 게시판에 있는지 찾아오기
			int n = service.checkHeart(likeMap);
			
			JSONObject jsobj = new JSONObject();
			jsobj.put("n", String.valueOf(n));
			
			return jsobj.toString();
			
   		}
   		else {
   			JSONObject jsobj = new JSONObject();
			jsobj.put("n", "0");
			
			return jsobj.toString();
   		}
   		
   	}
   	
   	// 대기자 List에 insert하기 
   	@RequestMapping(value="/registerWait.to",  method= {RequestMethod.POST})
   	public ModelAndView registerWait(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
   		
   		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		if(loginuser == null) { 
			
			mav.addObject("msg", "로그인 후 이용 가능합니다.");
			mav.addObject("loc", "javascript:history.back()");
			mav.setViewName("msg");

		}
		
		else if(loginuser!=null) {
			
			String userno = loginuser.getUserno();   		
	   		String class_seq = request.getParameter("class_seq");
	   		
	   		HashMap<String, String> waitMap = new HashMap<String, String>();
	   		waitMap.put("userno", userno);
	   		waitMap.put("class_seq", class_seq);
			
			// 해당 강좌에 접수하였는지 알아온다
			int n = service.checkWaiting(waitMap);
			
			// 해당 대기접수를 신청했는지 알아온다.
			int m = service.checkWaitingList(waitMap);
			
			// 1. 이미 접수한 강좌를 선택한 경우
			if((n + m) >0) {
				
				mav.addObject("msg", "이미 신청하신 강좌입니다.");
				mav.addObject("loc", "javascript:history.back()");
				mav.setViewName("msg");
				
			}
			// 2. 실제 대기접수를 하는 경우
			else if((n + m) == 0){
				service.registerWait(waitMap);
				
				mav.addObject("msg", "대기접수가 신청되었습니다.");
				mav.addObject("loc", "javascript:history.back()");
				mav.setViewName("msg"); 
				
			}

		}
		return mav;
   	}
   	
   	// 상세페이지에 총 리뷰갯수 가져오기 
   	@ResponseBody
   	@RequestMapping(value="/checkReviewNum.to",  produces="text/plain;charset=UTF-8")
   	public String checkReviewNum(HttpServletRequest request) {
   		
   		String class_seq =  request.getParameter("class_seq");
   		
   		int number = service.checkReviewNum(class_seq);
   		
   		JSONObject jsobj = new JSONObject();
   		jsobj.put("number", number);
   		
   		return jsobj.toString();
   	}
   	
   	// 수강후기 가져오기
   	@ResponseBody
   	@RequestMapping(value="/getReviewDetail.to",  produces="text/plain;charset=UTF-8")
   	public String getReviewDetail(HttpServletRequest request) {
   		
   		String class_seq =  request.getParameter("class_seq");
   		
   		List<HashMap<String, String>> lectureList = service.getReviewDetail(class_seq);
   		
   		JSONArray jsonArr = new JSONArray();
   		
   		for(HashMap<String, String> map : lectureList) {
   			JSONObject jsobj = new JSONObject();
   			jsobj.put("class_seq", map.get("class_seq"));
   			jsobj.put("class_semester", map.get("class_semester"));
   			jsobj.put("class_title", map.get("class_title"));
   			jsobj.put("REVIEWNO", map.get("REVIEWNO"));
   			jsobj.put("SUBJECT", map.get("SUBJECT"));
   			jsobj.put("USERNAME", map.get("USERNAME"));
   			jsobj.put("WDATE", map.get("WDATE"));
   			jsonArr.put(jsobj);
   		}
   		
   		return jsonArr.toString(); 
   	}
   	
   	@RequestMapping(value="/bestTeacherChart1.to")
    public String bestTeacherChart1(HttpServletRequest request) {
   		
   		return "lecture/chartPlease.tiles1";
   	}
   	
   	// 인기강사 차트 가져오기
   	@ResponseBody
    @RequestMapping(value="/bestTeacherChart.to", produces="text/plain;charset=UTF-8")
    public String bestTeacherChart(HttpServletRequest request) {
   		
   		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		JSONArray jsonArr = new JSONArray();
		
		if(loginuser!=null) {
			
			String userno = loginuser.getUserno();   
			
			// 1. 회원별 관심강좌 가져오기
			List<String> catList = service.getLikeCat(userno);
			
			System.out.println(); 
			
			if(catList == null) {
				JSONObject jsobj = new JSONObject();
				jsobj.put("msg", "인기강사 차트는 관심강좌를 선택하셔야 확인하실 수 있습니다.");
			}
			else if(catList != null) {
				// 2. 인기강사 가져오기
				if(!catList.isEmpty()) {
					List<HashMap<String, String>> teacherList = service.getGoodTea(catList);
					
					for(HashMap<String, String> tea : teacherList) {
						JSONObject jsobj = new JSONObject();
						jsobj.put("sum", tea.get("sum"));
						jsobj.put("rate", tea.get("rate"));
						jsobj.put("TEACHER_SEQ", tea.get("TEACHER_SEQ"));
						jsobj.put("TEACHER_NAME", tea.get("TEACHER_NAME"));
						jsobj.put("cate_name", tea.get("cate_name"));
						jsonArr.put(jsobj);
					}
				}
				else {
					JSONObject jsobj = new JSONObject();
					jsobj.put("msg", "인기강사 차트는 관심강좌를 선택하셔야 확인하실 수 있습니다.");
				}
			}
			
		}
   		
   		return jsonArr.toString();
   	}
   	
   	// 좋아요 페이지 불러오기
   	@RequestMapping(value="/myLikeLectures.to")
    public ModelAndView requiredLogin_myLikeLectures(HttpServletRequest request, HttpServletResponse reponse, ModelAndView mav) {
   		
   		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		if(loginuser!=null) {
			
			String userno = loginuser.getUserno();   
			
			// 해당 회원이 좋아요한 모든 강좌의 갯수를 불러온다
			int totalLikeCnt = service.totalLikeCnt(userno);
			
			mav.addObject("totalLikeCnt", totalLikeCnt);
			mav.setViewName("lecture/myLikeLectures.tiles1");
			
		}
   		
   		return mav;
   	}
   	
   	// 좋아요 리스트 불러오기
   	@ResponseBody
    @RequestMapping(value="/myLikeLecturesList.to", produces="text/plain;charset=UTF-8")
    public String myLikeLecturesList(HttpServletRequest request) {
   		
   		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		JSONArray jsonArr = new JSONArray();
		
		if(loginuser!=null) {
			
			String userno = loginuser.getUserno();  
			String start = request.getParameter("start");
			String len = request.getParameter("len");
			String end = String.valueOf(Integer.parseInt(start)+Integer.parseInt(len)-1);
			
			HashMap<String, String> likeMap = new HashMap<String, String>();
			
			likeMap.put("userno", userno);
			likeMap.put("start", start);
			likeMap.put("end", end);
			
			// 페이징 처리한 좋아요 리스트 불러오기
			List<LectureVO> likeList = service.myLikeLecturesList(likeMap);
			
			for(LectureVO vo : likeList) {
				JSONObject jsobj = new JSONObject();
				jsobj.put("CLASS_SEQ", vo.getClass_seq());
				jsobj.put("TEACHER_NAME", vo.getTeacher_name());
				jsobj.put("CLASS_TITLE", vo.getClass_title());
				jsobj.put("CLASS_SEMESTER", vo.getClass_semester());
				jsobj.put("CLASS_FEE", vo.getClass_fee());
				jsobj.put("CLASS_DAY", vo.getClass_day());
				jsobj.put("CLASS_TIME", vo.getClass_time());
				jsobj.put("CLASS_PHOTO", vo.getClass_photo());
				jsobj.put("CLASS_STATUS", vo.getClass_status()); 
				jsobj.put("cate_name", vo.getCate_name());
				jsobj.put("cate_code", vo.getCate_code());
				jsonArr.put(jsobj);
			}
			
		}
		
		return jsonArr.toString();
   		
   	}
   	
   	// 재료준비 게시판
   	@RequestMapping(value="/prepareBoard.to")
    public ModelAndView requiredLogin_prepareBoard(HttpServletRequest request, HttpServletResponse reponse, ModelAndView mav) {
   		
   		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		String class_seq =  request.getParameter("class_seq");
		
		if(loginuser!=null) {
			
			String userno = loginuser.getUserno();  
			
			HashMap<String, String> checkMap = new HashMap<String, String>();
			
			checkMap.put("class_seq", class_seq);
			checkMap.put("userno", userno);
			
			// 해당 클래스에 수강중인지 확인
			int chk = service.checkThisClass(checkMap);
			
			if(chk > 0 || "adminta".equalsIgnoreCase(loginuser.getUserid())){ // 수강중이라면!!
				
				// 해당 강좌 정보 가져오기 (계속 추가)
				LectureVO lecturevo = service.lectureDetail(class_seq);   	
				
				// Pagination
				HashMap<String, String> pageMap = new HashMap<String, String>();
				String currentShowPageNo = request.getParameter("currentShowPageNo");	
				String searchType = request.getParameter("searchType");
				String searchWord = request.getParameter("searchWord");
				
				if(searchType == null || "".equals(searchType)) {
					searchType = "";
				}
				if(searchWord == null || "".equals(searchWord)) {
					searchWord = "";
				}
				
				pageMap.put("class_seq", class_seq);
				pageMap.put("searchType", searchType);
				pageMap.put("searchWord", searchWord);
				
				// 총 강좌수를 가져온다
				int preTotalPage = service.getPretotalPage(pageMap);
				
		   		if(currentShowPageNo == null || "".equals(currentShowPageNo)) {
		   			currentShowPageNo = "1";
		   		}
		   		else {
					try {
							int int_currentShowPageNo = Integer.parseInt(currentShowPageNo);
							
							if(int_currentShowPageNo < 1 || int_currentShowPageNo > preTotalPage) {
								currentShowPageNo = "1";
							}
						
						} catch (NumberFormatException e) {
							currentShowPageNo = "1";
						}
				}
		   		
		   		String sizePerPage = "4";
		   		
		   		pageMap.put("currentShowPageNo", currentShowPageNo);
				pageMap.put("sizePerPage", sizePerPage);
				
				// 게시판 글목록 가져오기
		   		List<PreBoardVO> preboardList = service.getPrepareList(pageMap);
		   		
		   		int pageNo = 1; // 페이지 바에서 보여지는 페이지 번호		
				int blockSize = 5; // 블럭(토막)당 보여지는 페이지 번호의 갯수		
				int loop =1; // 1부터 증가하여 1개 블럭을 이루는 페이지번호의 갯수(지금은 10개)까지만 증가하는 용도
				pageNo = ( (Integer.parseInt(currentShowPageNo)-1)/blockSize )*blockSize +1; // 처음 페이지 NO를 구하는 공식
				preTotalPage = (int) Math.ceil( (double)preTotalPage/blockSize );
				String pageBar = "";
				
				// 페이지 바 만들기
				
				// *** [맨처음] 만들기 *** //
				pageBar += "<a href='prepareBoard.to?class_seq="+class_seq+"&currentShowPageNo=1&searchType="+searchType+"&searchWord="+searchWord+"'><img class='pagebar-btn' src='resources/images/pagebar-left-double-angle.png' style='width: 47px; height: 38px;' /></a>";
				
				// *** [이전] 만들기 *** //
				if(pageNo!=1) {
					pageBar += "<a href='prepareBoard.to?class_seq="+class_seq+"&currentShowPageNo="+ (pageNo-1) +"&searchType="+searchType+"&searchWord="+searchWord+"'><img class='pagebar-btn' src='resources/images/pagebar-left-angle.png' style='width: 47px; height: 38px;' /></a>";
				}
				else {
					pageBar += "<a href='prepareBoard.to?class_seq="+class_seq+"&currentShowPageNo=1&searchType="+searchType+"&searchWord="+searchWord+"'><img class='pagebar-btn' src='resources/images/pagebar-left-angle.png' style='width: 47px; height: 38px;' /></a>&nbsp;&nbsp;&nbsp;&nbsp;";
				}
				
				// *** [번호] 만들기 *** //
				while(!(loop > blockSize || pageNo>preTotalPage)) {
				
					if(pageNo == Integer.parseInt(currentShowPageNo)) {
						pageBar += "<a class='pagebar-number' style='color:rgb(220,61,61); font-weight:bold;'>"+pageNo+"</a>&nbsp;&nbsp;&nbsp;&nbsp;";
					}
					else {
						pageBar += "<a class='pagebar-number' href='prepareBoard.to?class_seq="+class_seq+"&currentShowPageNo="+pageNo+"&searchType="+searchType+"&searchWord="+searchWord+"'>"+pageNo+"</a>&nbsp;&nbsp;&nbsp;&nbsp;"; 
					}		
						pageNo++; // 1 2 3 4 5 6 7 8 9 10 11
						loop++;	  // 1 2 3 4 5 6 7 8 9 10 11
					
				}
				
				// *** [다음] 만들기 *** //
				pageBar += "&nbsp;<a href = 'prepareBoard.to?class_seq="+class_seq+"&currentShowPageNo="+ pageNo +"&searchType="+searchType+"&searchWord="+searchWord+"'><img class='pagebar-btn' src='resources/images/pagebar-right-angle.png' style='width: 47px; height: 38px;' /></a>&nbsp;";
				
				// *** [맨마지막] 만들기 *** //
				pageBar += "&nbsp;<a href = 'prepareBoard.to?class_seq="+class_seq+"&currentShowPageNo="+preTotalPage+"&searchType="+searchType+"&searchWord="+searchWord+"'><img class='pagebar-btn' src='resources/images/pagebar-right-double-angle.png' style='width: 47px; height: 38px;' /></a>&nbsp;";
		   		
				
				mav.addObject("lecturevo", lecturevo);
				mav.addObject("preboardList", preboardList);
				mav.addObject("pageBar", pageBar);
				mav.addObject("searchType", searchType);
				mav.addObject("searchWord", searchWord);
				
				mav.setViewName("lecture/prepareBoard/prepareBoard.tiles1");
				
				return mav;
				
			}
			else if(chk == 0) { // 수강중이 아니라면?
				
				mav.addObject("msg", "해당 수강생만 확인하실 수 있습니다.");
				mav.addObject("loc", "javascript:history.back()");
				
				mav.setViewName("msg");
				
				return mav;
								 
			}
			
		}
   		
		return mav;
   		
   	}
   	
   	// 재료준비 게시판 글쓰기
   	@RequestMapping(value="/writePrepare.to")
    public ModelAndView requiredLogin_writePrepare(HttpServletRequest request, HttpServletResponse reponse, ModelAndView mav) {
   		
   		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		String class_seq =  request.getParameter("class_seq");
		
		if(loginuser!=null && "adminta".equalsIgnoreCase(loginuser.getUserid())) {
			
			// 해당 강좌 정보 가져오기 (계속 추가)
			LectureVO lecturevo = service.lectureDetail(class_seq);   		
	   		
			
			mav.addObject("lecturevo", lecturevo);
		
			mav.setViewName("lecture/prepareBoard/writePrepare.tiles1");
			
			return mav;
		}
		else {
			mav.addObject("msg", "일반 수강생은 접근할 수 없습니다.");
			mav.addObject("loc", "javascript:history.back()");
			
			mav.setViewName("msg");
			
			return mav;
		} 
		
   		
   	}
   	
   	// 재료준비 게시판 글쓰기 완료
    @RequestMapping(value="/writePrepareEnd.to", method= {RequestMethod.POST})
 	public String addEnd(PreBoardVO pbvo, MultipartHttpServletRequest mrequest) {	
    	

		// ========= !!첨부파일이 있는지 없는지 알아오기 시작!! =========    	   	
 		MultipartFile attach = pbvo.getAttach();
 	   // VO그대로 가져오면 getParameter할 필요없이 그대로 다 데려온다.
 		if(!attach.isEmpty()) {
 			// attach가 비어있지 않다면... (첨부파일이 있는 경우)
 			
 			/*  사용자가 보낸 파일을 WAS(톰캣)의 특정 폴더에 저장해 주어야 한다.
 			 *  >> 파일이 업로드 되어질 특정 경로(지정해주기)
 			 *     우리는 WAS의 webapp/resources/files라는 폴더로 지정해 준다.
 			 */
 			// WAS의 webapp의 절대경로를 알아와야 한다.
 			HttpSession session = mrequest.getSession();
 		 	String root = session.getServletContext().getRealPath("/");
 		 	String path = root + "resources" + File.separator + "files";
 		 	// File.separator 는 운영체제에서 사용하는 폴더와 파일의 구분자이다.
 		 	// 운영체제가 Windows 이라면 File.separator 은 "\" 이고,
 		    // 운영체제가 UNIX, Linux 이라면 File.separator 은 "/" 이다.
 		 	
 		 	// path 가 첨부파일을 저장할 WAS(톰캣)의 폴더가 된다.
 		 	System.out.println(">>> 확인용 path ==>" + path);
 			// >>> 확인용 path ==>C:\springworkspace\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Board\resources\files 
 		 	
 		 	// == 2. 파일 첨부를 위한 변수의 설정 및 값을 초기화 한 후 파일 올리기 ==
 		 	String newFileName = "";
 		 	// WAS(톰캣)의 디스크에 저장될 파일명
 		 	
 		 	byte[] bytes = null;
 		 	// 첨부파일을 WAS(톰캣)의 디스크에 저장할때 사용되는 용도
 		 	
 		 	long fileSize = 0;
 		 	// 파일크기를 읽어오기 위한 용도 
 		 	
 		 	try {
 				bytes = attach.getBytes();
 				// getBytes() 메소드는 첨부된 파일을 바이트단위로 파일을 다 읽어오는 것이다. 
 				// 예를 들어, 첨부한 파일이 "강아지.png" 이라면
 				// 이파일을 WAS(톰캣) 디스크에 저장시키기 위해 byte[] 타입으로 변경해서 올린다.
 				
 				newFileName = fileManager.doFileUpload(bytes, attach.getOriginalFilename(), path);
 				// 이제 파일올리기를 한다.
 				// attach.getOriginalFilename() 은 첨부된 파일의 파일명(강아지.png)이다.
 				
 				System.out.println(">>> 확인용 newFileName ==> " + newFileName); 
 				// >>> 확인용 newFileName ==> 201907251244341722885843352000.jpg 
 				
 				// == 3. BoardVO boardvo 에 fileName 값과 orgFilename 값과  fileSize 값을 넣어주기 
 				pbvo.setPreFileName(newFileName);
 				// WAS(톰캣)에 저장된 파일명(201907251244341722885843352000.jpg)
 				
 				pbvo.setPreOrgFilename(attach.getOriginalFilename());
 				// 게시판 페이지에서 첨부된 파일의 파일명(강아지.png)을 보여줄때 및  
 				// 사용자가 파일을 다운로드 할때 사용되어지는 파일명
 				
 				fileSize = attach.getSize();
 				pbvo.setPreFileSize(String.valueOf(fileSize));
 				// 게시판 페이지에서 첨부한 파일의 크기를 보여줄때 String 타입으로 변경해서 저장함.
 				
 			} catch (Exception e) {
 				e.printStackTrace();
 			}
 		}
 		
 		/*	========= !!첨부파일이 있는지 없는지 알아오기 끝!! ========= */ 
 	   
 	   // *** 크로스 사이트 스크립트 공격에 대응하는 안전한 코드(시큐어 코드)작성하기 ***
 	   pbvo.setPreTitle(MyUtil.replaceParameter(pbvo.getPreTitle()));
 	   pbvo.setPreContent(MyUtil.replaceParameter(pbvo.getPreContent()));
 	   pbvo.setPreContent(pbvo.getPreContent().replaceAll("\r\n", "<br/>"));
 	   
 	   // int n = service.add(boardvo);
 	   //  === #143. 파일첨부가 있는 경우와 없는 경우에 따라서 Service단 호출하기 === 
 	   //      먼저 위의 	int n = service.add(boardvo); 부분을 주석처리하고서 아래처럼 한다.
 		
 		int n = 0;
 		if(attach.isEmpty()) {
 			// 첨부파일이 없는 경우이라면
 			n = service.addPreBoard(pbvo); 
 		}
 		else {
 			// 첨부파일이 있는 경우이라면
 			n = service.addPreBoard_withFile(pbvo);
 		}
 	   
 		// mav.addObject("n" , n);
 	   mrequest.setAttribute("n", n);
 	   mrequest.setAttribute("class_seq", pbvo.getFk_class_seq());
 	   // mav.setViewName("board/addEnd.tiles1");
 	   return "lecture/prepareBoard/writePrepareEnd.tiles1";
    }
   	
   	// 재료준비 게시판 글보기
   	@RequestMapping(value="/showPreContents.to")
    public ModelAndView requiredLogin_showPreContents(HttpServletRequest request, HttpServletResponse reponse, ModelAndView mav) {
   		
   		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		String class_seq =  request.getParameter("class_seq");
		String preSeq =  request.getParameter("preSeq");
		
		if(loginuser!=null) {
			
			String userno = loginuser.getUserno();  
			
			HashMap<String, String> checkMap = new HashMap<String, String>();
			
			checkMap.put("class_seq", class_seq);
			checkMap.put("preSeq", preSeq);
			checkMap.put("userno", userno);
			
			// 해당 클래스에 수강중인지 확인
			int chk = service.checkThisClass(checkMap);
			
			if(chk > 0 || "adminta".equalsIgnoreCase(loginuser.getUserid())){ // 수강중이라면!!
				
				// 해당 강좌 정보 가져오기
				LectureVO lecturevo = service.lectureDetail(class_seq);   		
				// 해당 글 내용 가져오기
				PreBoardVO preboardvo = service.prepareDetail(preSeq);
				// 해당 글의 댓글 가져오기
				List<PreCommnetVO> commentList = service.getCommentList(checkMap);
				
				mav.addObject("lecturevo", lecturevo);
				mav.addObject("preboardvo", preboardvo);
				mav.addObject("commentList", commentList);
				
				mav.setViewName("lecture/prepareBoard/showPreContents.tiles1");
				
				return mav;
				
			}
			else if(chk == 0) { // 수강중이 아니라면?
				
				mav.addObject("msg", "해당 수강생만 확인하실 수 있습니다.");
				mav.addObject("loc", "javascript:history.back()");
				
				mav.setViewName("msg");
				
				return mav;
								 
			}
			
		}
   		
		return mav;
		
   	}
   	
   	// 재료게시판 글 삭제
   	@ResponseBody
    @RequestMapping(value="/deletePreBoard.to", produces="text/plain;charset=UTF-8")
    public String requiredLogin_deletePreBoard(HttpServletRequest request, HttpServletResponse response, @RequestParam(value="deleteWrite[]")String[] deleteWrite) {
   		
   		for(int i=0;i<deleteWrite.length;i++) {
   			service.deletePreBoard(deleteWrite[i]);
		}
   		
   		JSONObject jsobj = new JSONObject();
		
   		jsobj.put("msg", "글이 삭제되었습니다.");
		
		return jsobj.toString();

   	}
   	
   	// 이미지 팝업
   	@RequestMapping(value="/imgPopUP.to")
   	public ModelAndView imgPopUP(HttpServletRequest request, ModelAndView  mav) {
   		
   		String preFileName = request.getParameter("preFileName");
   		
   		mav.addObject("preFileName", preFileName);
   		mav.setViewName("lecture/prepareBoard/imgPopUP.tiles1");
   		
   		return mav;
   	}
   	
   	// 글 수정하기
   	@RequestMapping(value="/editPre.to")
   	public ModelAndView requiredLogin_editPre(HttpServletRequest request, HttpServletResponse response, ModelAndView  mav) {

   		// 수정할 글 내용 & 파일첨부 가져오기   		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		String class_seq =  request.getParameter("class_seq");
		String preSeq =  request.getParameter("preSeq");
		
		if(loginuser!=null && "adminta".equalsIgnoreCase(loginuser.getUserid())) {
			
			// 해당 강좌 정보 가져오기 (계속 추가)
			// 해당 강좌 정보 가져오기
			LectureVO lecturevo = service.lectureDetail(class_seq);   		
			// 해당 글 내용 가져오기
			PreBoardVO preboardvo = service.prepareDetail(preSeq);  		
		
			mav.addObject("lecturevo", lecturevo);
			mav.addObject("preboardvo", preboardvo);
			mav.setViewName("lecture/prepareBoard/editPre.tiles1");
			
			return mav;
		}
		else {
			mav.addObject("msg", "일반 수강생은 접근할 수 없습니다.");
			mav.addObject("loc", "javascript:history.back()");
			
			mav.setViewName("msg");
			
			return mav;
		} 
   	}
   	
   	// 글 수정완료
   	@RequestMapping(value="/editPreEnd.to")
   	public ModelAndView requiredLogin_editPreEnd(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, PreBoardVO preboardvo,  MultipartHttpServletRequest mrequest) {
   		
   		// ========= !!첨부파일이 있는지 없는지 알아오기 시작!! =========    	   	
 		MultipartFile attach = preboardvo.getAttach();
 	   // VO그대로 가져오면 getParameter할 필요없이 그대로 다 데려온다.
 		if(!attach.isEmpty()) {
 			// attach가 비어있지 않다면... (첨부파일이 있는 경우)
 			
 			/*  사용자가 보낸 파일을 WAS(톰캣)의 특정 폴더에 저장해 주어야 한다.
 			 *  >> 파일이 업로드 되어질 특정 경로(지정해주기)
 			 *     우리는 WAS의 webapp/resources/files라는 폴더로 지정해 준다.
 			 */
 			// WAS의 webapp의 절대경로를 알아와야 한다.
 			HttpSession session = mrequest.getSession();
 		 	String root = session.getServletContext().getRealPath("/");
 		 	String path = root + "resources" + File.separator + "files";
 		 	// File.separator 는 운영체제에서 사용하는 폴더와 파일의 구분자이다.
 		 	// 운영체제가 Windows 이라면 File.separator 은 "\" 이고,
 		    // 운영체제가 UNIX, Linux 이라면 File.separator 은 "/" 이다.
 		 	
 		 	// path 가 첨부파일을 저장할 WAS(톰캣)의 폴더가 된다.
 		 	System.out.println(">>> 확인용 path ==>" + path);
 			// >>> 확인용 path ==>C:\springworkspace\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Board\resources\files 
 		 	
 		 	// == 2. 파일 첨부를 위한 변수의 설정 및 값을 초기화 한 후 파일 올리기 ==
 		 	String newFileName = "";
 		 	// WAS(톰캣)의 디스크에 저장될 파일명
 		 	
 		 	byte[] bytes = null;
 		 	// 첨부파일을 WAS(톰캣)의 디스크에 저장할때 사용되는 용도
 		 	
 		 	long fileSize = 0;
 		 	// 파일크기를 읽어오기 위한 용도 
 		 	
 		 	try {
 				bytes = attach.getBytes();
 				// getBytes() 메소드는 첨부된 파일을 바이트단위로 파일을 다 읽어오는 것이다. 
 				// 예를 들어, 첨부한 파일이 "강아지.png" 이라면
 				// 이파일을 WAS(톰캣) 디스크에 저장시키기 위해 byte[] 타입으로 변경해서 올린다.
 				
 				newFileName = fileManager.doFileUpload(bytes, attach.getOriginalFilename(), path);
 				// 이제 파일올리기를 한다.
 				// attach.getOriginalFilename() 은 첨부된 파일의 파일명(강아지.png)이다.
 				
 				System.out.println(">>> 확인용 newFileName ==> " + newFileName); 
 				// >>> 확인용 newFileName ==> 201907251244341722885843352000.jpg 
 				
 				// == 3. BoardVO boardvo 에 fileName 값과 orgFilename 값과  fileSize 값을 넣어주기 
 				preboardvo.setPreFileName(newFileName);
 				// WAS(톰캣)에 저장된 파일명(201907251244341722885843352000.jpg)
 				
 				preboardvo.setPreOrgFilename(attach.getOriginalFilename());
 				// 게시판 페이지에서 첨부된 파일의 파일명(강아지.png)을 보여줄때 및  
 				// 사용자가 파일을 다운로드 할때 사용되어지는 파일명
 				
 				fileSize = attach.getSize();
 				preboardvo.setPreFileSize(String.valueOf(fileSize));
 				// 게시판 페이지에서 첨부한 파일의 크기를 보여줄때 String 타입으로 변경해서 저장함.
 				
 			} catch (Exception e) {
 				e.printStackTrace();
 			}
 		}
   		
   		
   	   // *** 크로스 사이트 스크립트 공격에 대응하는 안전한 코드(시큐어 코드)작성하기 ***
   	   preboardvo.setPreTitle(MyUtil.replaceParameter(preboardvo.getPreTitle()));
   	   preboardvo.setPreContent(MyUtil.replaceParameter(preboardvo.getPreContent()));
   	   preboardvo.setPreContent(preboardvo.getPreContent().replaceAll("\r\n", "<br/>"));
 	   
   	   // 글 수정하기
   	   if(attach.isEmpty()) {
			// 첨부파일이 없는 경우이라면
   		   service.editPre(preboardvo); 
		}
		else {
			// 첨부파일이 있는 경우이라면
			service.editPre_withFile(preboardvo);
		}
 	   
 	   
 	   mav.addObject("msg", "글이 수정되었습니다.");
 	   mav.addObject("loc", request.getContextPath() +"/showPreContents.to?class_seq="+preboardvo.getFk_class_seq()+"&preSeq="+preboardvo.getPreSeq());
 	   mav.setViewName("msg");
   		
   		return mav;
   	}
   	
   	
	// 게시판 댓글 작성
   	@ResponseBody
    @RequestMapping(value="/writePreComment.to", produces="text/plain;charset=UTF-8")
    public String requiredLogin_writePreComment(HttpServletRequest request, HttpServletResponse response) {
   		
   		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		String userno = loginuser.getUserno();
   		String fk_class_seq = request.getParameter("fk_class_seq");
   		String fk_preSeq = request.getParameter("fk_preSeq");
   		String preComContent = request.getParameter("preComContent");
   		String secret = request.getParameter("secret");
   		
   	   // *** 크로스 사이트 스크립트 공격에 대응하는 안전한 코드(시큐어 코드)작성하기 ***
   	   preComContent = MyUtil.replaceParameter(preComContent);
   	   preComContent = preComContent.replaceAll("\r\n", "<br/>");
   		
   		HashMap<String, String> commentMap = new HashMap<String, String>();
   		commentMap.put("userno", userno);
   		commentMap.put("fk_class_seq", fk_class_seq);
   		commentMap.put("fk_preSeq", fk_preSeq);
   		commentMap.put("preComContent", preComContent);
   		commentMap.put("secret", secret);
   		
   		// 댓글 insert하기
   		int n = service.writePreComment(commentMap);
   		
   		// 게시글 댓글 수 카운트하기
   		service.preCountComment(commentMap);
   		
   		
   		JSONObject jsobj = new JSONObject();
   		jsobj.put("msg", "");
   		
   		return jsobj.toString();
   	}
   	
   	// 게시판 답댓글 작성
   	@ResponseBody
    @RequestMapping(value="/writePreReply.to", produces="text/plain;charset=UTF-8")
    public String requiredLogin_writePreReply(HttpServletRequest request, HttpServletResponse response) {
   		
   		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		String userno = loginuser.getUserno();
   		String fk_class_seq = request.getParameter("fk_class_seq");
   		String fk_preSeq = request.getParameter("fk_preSeq");
   		String preComContent = request.getParameter("preComContent");
   		String secret = request.getParameter("secret");
   		String preComGroupno = request.getParameter("preComGroupno");
   		String fk_preComseq = request.getParameter("fk_preComseq");
   		String preComdepthno = request.getParameter("preComdepthno");
   		String preComSeq = request.getParameter("preComSeq");
   		
   		preComContent = MyUtil.replaceParameter(preComContent);
    	preComContent = preComContent.replaceAll("\r\n", "<br/>");
   		
   		HashMap<String, String> commentMap = new HashMap<String, String>();
   		commentMap.put("userno", userno);
   		commentMap.put("fk_class_seq", fk_class_seq);
   		commentMap.put("fk_preSeq", fk_preSeq);
   		commentMap.put("preComContent", preComContent);
   		commentMap.put("secret", secret);
   		commentMap.put("preComGroupno", preComGroupno);
   		commentMap.put("fk_preComseq", fk_preComseq);
   		commentMap.put("preComdepthno", preComdepthno);
   		commentMap.put("preComSeq", preComSeq);
   		
   		// 답글 insert하기
   		service.writePreReply(commentMap);
   		
   		// 게시글 댓글 수 카운트하기
   		service.preCountComment(commentMap); 
   		
   		JSONObject jsobj = new JSONObject();
   		jsobj.put("msg", "");
   		
   		return jsobj.toString();
   	}
   	
   	// 비밀글 변경
   	@ResponseBody
    @RequestMapping(value="/simpleLock.to", produces="text/plain;charset=UTF-8")
    public String requiredLogin_simpleLock(HttpServletRequest request, HttpServletResponse response) {
   		
   		String fk_class_seq = request.getParameter("fk_class_seq");
   		String fk_preSeq = request.getParameter("fk_preSeq");
   		String preComSeq = request.getParameter("preComSeq");
   		String preComSecret = request.getParameter("secret");
   		
   		if("1".equalsIgnoreCase(preComSecret)) {
   			preComSecret = "0";
   		}
   		else if("0".equalsIgnoreCase(preComSecret)) {
   			preComSecret = "1";
   		}
   		
   		HashMap<String, String> commentMap = new HashMap<String, String>();
   		
   		commentMap.put("fk_class_seq", fk_class_seq);
   		commentMap.put("fk_preSeq", fk_preSeq);
   		commentMap.put("preComSeq", preComSeq);
   		commentMap.put("preComSecret", preComSecret);

   		// 비밀글 상태 변경
   		service.simpleLock(commentMap);
   		
   		JSONObject jsobj = new JSONObject();
   		jsobj.put("msg", "");
   		
   		return jsobj.toString();
   	}
   	
   	// 댓글 수정
   	@ResponseBody
    @RequestMapping(value="/editPreReply.to", produces="text/plain;charset=UTF-8")
    public String requiredLogin_editPreReply(HttpServletRequest request, HttpServletResponse response) {
   		
   		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		String userno = loginuser.getUserno();
   		String fk_class_seq = request.getParameter("fk_class_seq");
   		String fk_preSeq = request.getParameter("fk_preSeq");
   		String preComContent = request.getParameter("preComContent");
   		String preComSecret = request.getParameter("secret");
   		String preComGroupno = request.getParameter("preComGroupno");
   		String fk_preComseq = request.getParameter("fk_preComseq");
   		String preComdepthno = request.getParameter("preComdepthno");
   		String preComSeq = request.getParameter("preComSeq");
   		
   		preComContent = MyUtil.replaceParameter(preComContent);
    	preComContent = preComContent.replaceAll("\r\n", "<br/>");
   		
   		HashMap<String, String> commentMap = new HashMap<String, String>();
   		commentMap.put("userno", userno);
   		commentMap.put("fk_class_seq", fk_class_seq);
   		commentMap.put("fk_preSeq", fk_preSeq);
   		commentMap.put("preComContent", preComContent);
   		commentMap.put("preComSecret", preComSecret);
   		commentMap.put("preComGroupno", preComGroupno);
   		commentMap.put("fk_preComseq", fk_preComseq);
   		commentMap.put("preComdepthno", preComdepthno);
   		commentMap.put("preComSeq", preComSeq);
   		
   		// 댓글 수정하기
   		service.editPreReply(commentMap);
   		
   		JSONObject jsobj = new JSONObject();
   		jsobj.put("msg", "");
   		
   		return jsobj.toString();
   		
   	}
   	
   	// 댓글 삭제
   	@ResponseBody
    @RequestMapping(value="/deletePreReply.to", produces="text/plain;charset=UTF-8")
    public String requiredLogin_deletePreReply(HttpServletRequest request, HttpServletResponse response) {
   		
   		String preComSeq = request.getParameter("preComSeq");
   		String preComdepthno = request.getParameter("preComdepthno");
   		String fk_preSeq = request.getParameter("preSeq");
   		
   		if("0".equals(preComdepthno)) {
	   		// 1. 원글 삭제
	   		// 리댓글 달렸는지 아닌지 확인
	   		int n = service.chkforDel(preComSeq);
	   		
	   		// 리댓글 없는 댓글 삭제(delete)
	   		if(n==0) {
	   			service.purgePreReply(preComSeq);
	   		}
	   		
	   		// 리댓글 있는 댓글 삭제(status변경)
	   		else if(n>=1) {
	   			service.deletePreReply(preComSeq);
	   		}
   		}
   		
   		// 2. 댓글 삭제
   		else if("1".equals(preComdepthno)) {
   			// 해당댓글의 원글 번호 가져오기
   			String originno = service.getOriginNo(preComSeq);
   			
   			// 해당댓글 삭제
   			service.purgePreReply(preComSeq);
   			
   			// 해당댓글의 원댓글에 리댓글이 남아있는지 확인
   			int n = service.chkforDel(originno);
   			// 해당 글이 삭제상태인지 확인
   			int m = service.chkforStat(originno);
   			
   			// 리댓글 없는 원글 삭제
   			if(n+m == 0) {
   				service.purgePreReply(originno);
   			}
   		}
   		
   		// 댓글 총 갯수 변경
   		service.reduceReplyCount(fk_preSeq);
   		
   		JSONObject jsobj = new JSONObject();
   		jsobj.put("msg", "");
   		
   		return jsobj.toString();
   	}
   	
   	

   	
   	/////////////////////////////////////////////////////////////////////////////////////////////////////
   	//////승헌님의 controller//////////////////////////////////////////////////////////////////////////////
   	////////////////////////////////////////////////////////////////////////////////////////////////////
   	
   	// 검색 카테고리 가져오기
   	@ResponseBody
   	@RequestMapping(value="/getLecCate.to", produces = "text/plain;charset=UTF-8")
   	public String getLecCate(String cate_code) {
   		
   		List<HashMap<String, String>> cateList = service.getLecCate(cate_code);
   		
   		JSONArray jsonArr = new JSONArray();
   		
   		for(HashMap<String, String> map : cateList) {
   			
   			JSONObject jsobj = new JSONObject();
   			
   			jsobj.put("cate_no", map.get("cate_no"));
   			jsobj.put("cate_name", map.get("cate_name"));
   			jsobj.put("cate_code", map.get("cate_code"));
   			
   			jsonArr.put(jsobj);
   		}
   		
   		return jsonArr.toString();
   	}
   	
   	
   	// 수강 강좌 검색 페이지
   	@RequestMapping(value="/searchLec.to") 
   	public String searchLec(HttpServletRequest request) {
   	/*	
   		HashMap<String, String> paramap = new HashMap<String, String>();
   		
   		List<HashMap<String, String>> lecList = service.getSearchList(paramap);
   		
   		request.setAttribute("lecList", lecList);
   	*/	
   		return "lecture/search.tiles1";
   	}
   	
   	// 찐 검색 페이지
   	@RequestMapping(value="search.to", method = {RequestMethod.POST}, produces = "text/plain;charset=UTF-8") 
   	public ModelAndView search(HttpServletRequest request, ModelAndView mav, String searchWord) {
   		
   		HashMap<String, String> paramap = new HashMap<String, String>();
   		
   		String reSearch = request.getParameter("reSearch");
   		String searchWord2 = request.getParameter("searchWord2");
   		
   		paramap.put("searchWord", searchWord);
   		paramap.put("searchWord2", searchWord2);
   		paramap.put("research", reSearch);
   		
   		String currentShowPageNo = request.getParameter("currentShowPageNo");
   		
   		if(currentShowPageNo == null) {
			currentShowPageNo = "1";
		}
   		
		int sizePerPage = 10;
		
		int firstPage = (Integer.parseInt(currentShowPageNo) * sizePerPage) - (sizePerPage-1);

		int lastPage = (Integer.parseInt(currentShowPageNo) * sizePerPage);

		
		paramap.put("firstPage", String.valueOf(firstPage));
		paramap.put("lastPage", String.valueOf(lastPage));
   		
   		// pagination 처리되어진 상품 목록을 가져온다
		List<HashMap<String, String>> lecList = service.getSearchList(paramap);
   		
		// pagination 처리 안 되어진 상품 목록갯수를 가져온다
		int totalCount = service.totalCount(paramap);
		
   		// 총 강좌 수를 구해온다
   		int totalPage = (int) Math.ceil((double)totalCount/sizePerPage);
   		int pageNo = 1; // 페이지 바에서 보여지는 페이지 번호		
		int blockSize = 10; // 블럭(토막)당 보여지는 페이지 번호의 갯수		
		int loop = 1; // 1부터 증가하여 1개 블럭을 이루는 페이지번호의 갯수(지금은 10개)까지만 증가하는 용도
		pageNo = ( (Integer.parseInt(currentShowPageNo)-1)/blockSize )*blockSize +1; // 처음 페이지 NO를 구하는 공식

		String pageBar = "";
		
		// 페이지 바 만들기
   		
		// *** [맨처음] 만들기 *** //
		pageBar += "<a><img class='pagebar-btn' src='resources/images/pagebar-left-double-angle.png' /><span>1</span></a>";
		
		// *** [이전] 만들기 *** //
		if(pageNo!=1) {
			pageBar += "<a><img class='pagebar-btn' src='resources/images/pagebar-left-angle.png' /><span>"+(pageNo-1)+"</span></a>";
		}
		else {
			pageBar += "<a><img class='pagebar-btn' src='resources/images/pagebar-left-angle.png' /><span>1</span></a>&nbsp;&nbsp;&nbsp;&nbsp;";
		}
		// *** [번호] 만들기 *** //
		while(!(loop > blockSize || pageNo>totalPage)) {
			
			if(pageNo == Integer.parseInt(currentShowPageNo)) {
				pageBar += "<a class='pagebar-number action'>"+pageNo+"</a>&nbsp;&nbsp;&nbsp;&nbsp;";

			}
			else {
				pageBar += "<a class='pagebar-number'>"+pageNo+"</a>&nbsp;&nbsp;&nbsp;&nbsp;"; 
			}		
			
			pageNo++; 
			loop++;	  

		}
		
		// *** [다음] 만들기 *** //
		if(pageNo>totalPage) {
			pageBar += "&nbsp;<a><img class='pagebar-btn' src='resources/images/pagebar-right-angle.png' /><span>"+totalPage+"</span></a>&nbsp;";
		}
		else {
			pageBar += "&nbsp;<a><img class='pagebar-btn' src='resources/images/pagebar-right-angle.png' /><span>"+pageNo+"</span></a>&nbsp;";
		}
		// *** [맨마지막] 만들기 *** //
		pageBar += "&nbsp;<a><img class='pagebar-btn' src='resources/images/pagebar-right-double-angle.png' /><span>"+totalPage+"</span></a>&nbsp;";
   		
   		
		System.out.println("lecList"+lecList.size());
   		mav.addObject("lecList", lecList);
   		
   		mav.addObject("paramap", paramap);
   		
   		mav.addObject("pageBar", pageBar);
   		
   		mav.addObject("totalCount", totalCount);
   		mav.addObject("totalPage", totalPage);
   		
   		mav.setViewName("lecture/search.tiles1");
   		
   		return mav;
   	}
   	
   	////////////1차 합치기/////////////////////////////////////////////////////////////////////////////////

   	// 추천강좌 페이지
   	@RequestMapping(value="recomLec.to")
   	public String recomLec(HttpServletRequest request) {
   		
   		HttpSession session = request.getSession();
   		
   		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
   		
   		// 회원별 관심카테고리 가져오기
   		List<String> wishList = null;
   		
   		if(loginuser != null) {
   			
   			String userid = loginuser.getUserid();
   			wishList = service.getWishList(userid);
   			
   			System.out.println("eeeeee : "+wishList);
   		}
   		
   		List<LectureVO> lectureList = null;
   		
   		if(wishList != null) {
   		
	   		if(!wishList.isEmpty()) {
	   			
	   			String[] wishArr = new String[wishList.size()];
	   	   		
	   	   		for(int i=0; i<wishList.size(); i++) {
	   	   			
	   	   			wishArr[i] = wishList.get(i);
	   	   			
	   	   			
	   	   		}
	   	   		
	   	   		HashMap<String,Object> map = new HashMap<String, Object>();
	   	   		
	   	   		map.put("wishArr", wishArr);
	   	   			   	   		
	   	   		// 카테고리 별 랜덤 강좌 불러오기
	   	   		lectureList = service.getRandomLec(map);
	   	   		
	   		}
   		
   		}
   		
   		request.setAttribute("wishList", wishList);
   		
   		request.setAttribute("lectureList", lectureList);
   		
   		
   		return "lecture/recomLec.tiles1";
   	}   	

   	// 온라인 강좌 가이드
   	@RequestMapping(value="/information/onlineGuide.to")
   	public String onlineGuide() {
   		
   		return "lecture/RegGuide.tiles1";
   	}
   	
   	// 인기강좌 
   	@RequestMapping(value="populLec.to")
   	public String populLec(HttpServletRequest request) {
   		
   		List<LectureVO> lectureList = service.populLec();
   		
   		request.setAttribute("lectureList", lectureList);
   		
   		return "lecture/populLec.tiles1";
   	}
   	
   	/// >> 차트 << 카테고리 별로 하트 점유율 가져오기
   	@ResponseBody
   	@RequestMapping(value="cate_heart.to", produces = "text/plain;charset=UTF-8")
   	public String cate_heart() {
   		
   		JSONArray jsonArr = new JSONArray();
   		
   		List<HashMap<String, String>> cate_heartList = service.cate_heart();
   		
   		for(HashMap<String, String> map : cate_heartList) {
   			
   			JSONObject jsobj = new JSONObject();
   			
   			jsobj.put("fk_cate_no", map.get("fk_cate_no"));
   			jsobj.put("cate_name", map.get("cate_name"));
   			jsobj.put("sumHeart", map.get("sumHeart"));
   			jsobj.put("cnt", map.get("cnt"));
   			jsobj.put("percentage", map.get("percentage"));
   			
   			jsonArr.put(jsobj);
   		}
   		
   		return jsonArr.toString();
   	}
   	
	/// >> 차트 << 카테고리 내 인기 강좌 차트 가져오기
   	@ResponseBody
   	@RequestMapping(value="class_heart.to", produces = "text/plain;charset=UTF-8")
   	public String class_heart(String fk_cate_no) {
   		
   		JSONArray jsonArr = new JSONArray();
   		
   		List<HashMap<String, String>> class_heartList = service.class_heart(fk_cate_no);
   		
   		for(HashMap<String, String> map : class_heartList) {
   			
   			JSONObject jsobj = new JSONObject();
   			
   			jsobj.put("RNO", map.get("RNO"));
   			jsobj.put("fk_cate_no", map.get("fk_cate_no"));
   			jsobj.put("class_seq", map.get("class_seq"));
   			jsobj.put("class_title", map.get("class_title"));
   			jsobj.put("class_heart", map.get("class_heart"));
   			jsobj.put("percentage", map.get("percentage"));
   			
   			jsonArr.put(jsobj);
   		}
   		
   		return jsonArr.toString();
   		
   	}
}
