package kr.spring.member.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.member.dao.MemberMapper;
import kr.spring.member.vo.MemberVO;

@Service
@Transactional
public class MemberServiceImpl implements MemberService{
	@Autowired
	private MemberMapper memberMapper;
	
	@Override
	public void insertMember(MemberVO member) {
		member.setMem_num(memberMapper.selectMem_num());
		memberMapper.insertMember(member);
		memberMapper.insertMember_detail(member);
	}

	@Override
	public MemberVO selectCheckMember(String mem_id) {
		return memberMapper.selectCheckMember(mem_id);
	}

	@Override
	public MemberVO selectMember(int mem_num) {
		return memberMapper.selectMember(mem_num);
	}

	

	@Override
	public void updateMember_detail(MemberVO member) {
		memberMapper.updateMember_detail(member);
	}

	@Override
	public void updatePassword(MemberVO member) {
		// TODO Auto-generated method stub
		
	}

	

	@Override
	public void updateProfile(MemberVO member) {
		memberMapper.updateProfile(member);
	}

	@Override
	public int selectCheckMemberRegistered(MemberVO member) {
		return memberMapper.selectCheckMemberRegistered(member);
	}

	@Override
	public void updateAutoid(String mem_autoid, int mem_num) {
		memberMapper.updateAutoid(mem_autoid, mem_num);
	}

	@Override
	public MemberVO selectAutoid(String mem_autoid) {
		return memberMapper.selectAutoid(mem_autoid);
	}

	@Override
	public void deleteAutoid(int mem_num) {
		// TODO Auto-generated method stub
		
	}
	//회원 탈퇴 처리 트랜잭션
	@Override
	public void withdrawMember(int mem_num) {
		memberMapper.deleteMember_detail(mem_num);
		memberMapper.updateMemberAuthByWithdraw(mem_num);
	}

	@Override
	public void changeNickname(MemberVO member) {
		memberMapper.changeNickname(member);
	}

	

}
