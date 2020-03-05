package com.center.aop;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Component;
import com.center.common.MyUtil;

@Aspect
@Component
public class LoginCheck {
	
	// 1. Ponitcut
	@Pointcut("execution(public * com.center..*Controller.requiredLogin_*(..)) ")
	public void requireLogin() {}
	
	// 2. Login Before Advice
	@Before("requireLogin()")
	public void befor(JoinPoint joinpoint) {		
		  // JoinPoint joinpoint 는 포인트컷 되어진 주업무의 메소드이다. ★★★
	      // 로그인 유무를 확인하기 위해서 request를 통해 session을 얻어온다 
	      HttpServletRequest request = (HttpServletRequest)joinpoint.getArgs()[0]; // [0] 첫 번째 파라미터. 즉, HttpServletRequest request
	      HttpServletResponse response = (HttpServletResponse)joinpoint.getArgs()[1];
	      
	      HttpSession session = request.getSession();
	      
	      if( session.getAttribute("loginuser") == null ) {
	         
	         try {
	            String loc = request.getContextPath()+"/login.to";
	            request.setAttribute("loc", loc);
	            
	            // >>> 로그인 성공 후 로그인 하기 전 페이지로 돌아가는 작업만들기 <<< //
	            // === 현재 페이지의 주소(URL) 알아내기 ===
	            String url = MyUtil.getCurrentURL(request);
	            session.setAttribute("gobackURL", url); // 세션에 URL 정보를 저장시켜준다.
	            
	            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/msg.jsp");         
	            dispatcher.forward(request, response);
	         } catch (ServletException | IOException e) {           
	            e.printStackTrace();
	         }
	         
	      } // end of if ---------------------
	}
	
}
