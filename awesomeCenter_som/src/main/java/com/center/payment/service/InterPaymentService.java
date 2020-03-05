package com.center.payment.service;

import java.util.HashMap;
import java.util.List;

import com.center.payment.model.CartVO;

public interface InterPaymentService {

	// 1. 장바구니 테이블에 넣기
	int addCart(HashMap<String, String> cartMap);

	// 2. 장바구니 리스트 불러오기
	List<CartVO> getCartList(String userno);

	// 3. 선택한 장바구니 삭제하기
	int deleteCart(String cart_seq);

	// 4. 상세페이지에서 넘어온 cart insert
	void insertOneCart(HashMap<String, String> cartMap);

	// 5. 상세페이지에서 넘어온 cart 번호 가져오기
	String getCartNum(HashMap<String, String> cartMap);

	
	////////////////////////////// 승헌 ///////////////////////////////
	// 장바구니 번호로 가져온 정보를 조회 (payment.to)
	List<CartVO> getOrderDueList(HashMap<String, Object> orderMap);

	// 수강결제 수강내역 리스트에 insert
	int insertOneOrder(HashMap<String, String> map);

	// 주문 내역 select 해오기
	CartVO selectPayment(HashMap<String, String> map);

	// 수강생 테이블에서 강좌 수강생 수 조회
	String getStudentCnt(HashMap<String, String> map);

	// 정원과 수강생이 같으면 강좌를 대기접수로 Update
	void waitUpdate(HashMap<String, String> map);

	// 결제한 강좌가 있는지 알아보기
	int lecPaymentSuc(HashMap<String, String> map);

	
}
