package com.Perkinelmer.SSO.Mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

@Mapper
public interface CommonMapper {
    @Insert("${sql}")
    int insert(@Param("sql") String sql);

    @Select("${sql}")
    List<Map<String, Object>> select(@Param("sql") String sql);

    @Update("${sql}")
    List<Map<String, Object>> update(@Param("sql") String sql);

    @Delete("${sql}")
    int delete(@Param("sql") String sql);
}
