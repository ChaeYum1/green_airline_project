package com.green.airline.controller;

import java.net.URI;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import com.green.airline.dto.nation.NationDto;
import com.green.airline.dto.request.JoinFormDto;
import com.green.airline.dto.request.LoginFormDto;
import com.green.airline.dto.request.PasswordCheckDto;
import com.green.airline.dto.request.SocialJoinFormDto;
import com.green.airline.dto.request.UserFormDto;
import com.green.airline.dto.response.BaggageReqResponseDto;
import com.green.airline.dto.response.InFlightMealResponseDto;
import com.green.airline.dto.response.SpecialMealResponseDto;
import com.green.airline.handler.exception.CustomRestfullException;
import com.green.airline.repository.model.Airport;
import com.green.airline.repository.model.InFlightMeal;
import com.green.airline.repository.model.InFlightService;
import com.green.airline.repository.model.Member;
import com.green.airline.repository.model.User;
import com.green.airline.service.AirportService;
import com.green.airline.service.BaggageRequestService;
import com.green.airline.service.BaggageService;
import com.green.airline.service.InFlightSvService;
import com.green.airline.service.UserService;
import com.green.airline.utils.Define;

@Controller
@Validated
public class UserController {

	@Autowired
	private UserService userService;

	@Autowired
	private HttpSession session;

	@Autowired
	private AirportService airportService;

	@Autowired
	private BCryptPasswordEncoder bCryptPasswordEncoder;

	@Autowired
	private InFlightSvService inFlightSvService;

	@Autowired
	private BaggageRequestService baggageRequestService;

	/**
	 * @author 서영 메인 페이지
	 */
	@GetMapping("")
	public String mainPage(Model model) {
		int isMain = 1;
		model.addAttribute("isMain", isMain);

		List<Airport> regionList = airportService.readRegion();
		model.addAttribute("regionList", regionList);

		return "/mainPage";
	}

	/**
	 * @author 서영 로그인 페이지
	 */
	@GetMapping("/login")
	public String loginPage() {
		return "/user/login";
	}

	/**
	 * 
	 * 로그인 처리
	 * 
	 * todo : 비밀번호인코더 처리
	 * 
	 * @return
	 * 
	 */
	@PostMapping("/login")
	public String loginProc(LoginFormDto loginFormDto) {
		User principal = userService.readUserByIdAndPassword(loginFormDto);
		if (principal != null && principal.getStatus() == 0) {
			session.setAttribute(Define.PRINCIPAL, principal);
			if (principal.getUserRole().equals("관리자")) {
				return "redirect:/manager/dashboard";
			}
		}

		if (principal.getStatus() == 1) {
			throw new CustomRestfullException("탈퇴한 회원입니다.", HttpStatus.BAD_REQUEST);
		}

		return "redirect:/";
	}

	@GetMapping("/logout")
	public String logoutProc(HttpServletRequest request) {

		session.invalidate();
		return "redirect:/";
	}

	/**
	 * 
	 * @return 로그인되어 있는 멤버의 회원 정보
	 */
	@ResponseBody
	@GetMapping("/loginMemberInfo")
	public Member loginMemberInfoData() {
		User principal = (User) session.getAttribute(Define.PRINCIPAL);
		Member response = userService.readMemberById(principal.getId());
		return response;
	}

	// 일반 회원 로그인 페이지
	@GetMapping("/join")
	public String joinPage(Model model) {
		ArrayList<String> countryNm = nationalityApi();

		model.addAttribute("countryNm", countryNm);

		return "/user/join";
	}

	// 카카오 로그인 페이지
//	@GetMapping("/socialJoin")
//	public String apiJoinPage(@RequestParam(name = "id") String id, @RequestParam(defaultValue = "none") String email,
//			@RequestParam(defaultValue = "none") String gender, Model model) {
//
//		ArrayList<String> countryNm = nationalityApi();
//
//		model.addAttribute("countryNm", countryNm);
//		model.addAttribute("id", id);
//		model.addAttribute("email", email);
//		model.addAttribute("gender", gender);
//		return "redirect:/";
//	}

	// 회원가입 (join.jsp에 회원가입 버튼으로 회원가입하는 경우 무조건 여기로 옴)
	@PostMapping("/joinProc")
	public String joinProc(@Validated JoinFormDto joinFormDto, Errors errors, Model model) {
		// 인증검사
		// post 요청시 넘어온 user 입력값에서 Validation에 걸리는 경우
		if (errors.hasErrors()) {
			// 회원가입 실패시 입력 데이터 유지
			model.addAttribute("joinFormDto", joinFormDto);

			// 회원가입 실패시 message 값들을 모델에 매핑해서 View로 전달
			Map<String, String> validateResult = userService.validateHandler(errors);

			// map.keySet() 모든 key값을 갖고 온다.
			// 그 갖고 온 키로 반복문을 통해 키와 에러 메세지로 매핑
			for (String key : validateResult.keySet()) {

				// ex) model.addAttribute("valid_id", "아이디는 필수 입력사항입니다.")
				model.addAttribute(key, validateResult.get(key));
			}
			ArrayList<String> countryNm = nationalityApi();
			model.addAttribute("countryNm", countryNm);
			// 에러가 발생했을 경우
			return "/user/join";
		}

		// 몰라 입력받은 id와 원래 있는 아이디가 같다면 회원가입 안 되도록 예외처리

		userService.createMember(joinFormDto);

		return "redirect:/login";
	}

	@GetMapping("/apiSocialJoin")
	public String apiSocialJoinPage(@RequestParam(name = "id") String id,
			@RequestParam(defaultValue = "none") String email, @RequestParam(defaultValue = "none") String gender,
			Model model) {

		ArrayList<String> countryNm = nationalityApi();
		model.addAttribute("countryNm", countryNm);

		model.addAttribute("id", id);
		model.addAttribute("email", email);
		model.addAttribute("gender", gender);
		return "/user/socialJoin";
	}

	// 이거를 타게 하면 된다.
	@PostMapping("/apiSocialJoinProc")
	public String apiSocialJoinProc(@Validated SocialJoinFormDto socialJoinFormDto, Errors errors, Model model) {

		if (errors.hasErrors()) {
			// 회원가입 실패시 입력 데이터 유지
			model.addAttribute("socialJoinFormDto", socialJoinFormDto);

			// 회원가입 실패시 message 값들을 모델에 매핑해서 View로 전달
			Map<String, String> validateResult = userService.validateHandler(errors);

			// map.keySet() 모든 key값을 갖고 온다.
			// 그 갖고 온 키로 반복문을 통해 키와 에러 메세지로 매핑
			for (String key : validateResult.keySet()) {

				// ex) model.addAttribute("valid_id", "아이디는 필수 입력사항입니다.")
				model.addAttribute(key, validateResult.get(key));
			}
			ArrayList<String> countryNm = nationalityApi();
			model.addAttribute("countryNm", countryNm);
			// 에러가 발생했을 경우
			return "/user/socialJoin";
		}

		try {
			userService.createSocialMember(socialJoinFormDto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		// 로그인이 된 채로 redirect가 되지 않음
		return "redirect:/";
	}

	// 국적 api
	public ArrayList<String> nationalityApi() {
		RestTemplate restTemplate = new RestTemplate();
		URI uri = null;

		try {
			uri = new URI(
					"http://apis.data.go.kr/1262000/CountryCodeService2/getCountryCodeList2?serviceKey=Cuo5MmMb2QEiC58RNfbyKZ3q7MF%2F5mvNSC%2FXcSI%2F9mkEK8Blx2zD5dULoP9UK0MaSi049JL%2BUmo7K%2FHXgEH9dQ%3D%3D&numOfRows=300&pageNo=1");
		} catch (URISyntaxException e) {
			e.printStackTrace();
		}

		ResponseEntity<NationDto> response = restTemplate.getForEntity(uri, NationDto.class);
		ArrayList<String> countryNm = new ArrayList<>();

		for (int i = 0; i < response.getBody().getData().size(); i++) {
			countryNm.add(response.getBody().getData().get(i).getCountryNm());
		}
		return countryNm;
	}

	// 회원 정보 수정 페이지 ) 비밀번호 확인 페이지
	// 쿼리 스트링을 사용해 어떤 페이지에서 이 메서드로 접근했는지 구별해준다.
	@GetMapping("/userPwCheck")
	public String userPwCheckPage(Model model, @RequestParam String type) {
		User principal = (User) session.getAttribute(Define.PRINCIPAL);
		User user = userService.readUserById(principal.getId());

		model.addAttribute("principal", principal);
		model.addAttribute("type", type);

		return "/user/userPwCheck";
	}

	@PostMapping("/userPwCheck")
	public String userPwCheckProc(PasswordCheckDto passwordCheckDto) {
		User principal = (User) session.getAttribute(Define.PRINCIPAL);
		User user = userService.readUserById(principal.getId());

		Boolean isChecked = bCryptPasswordEncoder.matches(passwordCheckDto.getPassword(), principal.getPassword());
		System.out.println(isChecked);

		if (isChecked == false) {
			throw new CustomRestfullException("비밀번호가 일치하지 않습니다.", HttpStatus.BAD_REQUEST);
		} else {
			if (passwordCheckDto.getType().equals("userUpdate")) {
				return "redirect:/userUpdate";
			} else if (passwordCheckDto.getType().equals("userWithdraw")) {
				return "redirect:/userWithdraw";
			}
		}
		return "에러페이지 주소";
	}

	// 회원 정보 수정 페이지
	@GetMapping("/userUpdate")
	public String userUpdatePage(Member member, Errors errors, Model model) {
		User principal = (User) session.getAttribute(Define.PRINCIPAL);
		Member memberById = userService.readMemberById(principal.getId());

		model.addAttribute("principal", principal);
		model.addAttribute("memberById", memberById);

		ArrayList<String> countryNm = nationalityApi();
		model.addAttribute("countryNm", countryNm);

		return "/user/userUpdate";
	}

	@PostMapping("/userUpdate")
	public String userUpdateProc(@RequestParam String id, @Validated UserFormDto userFormDto, Errors errors,
			Member member, Model model) {
		User principal = userService.readUserById(id);
		userService.updateMemberById(principal.getId(), member);

		if (errors.hasErrors()) {
			// 회원가입 실패시 입력 데이터 유지
			model.addAttribute("userFormDto", userFormDto);

			// 회원가입 실패시 message 값들을 모델에 매핑해서 View로 전달
			Map<String, String> validateResult = userService.validateHandler(errors);

			// map.keySet() 모든 key값을 갖고 온다.
			// 그 갖고 온 키로 반복문을 통해 키와 에러 메세지로 매핑
			for (String key : validateResult.keySet()) {

				// ex) model.addAttribute("valid_id", "아이디는 필수 입력사항입니다.")
				model.addAttribute(key, validateResult.get(key));
			}
			ArrayList<String> countryNm = nationalityApi();
			model.addAttribute("countryNm", countryNm);
			// 에러가 발생했을 경우
			return "/user/userUpdate";
		}

		// todo 마이페이지로 이동
		return "redirect:/";
	}

	// 회원 탈퇴
	@GetMapping("/userWithdraw")
	public String userWithdrawPage(Model model) {
		User principal = (User) session.getAttribute(Define.PRINCIPAL);

		// Todo member 정보내려주기
		Member member = userService.readById(principal.getId());
		model.addAttribute("member", member);

		if (principal.getStatus() == 1) {
			throw new CustomRestfullException("", null);
		}

		model.addAttribute("principal", principal);

		return "/user/userWithdraw";
	}

	// 회원 탈퇴 상태 변경 0 : 회원 / 1 : 탈퇴 회원
	@PostMapping("/userWithdraw")
	public String userWithdrawProc() {
		User principal = (User) session.getAttribute(Define.PRINCIPAL);
		userService.updateUserByStatus(principal.getId(), 1);
		session.invalidate();

		return "redirect:/";
	}

	// 비밀번호 변경 페이지
	@GetMapping("/changePw")
	public String changePwPage(Model model) {
		User principal = (User) session.getAttribute(Define.PRINCIPAL);
		userService.readUserById(principal.getId());

		// Todo
		model.addAttribute("principal", principal);
		return "/user/changePw";
	}

	@PostMapping("/changePw")
	public String changePwProc(PasswordCheckDto passwordCheckDto) {
		User principal = (User) session.getAttribute(Define.PRINCIPAL);
		boolean isChecked = bCryptPasswordEncoder.matches(passwordCheckDto.getPassword(), principal.getPassword());

		if (isChecked == false) {
			throw new CustomRestfullException("비밀번호가 틀렸습니다.", HttpStatus.BAD_REQUEST);
		} else {
			// 실수 !!! update 처리 후 암호화 처리를 하려 해서 암호화가 안 된 값이 데이터베이스에 들어갈 뻔 함 !!!!
			// 신규 비밀번호 암호화 처리 후 update
			if (passwordCheckDto.getNewPassword().equals(passwordCheckDto.getNewPasswordCheck())) {
				// 신규 비밀번호와 신규 비밀번호 확인이 같다면 update 처리
				// 실수 !!!!!!!!!!! encode 해야할 비밀번호는 NewPassword다 !!!!!!!!!!
				String hashPw = bCryptPasswordEncoder.encode(passwordCheckDto.getNewPassword());
				// !!! 상태값 변경 - 암호화 된 비밀번호를 set 해준다 !!!
				passwordCheckDto.setPassword(hashPw);
				passwordCheckDto.setId(principal.getId());
				userService.updateUserById(passwordCheckDto);
			} else {
				// 같지 않다면 예외처리
				throw new CustomRestfullException("입력하신 신규 비밀번호와 일치하지 않습니다.", HttpStatus.BAD_REQUEST);
			}

		}

		// todo 마이페이지로 이동 아마 ??
		return "redirect:/";
	}

	// 특별 기내식 신청 내역 페이지
	@GetMapping("/myServiceReq")
	public String myServiceReqPage(Model model) {
		User principal = (User) session.getAttribute(Define.PRINCIPAL);
		List<SpecialMealResponseDto> specialMealResponseDtos = inFlightSvService
				.readRequestMealByMemberId(principal.getId());
		List<InFlightMealResponseDto> inFlightServiceResponseDtos = inFlightSvService
				.readInFlightMealSchedule(principal.getId());

		model.addAttribute("specialMealResponseDtos", specialMealResponseDtos);
		model.addAttribute("inFlightServiceResponseDtos", inFlightServiceResponseDtos);

		return "/user/myServiceReq";
	}

	// 특별 기내식 신청 내역 페이지 (수정 및 삭제)
	@PostMapping("/myReqServiceDelete")
	public String myReqServiceDeleteProc(@RequestParam Integer id) {
		inFlightSvService.deleteRequestMealById(id);
		return "redirect:/myServiceReq";
	}

	// 위탁 수하물 신청 내역 페이지 (수정 및 삭제)
	@GetMapping("/myBaggageReq")
	public String myBaggageReqPage(Model model) {
		User principal = (User) session.getAttribute(Define.PRINCIPAL);

		// Todo
		// 위탁 수하물 신청 정보 갖고 오기
		List<BaggageReqResponseDto> baggageReqResponses = baggageRequestService
				.readBaggageReqByMemberId(principal.getId());
		List<InFlightMealResponseDto> inFlightServiceResponseDtos = inFlightSvService
				.readInFlightMealSchedule(principal.getId());
		model.addAttribute("inFlightServiceResponseDtos", inFlightServiceResponseDtos);
		model.addAttribute("baggageReqResponses", baggageReqResponses);

		return "/user/myBaggageReq";
	}

}
