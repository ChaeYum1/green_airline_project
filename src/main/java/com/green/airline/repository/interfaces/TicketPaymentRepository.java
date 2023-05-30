package com.green.airline.repository.interfaces;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.green.airline.dto.response.MonthlySalesForChartDto;
import com.green.airline.repository.model.TicketPayment;

/**
 * @author 서영
 *
 */
@Mapper
public interface TicketPaymentRepository {

	public Integer insert(TicketPayment ticketPayment);
	
	public Integer updateStatus(@Param("ticketId") String ticketId, @Param("status1") Integer status1, @Param("status2") Integer status2);
	
	public Integer updateStatusByTid(@Param("tid") String tid, @Param("type") Integer type, @Param("status") Integer status);
	
	public TicketPayment selectByTicketId(String ticketId);
	
	// 최근 1년간 월간 매출액 
	public List<MonthlySalesForChartDto> selectSalesGroupByDate();
	
}
