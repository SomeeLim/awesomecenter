package com.center.payment.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.center.payment.model.CartVO;
import com.center.payment.model.InterPaymentDAO;

@Service
public class PaymentService implements InterPaymentService {
	
	@Autowired
	private InterPaymentDAO dao;

	// 1. 장바구니 테이블에 넣기
	@Override
 	@Transactional(propagation=Propagation.REQUIRED, isolation= Isolation.READ_COMMITTED, rollbackFor={Throwable.class})
	public int addCart(HashMap<String, String> cartMap) {
		int n = 0;
		// 장바구니에 상품이 존재한다면 m > 0
		int m = dao.checkSameLecture(cartMap);
		if(m==0) {
			// 상품이 정상적으로 insert된다면 n=1
			m=1;
			n=dao.addCart(cartMap);
		}		
		// n*m = 상품존재(0*m =0) & insert(m*n==1)
		return n*m;
	}

	// 2. 장바구니 리스트 불러오기
	@Override
	public List<CartVO> getCartList(String userno) {
		List<CartVO> cartList = dao.getCartList(userno); 
		return cartList;
	}

	// 3. 선택한 장바구니 삭제하기
	@Override
	public int deleteCart(String cart_seq) {
		
		int n = dao.deleteCart(cart_seq);
		
		return n;
	}

	
	// 4. 상세페이지에서 넘어온 cart insert
	@Override
	public void insertOneCart(HashMap<String, String> cartMap) {
		dao.insertOneCart(cartMap);
	}

	// 5. 상세페이지에서 넘어온 cart 번호 가져오기
	@Override
	public String getCartNum(HashMap<String, String> cartMap) {
		String cart_seq = dao.getCartNum(cartMap);
		return cart_seq;
	}

	////////////////////////////////////////////// 승헌 ////////////////////////////////////////////////
	// 장바구니 번호로 가져온 정보를 조회 (payment.to)
	@Override
	public List<CartVO> getOrderDueList(HashMap<String, Object> orderMap) {

		List<CartVO> orderDueList = dao.getOrderDueList(orderMap);
		
		return orderDueList;
	}

	// 수강결제 수강내역 리스트에 insert & 장바구니 삭제 
	@Override
	@Transactional(propagation=Propagation.REQUIRED, isolation= Isolation.READ_COMMITTED, rollbackFor={Throwable.class})
	public int insertOneOrder(HashMap<String, String> map) {
		
		
		int result = 0;
		
		int n = dao.insertOneOrder(map);
		
		if(n==1) {
			if( !map.get("cart_seq").isEmpty() || map.get("cart_seq") != null) {
	
				int m = dao.deleteCart(map.get("cart_seq"));
				int x = dao.insertStudent(map);
				// 대기자 결제 후 대기목록 삭제
				int y = dao.deleteWaiting(map);
				
				result = m*x;
				
			}
			else {
				result = dao.insertStudent(map);
			}
		}
		
		return result;
	}

	// 주문 내역 select 해오기
	@Override
	public CartVO selectPayment(HashMap<String, String> map) {
		
		CartVO payMap = dao.selectPayment(map);
		
		return payMap;
	}

	// 수강생 테이블에서 강좌 수강생 수 조회
	@Override
	public String getStudentCnt(HashMap<String, String> map) {

		String studentCnt = dao.getStudentCnt(map);
		
		return studentCnt;
	}

	// 정원과 수강생이 같으면 강좌를 대기접수로 Update
	@Override
	public void waitUpdate(HashMap<String, String> map) {

		dao.waitUpdate(map);
		
	}

	// 결제한 강좌가 있는지 알아보기
	@Override
	public int lecPaymentSuc(HashMap<String, String> map) {

		int n = dao.lecPaymentSuc(map);
		
		return n;
	}

	

}
