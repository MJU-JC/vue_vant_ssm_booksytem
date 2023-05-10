package com.client.controller;

import java.util.HashMap;
import java.util.List;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.ui.Model;

import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;

import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;

import org.springframework.web.bind.annotation.ModelAttribute;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import com.chengxusheji.po.BookType;
import com.chengxusheji.service.BookTypeService;
import com.client.service.AuthService;
import com.client.utils.JsonResult;
import com.client.utils.JsonResultBuilder;
import com.client.utils.ReturnCode;

@RestController
@RequestMapping("/api/bookType") 
public class ApiBookTypeController {
	@Resource BookTypeService bookTypeService;
	@Resource AuthService authService;

	@InitBinder("bookType")
	public void initBinderBookType(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("bookType.");
	}

	/*客户端ajax方式添加图书类型信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public JsonResult add(@Validated BookType bookType, BindingResult br, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		//通过accessToken获取到用户信息 
		String userName = authService.getUserName(request);
		if(userName == null) return JsonResultBuilder.error(ReturnCode.TOKEN_VALID_ERROR);
		if (br.hasErrors()) //验证输入参数
			return JsonResultBuilder.error(ReturnCode.INPUT_PARAM_ERROR);
        bookTypeService.addBookType(bookType); //添加到数据库
        return JsonResultBuilder.ok();
	}

	/*客户端ajax更新图书类型信息*/
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public JsonResult update(@Validated BookType bookType, BindingResult br, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		//通过accessToken获取到用户信息 
		String userName = authService.getUserName(request);
		if(userName == null) return JsonResultBuilder.error(ReturnCode.TOKEN_VALID_ERROR);
		if (br.hasErrors())  //验证输入参数
			return JsonResultBuilder.error(ReturnCode.INPUT_PARAM_ERROR); 
        bookTypeService.updateBookType(bookType);  //更新记录到数据库
        return JsonResultBuilder.ok(bookTypeService.getBookType(bookType.getBookTypeId()));
	}

	/*ajax方式显示获取图书类型详细信息*/
	@RequestMapping(value="/get/{bookTypeId}",method=RequestMethod.POST)
	public JsonResult getBookType(@PathVariable int bookTypeId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键bookTypeId获取BookType对象*/
        BookType bookType = bookTypeService.getBookType(bookTypeId); 
        return JsonResultBuilder.ok(bookType);
	}

	/*ajax方式删除图书类型记录*/
	@RequestMapping(value="/delete/{bookTypeId}",method=RequestMethod.POST)
	public JsonResult deleteBookType(@PathVariable int bookTypeId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
		//通过accessToken获取到用户信息 
		String userName = authService.getUserName(request);
		if(userName == null) return JsonResultBuilder.error(ReturnCode.TOKEN_VALID_ERROR);
		try {
			bookTypeService.deleteBookType(bookTypeId);
			return JsonResultBuilder.ok();
		} catch (Exception ex) {
			return JsonResultBuilder.error(ReturnCode.FOREIGN_KEY_CONSTRAINT_ERROR);
		}
	}

	//客户端查询图书类型信息
	@RequestMapping(value="/list",method=RequestMethod.POST)
	public JsonResult list(Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if(rows != 0)bookTypeService.setRows(rows);
		List<BookType> bookTypeList = bookTypeService.queryBookType(page);
	    /*计算总的页数和总的记录数*/
	    bookTypeService.queryTotalPageAndRecordNumber();
	    /*获取到总的页码数目*/
	    int totalPage = bookTypeService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = bookTypeService.getRecordNumber();
	    HashMap<String, Object> resultMap = new HashMap<String, Object>();
	    resultMap.put("totalPage", totalPage);
	    resultMap.put("list", bookTypeList);
	    return JsonResultBuilder.ok(resultMap);
	}

	//客户端ajax获取所有图书类型
	@RequestMapping(value="/listAll",method=RequestMethod.POST)
	public JsonResult listAll() throws Exception{
		List<BookType> bookTypeList = bookTypeService.queryAllBookType(); 
		return JsonResultBuilder.ok(bookTypeList);
	}
}

