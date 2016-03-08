package cn.com.cippus.web.dao;

import java.util.Map;

import org.springframework.jdbc.core.ColumnMapRowMapper;

import cn.com.cippus.web.common.CaseInsensitiveHashMap;



/**
 * 对数据库数据记录的包�?
 * 不区分键值大小写(转为大写)
 * @author chenr
 * @version 2.0.0, 2011-10-28
 * @see org.springframework.jdbc.core.ColumnMapRowMapper
 */
public class MapRowMapper extends ColumnMapRowMapper {

	@Override
	protected Map<String, Object> createColumnMap(int columnCount) {
		
		return new CaseInsensitiveHashMap<String, Object>(columnCount);
	}
}
