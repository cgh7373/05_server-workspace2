package com.ncs.test.member.model.service;

import org.apache.ibatis.session.SqlSession;

import com.ncs.test.common.template.Template;

import com.ncs.test.member.model.dao.MemberDAO;

import com.ncs.test.member.model.vo.Member;

public class MemberServiceImpl implements MemberService {

private MemberDAO mDao = new MemberDAO();

@Override

public Member memberLogin(Member m) {

SqlSession sqlSession = Template.getSqlSession();

Member loginMember = mDao.memberLogin(sqlSession, m);

sqlSession.close();

return loginMember;

}

}