package kr.spring.member.controller;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.spring.member.service.CaptchaService;
import kr.spring.member.service.MemberService;
import kr.spring.member.vo.MemberVO;
import kr.spring.payment.service.PayService;
import kr.spring.payment.vo.PayVO;
import kr.spring.question.service.EmailService;
import kr.spring.reserve.service.TicketService;
import kr.spring.reserve.vo.TicketVO;
import kr.spring.store.vo.StoreVO;
import kr.spring.util.AuthCheckException;
import kr.spring.util.FileUtil;
import kr.spring.util.PageUtil;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class MemberController {
	@Autowired
	private MemberService memberService;
	@Autowired
	private PayService payService;
	@Autowired
	private TicketService ticketService;
	@Autowired
	private CaptchaService captchaService;
	/*==============================
	 * 자바빈(VO) 초기화
	 *==============================*/
	@ModelAttribute
	public MemberVO initCommand() {
		return new MemberVO();
	}
	/*==============================
	 * 회원가입
	 *==============================*/
	//회원가입여부 체크
	@GetMapping("/member/registerUserCheck")
	public String formCheck() {
		return "memberRegisterCheck";
	}
	//전송된 회원 데이터 처리
	@PostMapping("/member/registerUserCheck")
	public String submitCheck(@Valid MemberVO memberVO,
			BindingResult result,
			Model model,
			HttpServletRequest request,
			RedirectAttributes redirect) {
		log.debug("<<회원가입 여부>> : " + memberVO);

		// 유효성 체크 결과 오류 있으면 폼 호출
		if(result.hasFieldErrors("mem_name") || result.hasFieldErrors("mem_birth") || result.hasFieldErrors("mem_phone")) {
			List<FieldError> list =  result.getFieldErrors();
			for(FieldError error : list) {
				log.debug("<<에러 필드>> : " + error.getField());
			}
			return formCheck();
		}
		String month = Integer.parseInt(memberVO.getMem_birth_month()) < 10 ? "0"+memberVO.getMem_birth_month() : memberVO.getMem_birth_month() ;
		String day = Integer.parseInt(memberVO.getMem_birth_day()) < 10 ? "0"+memberVO.getMem_birth_day() : memberVO.getMem_birth_day() ;

		memberVO.setMem_birth(memberVO.getMem_birth_year()+"-"+month+"-"+day);

		// 디버깅 메시지 추가
		log.debug("<<mem_birth>> : " + memberVO.getMem_birth());


		// 회원가입 여부  
		if (memberService.selectCheckMemberRegistered(memberVO) >= 1) {
			// 회원 DB에 이미 가입한 전적이 있는 회원(신규가입 불가한 회원)
			model.addAttribute("accessTitle","회원 가입 불가");
			model.addAttribute("accessMsg","이미 가입한 회원입니다.");
			model.addAttribute("accessUrl",request.getContextPath()+"/member/login");
			return "common/resultView";
		}

		redirect.addFlashAttribute("memberVO", memberVO);

		//회원 가입 이력 없는 사람이면 다음 절차로 통과
		// 타일스 설정명
		return "redirect:/member/registerUser";
	}


	//회원가입 폼 호출
	@GetMapping("/member/registerUser")
	public String form() {
		return "memberRegister";
	}
	//전송된 회원 데이터 처리
	@PostMapping("/member/registerUser")
	public String submit(@Valid MemberVO memberVO,BindingResult result,Model model,HttpServletRequest request) {
		log.debug("<<회원가입>> : " + memberVO);

		//유효성 체크 결과 오류 있으면 폼 호출
		if(result.hasErrors()) {
			for(FieldError error : result.getFieldErrors()) {
				log.debug("<<에러 필드>> : " + error.getField());
			}
			return form();
		}
		//한자리수 월이나 일 앞에 0 붙여줘서 yyyy-mm-dd 형식 맞추기 위한 부분
		String month = Integer.parseInt(memberVO.getMem_birth_month()) < 10 ? "0"+memberVO.getMem_birth_month() : memberVO.getMem_birth_month() ;
		String day = Integer.parseInt(memberVO.getMem_birth_day()) < 10 ? "0"+memberVO.getMem_birth_day() : memberVO.getMem_birth_day() ;

		memberVO.setMem_birth(memberVO.getMem_birth_year()+"-"+month+"-"+day);


		//나이 계산
		LocalDate birthDate = LocalDate.parse(memberVO.getMem_birth());

	
		LocalDate currentDate = LocalDate.now();

		long age = ChronoUnit.YEARS.between(birthDate, currentDate);
		
		//연령대 계산
		String ageGroup = calculateAgeGroup(age);

		//연령대 MemberVO에 저장
		memberVO.setMem_age(ageGroup);

		// 디버깅 메시지 추가
		log.debug("<<mem_birth>> : " + memberVO.getMem_birth());

		
		log.debug("생년월일에 의한 연령대 계산 : " + ageGroup);

		//회원가입
		memberService.insertMember(memberVO);

		model.addAttribute("accessTitle","회원가입");
		model.addAttribute("accessMsg","회원가입이 완료되었습니다.");
		model.addAttribute("accessUrl",request.getContextPath()+"/main/main");
		return "common/resultView";

	}

	public String calculateAgeGroup(long age) {
		String ageGroup = "";

		if(age >= 10 && age < 20) {
			ageGroup = "10대";
		}else if(age >= 20 && age < 30) {
			ageGroup = "20대";
		}else if(age >= 30 && age < 40) {
			ageGroup = "30대";
		}else if(age >= 40 && age < 50) {
			ageGroup = "40대";
		}else if(age >= 50) {
			ageGroup = "50대 이상";
		}else {
			ageGroup = "어린이";
		}

		return ageGroup;

	}

	/*==============================
	 * 회원 정보 수정
	 *==============================*/

	//회원정보 수정 폼 호출
	@GetMapping("/member/updateUser")
	public String editForm(HttpSession session, Model model, HttpServletRequest request) {
	    // HttpSession에서 "user" 속성명으로 저장된 회원 정보를 가져옵니다.
	    MemberVO user = (MemberVO) session.getAttribute("user");
	   
	    MemberVO memberVO = (MemberVO) memberService.selectMember(user.getMem_num());
	    
	    log.debug("<<memberVO 회원정보수정 폼>> : " + memberVO);
	    // 가져온 회원 정보가 null이 아닌 경우, 모델에 추가합니다.
	    if (memberVO != null) {
	        model.addAttribute("memberVO", memberVO);
	    } else {
	        // 로그인한 사용자 정보가 없는 경우(예: 세션이 만료된 경우), 로그인 페이지로 리디렉션하거나 적절한 메시지를 표시할 수 있습니다.
	        model.addAttribute("accessTitle", "세션 만료");
	        model.addAttribute("accessMsg", "로그인 세션이 만료되었습니다. 다시 로그인해 주세요.");
	        model.addAttribute("accessUrl", request.getContextPath()+"/member/login"); // 로그인 페이지 URL로 변경하세요.
	        return "common/resultView"; // 또는 로그인 페이지로 리디렉션하는 코드
	    }
	    	
	    // 회원 정보 수정 폼으로 이동합니다.
	    return "memberUpdate";
	}
	@PostMapping("/member/updateUser")
	public String editSubmit(@Valid MemberVO memberVO, BindingResult result, Model model, HttpServletRequest request, HttpSession session) {
		// 현재 로그인한 사용자의 세션 정보 가져오기
		MemberVO loggedInUser = (MemberVO) session.getAttribute("user");
		if (loggedInUser == null) {
			// 세션에 로그인 정보가 없는 경우 (로그아웃 상태)
			return "redirect:/member/login"; // 로그인 페이지로 리디렉션
		}

		// MemberVO 객체에 현재 로그인한 사용자의 mem_num 설정
		memberVO.setMem_num(loggedInUser.getMem_num());
		if (result.hasFieldErrors("mem_phone") || result.hasFieldErrors("mem_email")
				|| result.hasFieldErrors("mem_zipcode") || result.hasFieldErrors("mem_address1")
				|| result.hasFieldErrors("mem_address2")) {
			List<FieldError> list = result.getFieldErrors();
			for (FieldError error : list) {
				log.debug("<<에러 필드>> : " + error.getField());
			}
			return "memberUpdate";
		}

	    // 회원 정보 수정 로직을 실행합니다.
		log.debug("<<회원정보 수정 폼 제출 memberVO>> : " + memberVO);
		
	    memberService.updateMember_detail(memberVO);

	    model.addAttribute("accessTitle", "회원 정보 수정");
	    model.addAttribute("accessMsg", "회원 정보가 성공적으로 수정되었습니다.");
	    model.addAttribute("accessUrl", request.getContextPath() + "/member/myPage"); // 회원 정보 조회 페이지 또는 메인 페이지로 변경 가능
	    return "common/resultView";
	}


	/*==============================
	 * 회원로그인
	 *==============================*/	
	//로그인 폼 호출
	@GetMapping("/member/login")
	public String formLogin() {
		return "memberLogin";
	}
	//전송된 데이터 처리
	@PostMapping("/member/login")
	public String submit(@Valid MemberVO memberVO,
			BindingResult result,
			HttpSession session,
			HttpServletResponse response) {

		log.debug("<<회원로그인>> : " + memberVO);

		//유효성 체크 결과 오류가 있으면 폼 호출
		//id와 pw 필드만 유효성 체크
		if(result.hasFieldErrors("mem_id") || result.hasFieldErrors("mem_pw")) {
			return formLogin();
		}

		//로그인 체크 (id,비밀번호 일치 여부 체크)
		MemberVO member = null;
		try{
			member = memberService.selectCheckMember(memberVO.getMem_id());
			boolean check = false;

			if(member!=null) {
				
				//비밀번호 일치 여부 체크
				check = member.isCheckedPassword(memberVO.getMem_pw());
			}
			if(check) {//인증 성공
				//자동 로그인 체크 시작
				boolean autoLogin = memberVO.getAuto() != null && memberVO.getAuto().equals("on");

				if(autoLogin) {
					//자동로그인 체크를 한 경우
					String autoid = member.getMem_autoid();
					if(autoid==null) {
						//자동 로그인 체크 식별값 생성
						autoid = UUID.randomUUID().toString();
						log.debug("<<autoid>> : " + autoid);
						member.setMem_autoid(autoid);
						memberService.updateAutoid(member.getMem_autoid(), member.getMem_num());

					}

					Cookie auto_cookie = new Cookie("autoid-log",autoid);
					auto_cookie.setMaxAge(60*60*24*7);//쿠키의 유효기간은 1주일
					auto_cookie.setPath("/");

					response.addCookie(auto_cookie);



				}
				//자동로그인 체크 끝

				//인증 성공, 로그인 처리
				session.setAttribute("user", member);
				log.debug("<<인증 성공>>");
				log.debug("<<mem_id>> : " + member.getMem_id());
				log.debug("<<mem_num>> : " + member.getMem_num());
				log.debug("<<mem_auth>> : " + member.getMem_auth());
				log.debug("<<mem_autoid>> : " + member.getMem_autoid());

				if(member.getMem_auth()==9) {//관리자는 관리자 메인으로 이동
					return "redirect:/member/AdminPageMain";
				}else {//일반 사용자는 사용자 메인으로 이동
					return "redirect:/main/main";
				}
			}
			//인증 실패
			throw new AuthCheckException();

		}catch(AuthCheckException e) {
			log.debug("<<인증 실패>>");
			//인증 실패로 로그인 폼 호출
			if(member!=null && member.getMem_auth()==2) {//정지회원 메시지 표시
				result.reject("noAuthority");
			}else if(member!=null && member.getMem_auth()==3){
				result.reject("withdrawnMember");
			}else {
				result.reject("invalidIdOrPassword");
			}


			return formLogin();
		}
	}
	
	
	/*==============================
	 * 로그아웃
	 *==============================*/
	@RequestMapping("/member/logout")
	public String processLogout(HttpSession session, 
			HttpServletResponse response) {
		//로그아웃
		session.invalidate();
		//자동로그인 처리 시작
		//클라이언트 쿠키 처리
		Cookie auto_cookie = new Cookie("autoid-log","");
		auto_cookie.setMaxAge(0);//쿠키 삭제
		auto_cookie.setPath("/");

		//자동로그인 처리 끝
		response.addCookie(auto_cookie);
		return "redirect:/main/main";
	}



	/*==============================
	 * 	회원 탈퇴
	 *==============================*/

	@GetMapping("/member/get_random")
	@ResponseBody
	public Map<String,Object> getRadomNum(HttpSession session) {
		Map<String,Object> map = new HashMap<String,Object>();
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user==null) {
			map.put("result", "logout");
		}else {
			Math.floor(1000 + Math.random() * 9000);
			int randomNumber = (int)(1000 + Math.random() * 9000);
			map.put("result", "success");
			map.put("randomNumber", randomNumber);
			session.setAttribute("randomNumber", randomNumber);
		}
		return map;
	}
	
	// 회원 탈퇴 폼 호출
	@GetMapping("/member/withdraw") 
	public String withdrawForm() { 
		return "withdrawForm"; 
	}

	@PostMapping("/member/withdraw")
	public String withdraw(HttpSession session, Model model, HttpServletRequest request,
	                       @RequestParam("mem_pw") String password,
	                       @RequestParam("captchaKey") String captchaKey,
	                       @RequestParam("captchaValue") String captchaValue) {

	    MemberVO member = (MemberVO) session.getAttribute("user");

	    if (member != null) { // 로그인 되어 있는 상태
	        // 회원 정보에서 비밀번호 가져오기
	        String storedPassword = member.getMem_pw();

	        // 캡차 검증 로직 추가
	        boolean isCaptchaValid = captchaService.validateCaptcha(captchaKey, captchaValue);
	        
	        if (!isCaptchaValid) {
	            model.addAttribute("accessTitle", "탈퇴 절차 실패");
	            model.addAttribute("accessMsg", "캡차 입력이 올바르지 않습니다.");
	            model.addAttribute("accessUrl", request.getContextPath() + "/member/withdraw");
	            return "common/resultView";
	        }

	        // 비밀번호 일치 검증
	        if (password.equals(storedPassword)) {
	            // 회원 탈퇴 처리 로직
	            memberService.withdrawMember(member.getMem_num());
	            return "common/resultView"; // 탈퇴 성공 시 결과 페이지 반환
	        } else {
	            // 비밀번호 불일치 시 에러 메시지 출력
	            model.addAttribute("accessTitle", "탈퇴 절차 실패");
	            model.addAttribute("accessMsg", "비밀번호가 올바르지 않습니다.");
	            model.addAttribute("accessUrl", request.getContextPath() + "/member/withdraw");
	            return "common/resultView";
	        }
	    } else { // 로그인 되지 않은 상태
	        return "redirect:/member/login";
	    }
	}




	/*==============================
	 * 마이페이지
	 *==============================*/
	@RequestMapping("/member/myPage")
	public String process(HttpSession session, Model model) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		log.debug("<<mem_num>> : " + user.getMem_num());

		//회원정보
		MemberVO member = memberService.selectMember(user.getMem_num());
		session.setAttribute("member", member);
		log.debug("<<회원 상세 정보>> : " + member);

		model.addAttribute("member",member);

		return "myPage";
	}

	/*==============================
	 * 	프로필 사진 출력
	 *==============================*/
	//프로필 사진 출력
	@RequestMapping("/member/photoView")
	public String getProfile(HttpSession session,HttpServletRequest request,Model model) {
		MemberVO user = (MemberVO)session.getAttribute("user");

		log.debug("<<프로실 사진 읽기>> : " + user);
		if(user==null) {//로그인 되지 않은 경우
			getBasicProfileImage(request,model);
		}else {//로그인 된 경우
			MemberVO memberVO = memberService.selectMember(user.getMem_num());
			viewProfile(memberVO,request,model);
		}
		return "imageView";

	}
	//프로필 사진 출력(회원번호 지정)
	@RequestMapping("/member/viewProfile")
	public String getProfileByMem_num(@RequestParam int mem_num,HttpServletRequest request,Model model) {
		MemberVO memberVO = memberService.selectMember(mem_num);

		viewProfile(memberVO,request,model);

		return "imageView";
	}
	//프로필 사진 처리를 위한 공통 코드
	public void viewProfile(MemberVO memberVO,HttpServletRequest request,Model model) {
		if(memberVO==null || memberVO.getMem_photoname()==null) {
			//업로드한 프로필 사진 정보가 없어서 기본 이미지 표시
			getBasicProfileImage(request,model);

		}else {//업로드한 아미지 읽기
			model.addAttribute("imageFile",memberVO.getMem_photo());
			model.addAttribute("filename",memberVO.getMem_photoname());
		}
	}
	//기본 이미지 읽기
	public void getBasicProfileImage(HttpServletRequest request, Model model) {
		byte[] readbyte = FileUtil.getBytes(request.getServletContext().getRealPath("/image_bundle/face.png"));

		model.addAttribute("imageFile",readbyte);
		model.addAttribute("filename","face.png");
	}


	
	




	@RequestMapping("/member/myPageTicket")
	public String process1(@RequestParam(value="pageNum",defaultValue = "1") int currentPage, HttpSession session, Model model) {
		MemberVO vo = (MemberVO)session.getAttribute("user");
		Map<String, Object> map = new HashMap<String, Object>();
		int count = payService.selectRowCount(map, vo.getMem_num());
		
		PageUtil page = new PageUtil(currentPage, count, 10,10,"myPageTicket");
		
		List<TicketVO> list = null;
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			map.put("mem_num", vo.getMem_num());
			
			list = ticketService.selectList(map);
		}
		model.addAttribute("count", count);
		model.addAttribute("list", list);
		model.addAttribute("page", page.getPage());
		
		return "myPageTicket";
	}
	@RequestMapping("/member/myPageCoupon")
	public String process2() {


		return "myPageCoupon";
	}
	@RequestMapping("/member/myPagePoint")
	public String process3() {


		return "myPagePoint";
	}
	@RequestMapping("/member/myPageEvent")
	public String process4() {


		return "myPageEvent";
	}

	@RequestMapping("/member/myPageGiftshop")
	public String sotrePayMain(@RequestParam(value="pageNum",defaultValue = "1") int currentPage, HttpSession session, Model model) {
		MemberVO vo = (MemberVO)session.getAttribute("user");
		Map<String, Object> map = new HashMap<String, Object>();
		
		int count = payService.selectRowCount(map, vo.getMem_num());
		
		PageUtil page = new PageUtil(currentPage, count, 5,10,"myPageGiftshop");
		
		List<PayVO> list = null;
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			map.put("mem_num", vo.getMem_num());
			
			list = payService.selectList(map);
		}
		model.addAttribute("count", count);
		model.addAttribute("list", list);
		model.addAttribute("page", page.getPage());
		log.debug("<<myPageGiftshop 글 목록 list>> : " + list);

		return "storePayMain";
	}
	@RequestMapping("/member/myPageInfo")
	public String process6() {


		return "myPageInfo";
	}
	@RequestMapping("/member/myPageProfile")
	public String process7() {


		return "myPageProfile";
	}

	//문의내역
	@RequestMapping("/member/myPageFAQ")
	public String process8() {


		return "myPageFAQ";
	}

	@RequestMapping("/member/myPageEmail")
	public String process9() {


		return "myPageFAQ";
	}
	@RequestMapping("/member/myPageRental")
	public String process10() {


		return "myPageRental";
	}
}



















