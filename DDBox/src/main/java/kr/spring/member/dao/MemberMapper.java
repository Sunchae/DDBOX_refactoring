package kr.spring.member.dao;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.member.vo.MemberVO;

@Mapper
public interface MemberMapper {
	//회원관리 - 사용자ㅇㅇㅇㅇㅇ
	@Select("SELECT member_seq.nextval FROM dual")
	public int selectMem_num();
	@Insert("INSERT INTO member (mem_num,mem_id) VALUES (#{mem_num},#{mem_id})")
	public void insertMember(MemberVO member);
	public void insertMember_detail(MemberVO member);

	public int selectCheckMemberRegistered(MemberVO member);

	public MemberVO selectCheckMember(String mem_id);
	@Select("SELECT * FROM member JOIN member_detail USING (mem_num) WHERE mem_num=#{mem_num}")
	public MemberVO selectMember(int mem_num);

	//회원 정보 수정 
	public void updateMember(MemberVO member);
	public void updateMember_detail(MemberVO member);
	public void updatePassword(MemberVO member);

	//회원 탈퇴(member 테이블에선 mem_auth:3으로 바꿔서 탈퇴회원임을 입력. member detail 파트는 다 delete
	@Update("UPDATE member SET mem_auth = 3 WHERE mem_num=#{mem_num}")
	public void updateMemberAuthByWithdraw(int mem_num);
	@Delete("DELETE FROM member_detail WHERE mem_num=#{mem_num}") 
	public void deleteMember_detail(int mem_num);
	public boolean checkPassword(String inputPassword, String storedPassword);

	//자동 로그인
	@Update("UPDATE member_detail SET mem_autoid=#{mem_autoid} WHERE mem_num=#{mem_num}")
	public void updateAutoid(String mem_autoid, int mem_num);
	@Select("SELECT mem_num,mem_id,mem_auth,mem_autoid,mem_pw,mem_nickname,mem_email FROM member JOIN member_detail USING(mem_num) WHERE mem_autoid=#{mem_autoid}")
	public MemberVO selectAutoid(String autoid);
	public void deleteAutoid(int mem_num);

	//프로필 이미지 업데이트
	@Update("UPDATE member_detail SET mem_photo=#{mem_photo},mem_photoname=#{mem_photoname} WHERE mem_num=#{mem_num}")
	public void updateProfile(MemberVO member);
	
	//닉네임 업데이트
	@Update("UPDATE member_detail SET mem_nickname=#{mem_nickname} WHERE mem_num=#{mem_num}")
	public void changeNickname(MemberVO member);
	
	
	//회원관리 - 관리자

}

























