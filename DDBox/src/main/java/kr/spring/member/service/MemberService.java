package kr.spring.member.service;


import kr.spring.member.vo.MemberVO;

public interface MemberService {
	//회원관리 - 사용자
	public void insertMember(MemberVO member);
	public MemberVO selectCheckMember(String mem_id);
	public MemberVO selectMember(int mem_num);
	public void updateMember_detail(MemberVO member);
	public void updatePassword(MemberVO member);
	
	public int selectCheckMemberRegistered(MemberVO member);
	
	//회원 탈퇴
	public void withdrawMember(int mem_num);



	//자동 로그인
	public void updateAutoid(String mem_autoid, int mem_num);
	public MemberVO selectAutoid(String autoid);
	public void deleteAutoid(int mem_num);

	//프로필 이미지 업데이트
	public void updateProfile(MemberVO member);
	
	//닉네임 변경
	public void changeNickname(MemberVO member);
	
	//회원관리 - 관리자
		
}
