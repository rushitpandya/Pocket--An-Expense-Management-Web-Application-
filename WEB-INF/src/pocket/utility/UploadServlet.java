package pocket.utility;

import java.io.*;
import java.util.*;
import pocket.beans.*; 
import pocket.dao.*;
import javax.servlet.*;
import javax.servlet.http.*;

 
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.output.*;

public class UploadServlet extends HttpServlet {
   
   private boolean isMultipart;
   private String filePath;
   private int maxFileSize = 50 * 1024 *1024;
   private int maxMemSize = 4 * 1024;
   private File file ;

  
   public void doPost(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, java.io.IOException {
   
      // Check that we have a file upload request
	  String filePath = System.getenv("CATALINA_HOME")+"\\webapps\\Pocket\\assets-login\\img\\";
      isMultipart = ServletFileUpload.isMultipartContent(request);
      response.setContentType("text/html");
      java.io.PrintWriter out = response.getWriter( );
			
      if( !isMultipart ) {
         out.println("<html>");
         out.println("<head>");
         out.println("<title>Servlet upload</title>");  
         out.println("</head>");
         out.println("<body>");
         out.println("<p>No file uploaded</p>"); 
         out.println("</body>");
         out.println("</html>");
         return;
      }
		
      DiskFileItemFactory factory = new DiskFileItemFactory();
   
      // maximum size that will be stored in memory
     // factory.setSizeThreshold(maxMemSize);
   
      // Location to save data that is larger than maxMemSize.
      //factory.setRepository(new File("c:\\temp"));

      // Create a new file upload handler
      ServletFileUpload upload = new ServletFileUpload(factory);
   
      // maximum file size to be uploaded.
      upload.setSizeMax( maxFileSize );

      try { 
         // Parse the request to get file items.
         List fileItems = upload.parseRequest(request);
	
         // Process the uploaded file items
         Iterator i = fileItems.iterator();
			
         out.println("<html>");
         out.println("<head>");
         out.println("<title>Servlet upload</title>");  
         out.println("</head>");
         out.println("<body>");
		 String fileName=null;
         while ( i.hasNext () ) {
            FileItem fi = (FileItem)i.next();
            if ( !fi.isFormField () ) {
               // Get the uploaded file parameters
               String fieldName = fi.getFieldName();
               //String fileName = fi.getName();
               String contentType = fi.getContentType();
               boolean isInMemory = fi.isInMemory();
               long sizeInBytes = fi.getSize();
            
               // Write the file
               if( fileName.lastIndexOf("\\") >= 0 ) {
                  file = new File( filePath + fileName.substring( fileName.lastIndexOf("\\"))) ;
               } else {
                  file = new File( filePath + fileName.substring(fileName.lastIndexOf("\\")+1)) ;
               }
               fi.write( file ) ;
               out.println("Uploaded Filename: " + fileName + "<br>");
			   UserDetail userDetail=null;
			   HttpSession session = request.getSession();
				if(session.getAttribute("User")!= null)
				{
					userDetail = (UserDetail)session.getAttribute("User");	
				}
				userDetail.setProfilePic(fileName);
				session.setAttribute("User",userDetail);
				LoginDao loginDao = new LoginDao();
				loginDao.changeProfilePicture(userDetail);
				session.setAttribute("errorMsg", "Profile Picture Uploaded Successfully!");
				response.sendRedirect("jsp/profile.jsp");
            }
			else{
				String name = fi.getFieldName();
				if(name.equals("fileName"))
				{	
					fileName = fi.getString()+".jpg";
					out.println(fileName);
					
				}
			}
         }
         out.println("</body>");
         out.println("</html>");
         } catch(Exception ex) {
            System.out.println(ex);
         }
      }
      
      public void doGet(HttpServletRequest request, HttpServletResponse response)
         throws ServletException, java.io.IOException {

         throw new ServletException("GET method used with " +
            getClass( ).getName( )+": POST method required.");
      }
  }
