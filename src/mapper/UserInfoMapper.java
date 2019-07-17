package mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import entity.UserInfo;

public interface UserInfoMapper  {
	@Select("select * from chat where name=#{name} and password=#{password}")
	List<UserInfo> selectByNamePwd(UserInfo user);
	@Insert("insert into chat(name,password,phone,email,gender) values(#{name},#{password},#{phone},#{email},#{gender})")
	int insertUserInfo(UserInfo user);
}
