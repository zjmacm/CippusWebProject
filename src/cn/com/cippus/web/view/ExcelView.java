package cn.com.cippus.web.view;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.context.support.WebApplicationObjectSupport;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.view.document.AbstractExcelView;
import org.apache.poi.hssf.usermodel.*;

public class ExcelView extends AbstractExcelView {

	@Override
	public String getContentType() {
		return "application/ms-excel";
	}

	@Override
	protected void buildExcelDocument(Map<String, Object> model,
			HSSFWorkbook workbook, HttpServletRequest reuest,
			HttpServletResponse response) throws Exception {
		
		HSSFSheet sheet = workbook.createSheet("Spring");
		sheet.setDefaultColumnWidth(12);

		// Write a text at A1.
		HSSFCell cell = getCell(sheet, 0, 0);
		setText(cell, "Spring POI test");

		// Write the current date at A2.
		HSSFCellStyle dateStyle = workbook.createCellStyle();
		dateStyle.setDataFormat(HSSFDataFormat.getBuiltinFormat("m/d/yy"));
		cell = getCell(sheet, 1, 0);
		cell.setCellValue(new Date());
		cell.setCellStyle(dateStyle);

		// Write a number at A3
		getCell(sheet, 2, 0).setCellValue(458);

		// Write a range of numbers.
		HSSFRow sheetRow = sheet.createRow(3);
		for (int i = 0; i < 10; i++) {
			sheetRow.createCell(i).setCellValue(i * 10);
		}

	
		String filename = "测试.xls";// 设置下载时客户端Excel的名�?
		filename = java.net.URLEncoder.encode(filename, "UTF-8");// 处理中文文件�?
		
		response.setHeader("Content-disposition", "attachment;filename="
				+ filename);
		

	}

}
