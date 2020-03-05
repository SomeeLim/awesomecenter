package com.center.payment.model;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class PaymentDAO implements InterPaymentDAO {
	
	@Autowired   // Type에 따라 알아서 Bean 을 주입해준다.
	private SqlSessionTemplate sqlsession;
	
	// 1. 장바구니에 이미 존재 하는 경우
	@Override
	public int checkSameLecture(HashMap<String, String> cartMap) {
		int n = sqlsession.selectOne("awesomePayment.checkSameLecture", cartMap);
		return n;
	}

	// 2. 장바구니 테이블에 넣기
	@Override
	public int addCart(HashMap<String, String> cartMap) {		
		int n = sqlsession.insert("awesomePayment.addCart", cartMap); 
		return n;
	}

	// 3. 장바구니 리스트 불러오기
	@Override
	public List<CartVO> getCartList(String userno) {
		List<CartVO> cartList = sqlsession.selectList("awesomePayment.getCartList", userno);
		return cartList;
	}

	// 4. 선택한 장바구니 삭제하기
	@Override
	public int  deleteCart(String cart_seq) {
		int n =sqlsession.delete("awesomePayment.deleteCart", cart_seq);
		
		return n;
	}

	
	// 5. 상세페이지에서 넘어온 cart insert
	@Override
	public void insertOneCart(HashMap<String, String> cartMap) {
		sqlsession.insert("awesomePayment.insertOneCart", cartMap);
		
	}

	// 6. 상세페이지에서 넘어온 cart 번호 가져오기
	@Override
	public String getCartNum(HashMap<String, String> cartMap) {
		String cart_seq = sqlsession.selectOne("awesomePayment.getCartNum", cartMap);
		return cart_seq;
	}

	
	//////////////////////////////////////////////승헌 ////////////////////////////////////////////////
	// 장바구니 번호로 가져온 정보를 조회 (payment.to)
	@Override
	public List<CartVO> getOrderDueList(HashMap<String, Object> orderMap) {

		List<CartVO> orderDueList = sqlsession.selectList("awesomePayment.getOrderDueList", orderMap);
		
		return orderDueList;
	}

	
	// 수강결제 수강내역 리스트에 insert
	@Override
	public int insertOneOrder(HashMap<String, String> map) {

		int n = sqlsession.insert("awesomePayment.insertOneOrder", map);
		
		return n;
	}

	// 주문 내역 select 해오기
	@Override
	public CartVO selectPayment(HashMap<String, String> map) {

		CartVO payMap = sqlsession.selectOne("awesomePayment.selectPayment", map);
		
		return payMap;
	}

	// 결제 -> 강좌수강생 테이블 insert
	@Override
	public int insertStudent(HashMap<String, String> map) {

		int n = sqlsession.insert("awesomePayment.insertStudent", map);
		
		return n;
	}

	// 수강생 테이블에서 강좌 수강생 수 조회
	@Override
	public String getStudentCnt(HashMap<String, String> map) {

		String studentCnt = sqlsession.selectOne("awesomePayment.getStudentCnt", map);
		
		return studentCnt;
	}

	// 정원과 수강생이 같으면 강좌를 대기접수로 Update
	@Override
	public void waitUpdate(HashMap<String, String> map) {
		
		sqlsession.update("awesomePayment.waitUpdate", map);
		
	}

	// 결제한 강좌가 있는지 알아보기
	@Override
	public int lecPaymentSuc(HashMap<String, String> map) {

		String count = sqlsession.selectOne("awesomePayment.lecPaymentSuc", map);
		
		// 이미 결제함
		if(!"0".equals(count)) {
			
			return 0;
			
		}
		else {
			// 결제하지 않음
			return 1;
			
		}
		
	}

	// 대기자에서 결제 후 대기목록 삭제
	@Override
	public int deleteWaiting(HashMap<String, String> map) {
		int n = sqlsession.delete("awesomePayment.deleteWaiting", map);
		return n;
	}


	

}
