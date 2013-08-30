package com.ht2000.struts;

import java.io.File;
import java.io.IOException;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

public class FileUploadServlet extends HttpServlet {

	private static final long serialVersionUID = -8729113147827103362L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		DiskFileItemFactory factory = new DiskFileItemFactory();
		ServletFileUpload upload = new ServletFileUpload(factory);
		try {
			List items = upload.parseRequest(request);
			System.out.println("file.size:" + items.size());
			Iterator itr = items.iterator();
			while (itr.hasNext()) {
				FileItem item = (FileItem) itr.next();
				if (item.isFormField()) {
					System.out.println("表单参数名:" + item.getFieldName()
							+ "，表单参数值:" + item.getString("UTF-8"));
				} else {
					if (item.getName() != null && !item.getName().equals("")) {
						System.out.println("上传文件的大小:" + item.getSize());
						System.out.println("上传文件的类型:" + item.getContentType());
						System.out.println("上传文件的名称:" + item.getName());

						// 上传文件的保存路径
						File file = new File(request.getRealPath("/upload"),
								"upgrate");
						if (file.exists())
							file.deleteOnExit();
						item.write(file);
						System.out.println("上传文件成功！");
						request.setAttribute("message", "上传文件成功！");
					} else {
						System.out.println("没有选择上传文件！");
						request.setAttribute("message", "没有选择上传文件！");
					}
				}
			}
		} catch (FileUploadException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("message", "上传文件失败！");
		}
		request.getRequestDispatcher("/Pages/Update/update.jsp").forward(
				request, response);
	}

	@Override
	public void init() throws ServletException {
		super.init();
	}
}
