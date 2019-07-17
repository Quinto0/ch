package utils;

import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class Utils {
	
	/**
	 * @Description 获得服务器当前时间格式为yyyy-MM-dd HH:mm:ss
	 * @return String
	 */
	public static String getCurrentTime() {		
		SimpleDateFormat simple = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return simple.format(new Date());
		
	}
	/**
	 * @Description 读取mybatis配置文件，获得SqlSession
	 * @return SqlSession
	 */
	public static SqlSession getSqlSession() {
		InputStream is;
		try {
			is = Resources.getResourceAsStream("mybatis.xml");
			SqlSessionFactory ssf = new SqlSessionFactoryBuilder().build(is);
			SqlSession sqlSession = ssf.openSession(true);
			is.close();
			return sqlSession;
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
}
