package com.ncs.test.member.model.dao;

import org.apache.ibatis.session.SqlSession;

import com.ncs.test.member.model.vo.Member;

public class MemberDAO {

public Member memberLogin(SqlSession sqlSession, Member m) {

return sqlSession.selectOne("member.loginMember", m);

}

}