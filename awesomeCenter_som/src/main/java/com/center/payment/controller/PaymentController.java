package com.center.payment.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.center.member.model.MemberVO;
import com.center.payment.model.CartVO;
import com.center.payment.service.InterPaymentService;

@Controller
public class PaymentController {
	
	@Autowired
	private InterPaymentService service;

	
	///////////////////////////// 솜님 //////////////////////////////////////////////
	
	// 1. 장바구니 업데이트
	@RequestMapping(value="/cart.to")
	public ModelAndView requiredLogin_cart(HttpServletRequest request, HttpServletResponse response ,ModelAndView mav) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		String userno = loginuser.getUserno();
		String class_seq = request.getParameter("class_seq");
		
		HashMap<String, String> cartMap = new HashMap<String, String>();		
		cartMap.put("userno", userno);
		cartMap.put("class_seq", class_seq);
		
		
		List<CartVO> cartList = null;
		
		// <1> 바로 cart.to로 들어갈 경우 : 해당 회원의 장바구니 리스트를 불러온다. 
		if(class_seq==null) {
			
			cartList = service.getCartList(userno); 

			mav.addObject("cartList", cartList);
			mav.setViewName("payment/cart.tiles1");
			
		}
		// <2> 장바구니 버튼(cart.to?class_seq=)으로 장바구니 페이지에 들어온 경우
		else {
			
			// <3> 장바구니 테이블에 넣는다.
			int n = service.addCart(cartMap);
			
			if(n==0) { // 이미 존재하는 상품인 경우		
				String msg = "이미 장바구니에 존재하는 상품입니다.";
				String loc = "javascript:history.back()";
				
				mav.addObject("msg", msg);
				mav.addObject("loc", loc);
				
				mav.setViewName("msg");

			}
			
			else if(n>0) { // 존재하지 않는 상품이라 정상적으로 장바구니에 update가 된 경우
				
				cartList = service.getCartList(userno); 

				mav.addObject("cartList", cartList);
				mav.setViewName("payment/cart.tiles1");
			}
		}
		return mav;
	}
	
	// 2. 장바구니 강좌 삭제
	@ResponseBody
	@RequestMapping(value="/deleteCart.to", produces="text/plain;charset=UTF-8")
	public String requiredLogin_cart(HttpServletRequest request, HttpServletResponse response, @RequestParam(value="deleteLecture[]")String[] deleteLecture) {	

		for(int i=0;i<deleteLecture.length;i++) {
			service.deleteCart(deleteLecture[i]);			
		}
		
		JSONObject jsobj = new JSONObject();
		
		jsobj.put("msg", "강좌가 삭제되었습니다.");
		
		return jsobj.toString();
	}
	
	// 3. 결제 페이지
	@RequestMapping(value="/payment.to", method = {RequestMethod.POST})
	public ModelAndView requiredLogin_payment(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		// 로그인한 유저의 유저번호 알아오기
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");		
		String userno = loginuser.getUserno();
		
		// HashMap에 userno 담기
		HashMap<String, String> cartMap = new HashMap<String, String>();		
		cartMap.put("userno", userno);
		
		String sep = request.getParameter("sep");
		
		String[] deleteLecture = request.getParameterValues("deleteLecture");

		String cart_seq = "";
		
		if(deleteLecture!=null) { // 장바구니에서 결제로 넘어 온 경우 : 배열로 복수개의 강좌가 넘어온다 (status=0)
			
			for(int i=0;i<deleteLecture.length;i++) {
				// 정상적으로 들어옵니다...
			//	System.out.println("올바르게 들어온 장바구니 번호 : " + deleteLecture[i]);			
			}
			
		}
		
		// 대기번호의 사람이 결제
		else if("wait".equalsIgnoreCase(sep)) {
		
			String class_seq = request.getParameter("class_seq");
			
			// 장바구니테이블로 insert한다.
			cartMap.put("class_seq", class_seq);
			service.insertOneCart(cartMap);
			
			cart_seq = service.getCartNum(cartMap);
			
		}
		
		else { // 상세페이지에서 바로 결제로 넘어온다 : 1개의 강좌만 넘어온다
			// 정상적으로 들어옵니다...
			String class_seq = request.getParameter("class_seq");
		//	System.out.println("올바르게 넘어온 강좌 번호 : " + class_seq);
			
			// 장바구니테이블로 insert한다.
			cartMap.put("class_seq", class_seq);
			service.insertOneCart(cartMap);
			// 상세페이지에서 넘어온 장바구니 버튼 reuturn(status=1)
			cart_seq = service.getCartNum(cartMap);
		//	System.out.println("올바르게 넘어온 카트 번호 : " + cart_seq);
			
		}
		
		HashMap<String, Object> orderMap = new HashMap<String, Object>();
		
		orderMap.put("userno", userno);
		orderMap.put("deleteLecture", deleteLecture);
		if(cart_seq == null || "".equals(cart_seq)) {
			cart_seq = "";
		}
		
		orderMap.put("cart_seq", cart_seq);
		
		// 장바구니 번호로 가져온 정보를 조회
		List<CartVO> orderDueList = service.getOrderDueList(orderMap);
		
		int totalCount = 0; 
		for(CartVO cvo : orderDueList ) {
			
			totalCount += cvo.getClass_fee();
		}
		
		mav.addObject("orderDueList", orderDueList);
		mav.addObject("totalCount", totalCount);
		
		mav.setViewName("payment/payment.tiles1");
		
		return mav;
		
	}

	////////////////////////////////////// 서승헌 ////////////////////////////////////////
	// 파이널 수강결제  << 3. 수강결제 변경
/*  	@RequestMapping(value="/payment.to") 
  	public String payment(HttpServletRequest request) {
  		
  		return "payment/payment.tiles1";
  	}*/
	
	@RequestMapping(value="/paying.to", method={RequestMethod.GET})
	public String requiredLogin_paying(HttpServletRequest request, HttpServletResponse response) {
		
		
		
		HttpSession session = request.getSession();
   		
   		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		String userno =	loginuser.getUserno();
		String username = loginuser.getUsername();
   		String totalPrice = request.getParameter("totalCount");
		
   		request.setAttribute("userno", userno);
   		request.setAttribute("username", username);
   		request.setAttribute("totalPrice", totalPrice);
   		
   		String payArr = request.getParameter("payArr");
   		String[] class_seqArr = payArr.split(",");
   		
   		for(int i=0; i<class_seqArr.length; i++) {
   			
   			HashMap<String, String> map = new HashMap<String, String>();
   	   		map.put("userno", userno);
   			map.put("class_seq", class_seqArr[i]);
   			// 결제한 강좌가 있는지 알아보기
   			int n = service.lecPaymentSuc(map);
   	   		
   			if(n == 0) {
   				
   				request.setAttribute("msg", "이미 결제한 강좌는 결제하실 수 없습니다.");
   				
   				return "msg";
   			}
   			
   		}
   
   		
   		return "payment/paymentGateway";
	}
	


	
   
   	
}