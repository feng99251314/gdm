package com.gxwzu.core.util.poi;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.apache.commons.io.output.ByteArrayOutputStream;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFPrintSetup;
import org.apache.poi.xssf.usermodel.XSSFRichTextString;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.gxwzu.core.util.poi.ExcelSheetModel;
import com.gxwzu.sysVO.ListGroupAllotExport;
import com.gxwzu.sysVO.ListProgressSitu;
import com.gxwzu.sysVO.ListStudent;
import com.gxwzu.system.model.sysStudent.SysStudent;
public class MergingExcelUtils {
	private static final Log log = LogFactory.getLog(ExcelUtils.class);
	private static String EXCEL_2003 = ".xls";
	private static String EXCEL_2007 = ".xlsx";

	/**
	 * 通过POI方式读取Excel
	 * 
	 * @param excelFile
	 */
	public static ExcelDataSet readExcelPOI(File excelFile, Integer cons,int sheetNum)
			throws Exception {
		log.info("读取Excel...."+excelFile != null);
		ExcelDataSet dataSet=null;
		if (excelFile != null) {
			 dataSet = readExcelPOI2007(excelFile, cons,sheetNum);
		}else{
			 dataSet = readExcelPOI2003(excelFile, cons,sheetNum);
		}
		return dataSet;
	}
	/**
	 * 读取Excel2003的表单
	 * 
	 * @param excelFile
	 * @return
	 * @throws Exception
	 */
	public static ExcelDataSet readExcelPOI2003(File excelFile,
			Integer rCons,int sheetNum) throws Exception {
		ExcelDataSet dataSet = new ExcelDataSet();
		InputStream input=null;
		HSSFWorkbook workBook=null;
		try{
		List<String[]> datasList = new ArrayList<String[]>();
		Set<String> colsSet = new HashSet<String>();
		 input = new FileInputStream(excelFile);
		 workBook = new HSSFWorkbook(input);
		// 获取Excel的sheet数量
		Integer sheetNums = workBook.getNumberOfSheets();
		// 循环Sheet表单
		for (int i = 0; i < sheetNums; i++) {
			HSSFSheet sheet = workBook.getSheetAt(i);
			if (sheet == null) {
				continue;
			}
			// 获取Sheet里面的Row数量
			Integer rowNum = sheet.getLastRowNum() + 1;
			for (int j = 0; j < rowNum; j++) {
				if (j > rCons) {
					HSSFRow row = sheet.getRow(j);
					if (row == null) {
						continue;
					}
					Integer cellNum = row.getLastCellNum() + 1;
					String[] datas = new String[cellNum];
					for (int k = 0; k < cellNum; k++) {
						HSSFCell cell = row.getCell(k);
						if (cell == null) {
							continue;
						}
						if (cell != null) {
							cell.setCellType(HSSFCell.CELL_TYPE_STRING);
							String cellValue = "";
							int cellValueType = cell.getCellType();
							if (cellValueType == Cell.CELL_TYPE_STRING) {
								cellValue = cell.getStringCellValue();
							}
							if (cellValueType == Cell.CELL_TYPE_NUMERIC) {
								Double number = cell.getNumericCellValue();
								cellValue = number + "";
							}

							if (rCons == k) {
								colsSet.add(cellValue);
							}
							datas[k] = cellValue;
						}
					}
					datasList.add(datas);
				}
			}
		}
	
		dataSet.setDatasList(datasList);
		dataSet.setConStrctSet(colsSet);
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			
			if(input!=null){
				input.close();
			}
		}
		return dataSet;
	}

	/**
	 * 读取Excel2007的表单
	 * 
	 * @param excelFile
	 * @return
	 * @throws Exception
	 */
	private static ExcelDataSet readExcelPOI2007(File excelFile,
			Integer rCons,int sheetNum) throws Exception {
		InputStream input=null;
		XSSFWorkbook workBook=null;
		ExcelDataSet dataSet = new ExcelDataSet();
		try{
		List<String[]> datasList = new ArrayList<String[]>();
		
		 input = new FileInputStream(excelFile);
		 workBook = new XSSFWorkbook(input);
		 Integer sheetNums = workBook.getNumberOfSheets();
		 XSSFSheet sheet = workBook.getSheetAt(sheetNum);
			if (sheetNum>sheetNums) {
				dataSet.setMsg("Excel中sheet个数少于取值");
				return dataSet;
			}
			// 获取行值
			Integer rowNum = sheet.getLastRowNum() + 1;
			for (int j = 0; j < rowNum; j++) {
				if (j > rCons) {
					XSSFRow row = sheet.getRow(j);
					
					if (row == null) {
						continue;
					}
					Integer cellNum = row.getLastCellNum() + 1;
					String[] datas = new String[cellNum];
					for (int k = 0; k < cellNum; k++) {
						XSSFCell cell = row.getCell(k);
						if (cell == null) {
							continue;
						}
						if (cell != null) {
							cell.setCellType(XSSFCell.CELL_TYPE_STRING);
							String cellValue = "";
							int cellValueType = cell.getCellType();
							if (cellValueType == Cell.CELL_TYPE_STRING) {
								cellValue = cell.getStringCellValue();
							}
							if (cellValueType == Cell.CELL_TYPE_NUMERIC) {
								Double number = cell.getNumericCellValue();
								cellValue = number + "";
							}
							
							datas[k] = cellValue;
						}
					}
					datasList.add(datas);
				}
			}
	
		dataSet.setDatasList(datasList);
		
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			
			if(input!=null){
				input.close();
			}
		}
		return dataSet;
	}
	/**
	 * 读取模板路径
	 * @param webRoot
	 * @param templeNo
	 * @return
	 */
	private static XSSFWorkbook workbook(String tmplPath){
		log.info("##读取模板路径！");
		try {
			XSSFWorkbook workbook = null;
			workbook = new XSSFWorkbook(new FileInputStream(tmplPath));
			return workbook;
		}catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	
	/**
	 * 合并跨列
	 * @param lProgressSitu 
	 * @param LStudent 
	 * @param args
	 * @throws IOException
	 */
	public static InputStream merginExport(ExcelSheetModel model,String tmplPath, List<ListProgressSitu> lProgressSitu, ListStudent  LStudent) {
		try{
			XSSFWorkbook workbook = null;
			Workbook wb = new XSSFWorkbook();   
			workbook=workbook(tmplPath);
			if(workbook==null){
				return null;
			}
			XSSFSheet sheet = null;
			// 生成一个表格
			sheet = workbook.getSheetAt(model.getSheetNum());
			// 定义单元格样式
			XSSFCellStyle style = workbook.createCellStyle();
			style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setDataFormat(workbook.createDataFormat().getFormat("@"));
			
			// 遍历集合数据，产生数据行
			int startRow=model.getRowIndex();
			int k=1;
			
			if (model.getResult() != null) {
				for (int i = startRow; i < model.getResult().size()
						+ model.getRowIndex(); i++) {
					//创建行
					XSSFRow	rows = sheet.createRow(i);
					
					rows.setHeight((short) (25 * 20));
					Object[]oc=(Object[])model.getResult().get(i-startRow);	
					//创建列 第一列 为序号
					XSSFCell cell0 = rows.createCell(0);
					cell0.setCellValue(++k);
					cell0.setCellStyle(style);
					//创建列 第三列 为序号
					for(int c=1;c<oc.length+1;c++){
						XSSFCell cell = rows.createCell(c+2);
						cell.setCellValue(convert(oc[c-1]));
						cell.setCellStyle(style);
					}
				}
			}
		Row row1 =sheet.createRow(1);
		Cell  cell1 = row1.createCell(1);
		cell1.setCellValue("学院");
		Cell  cell2 = row1.createCell(2);
		cell2.setCellValue(LStudent.getDeptName());
		Cell  cell3 = row1.createCell(3);
		cell3.setCellValue("专业");
		Cell  cell4 = row1.createCell(4);	
		cell4.setCellValue(LStudent.getMajorName());
		Cell  cell5 = row1.createCell(5);
		cell5.setCellValue("年级");
		Cell  cell6 = row1.createCell(6);	
		cell6.setCellValue(LStudent.getStuGrade());
		Cell  cell7 = row1.createCell(7);
		cell7.setCellValue("姓名");
		Cell  cell8 = row1.createCell(8);	
		cell8.setCellValue(LStudent.getStuName());
		
            int num =0;
            for(int i=0;i<lProgressSitu.size();i++){           	         
            		Row row = sheet.createRow(i+3); 
            		Cell  cell9 = row.createCell(0);
            		Cell  cell10 = row.createCell(1);
            		Cell  cell11 = row.createCell(2);
            		Cell  cell12 = row.createCell(5);
            		cell9.setCellValue(i+1);
            		cell10.setCellValue(lProgressSitu.get(i).getProgressTime());
            		cell11.setCellValue(lProgressSitu.get(i).getProgressWork());
            		cell12.setCellValue(lProgressSitu.get(i).getProgressRecord());      
            	    sheet.addMergedRegion(new CellRangeAddress(i+3, i+3, 2, 4));
                    sheet.addMergedRegion(new CellRangeAddress(i+3, i+3, 5, 7));
         }       
			sheet.getPrintSetup().setLandscape(false); // 打印方向，true：横向，false：纵向
			sheet.getPrintSetup().setPaperSize(XSSFPrintSetup.A4_PAPERSIZE); // 纸张
			sheet.getPrintSetup().setScale((short) 85); // 设置打印缩放比例80%
			sheet.getPrintSetup().setHeaderMargin((double) 0.25);// 设置页眉打印范围
			sheet.getPrintSetup().setFooterMargin((double) 0.25);// 设置页眉打印范围
			sheet.setMargin(XSSFSheet.BottomMargin, 0.5);
			sheet.setMargin(XSSFSheet.LeftMargin, 0.25);
			sheet.setMargin(XSSFSheet.RightMargin, 0.25);
			sheet.setMargin(XSSFSheet.TopMargin, 0.5);
			
			
			ByteArrayOutputStream baos = new ByteArrayOutputStream();
			
			workbook.write(baos);// 写入
			
			byte[] ba = baos.toByteArray();
			ByteArrayInputStream bais = new ByteArrayInputStream(ba);
			return bais;
		}catch (IOException e) {
			e.printStackTrace();
			return null;
		}
	}
	
	/**
	 * 转换类型
	 * @param value
	 * @return
	 */
	private static String convert(Object value){
		if(value!=null){
			if(value instanceof Boolean){
				value=(Boolean)value==true?"是":"否";
			}
			
		}else{
			value="";
		}
		return value.toString();
	}
	
	
	/**
	 * 导出分组
	 * @param excelSheetModel
	 * @param modelPath
	 * @param list
	 * @return
	 */
	public static InputStream groupExport(ExcelSheetModel model,
			String tmplPath, List<ListGroupAllotExport> list) {
		try{
			System.out.println("导出路径："+tmplPath);
			//创建一个excel实例
			XSSFWorkbook workbook = new XSSFWorkbook(); 
			//读取模板信息
			workbook = workbook(tmplPath);
			if(workbook==null){
				return null;
			}
			XSSFSheet sheet = null;
			// 生成一个表格（sheet工作蒲）
			System.out.println("工作蒲个数："+model.getSheetNum());
			sheet = workbook.getSheetAt(model.getSheetNum());
			// 定义单元格样式
			XSSFCellStyle style = workbook.createCellStyle();
			style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setDataFormat(workbook.createDataFormat().getFormat("@"));
			
			// 遍历集合数据，产生数据行
			int startRow = model.getRowIndex();
			System.out.println("rowIndex:"+model.getRowIndex());
			System.out.println("结果集长度:"+model.getResult().size());
			int num = 1;
			if (list != null) {
				for (int i = startRow; i < list.size()+startRow; i++) {
					
					//创建行
					XSSFRow	rows = sheet.createRow(i);
					rows.setHeight((short) (25 * 20));
					//创建列 第一列 为序号
					XSSFCell cell0 = rows.createCell(0);
					cell0.setCellValue(num++);
					cell0.setCellStyle(style);
					
					XSSFCell cell1 = rows.createCell(1);
					cell1.setCellValue(list.get(i-startRow).getStuNo());
					
					XSSFCell cell2 = rows.createCell(2);
					cell2.setCellValue(list.get(i-startRow).getStuName());
					
					XSSFCell cell3 = rows.createCell(3);
					cell3.setCellValue(list.get(i-startRow).getClassName());
					
					XSSFCell cell4 = rows.createCell(4);
					cell4.setCellValue(list.get(i-startRow).getTeacherName());
					
					XSSFCell cell5 = rows.createCell(5);
					cell5.setCellValue(list.get(i-startRow).getIssueName());
					
					XSSFCell cell6 = rows.createCell(6);
					cell6.setCellValue("");
					
					XSSFCell cell7 = rows.createCell(7);
					cell7.setCellValue(list.get(i-startRow).getGroupName()+","+list.get(i-startRow).getGroupTeacherNames()+
							           ",地点：("+list.get(i-startRow).getClassroomName()+")");
				}
			}

			sheet.getPrintSetup().setLandscape(false); // 打印方向，true：横向，false：纵向
			sheet.getPrintSetup().setPaperSize(XSSFPrintSetup.A4_PAPERSIZE); // 纸张
			sheet.getPrintSetup().setScale((short) 85); // 设置打印缩放比例80%
			sheet.getPrintSetup().setHeaderMargin((double) 0.25);// 设置页眉打印范围
			sheet.getPrintSetup().setFooterMargin((double) 0.25);// 设置页眉打印范围
			sheet.setMargin(XSSFSheet.BottomMargin, 0.5);
			sheet.setMargin(XSSFSheet.LeftMargin, 0.25);
			sheet.setMargin(XSSFSheet.RightMargin, 0.25);
			sheet.setMargin(XSSFSheet.TopMargin, 0.5);
			ByteArrayOutputStream baos = new ByteArrayOutputStream();
			workbook.write(baos);// 写入
			
			byte[] ba = baos.toByteArray();
			ByteArrayInputStream bais = new ByteArrayInputStream(ba);
			return bais;
		}catch (IOException e) {
			e.printStackTrace();
			return null;
		}
	}
}
