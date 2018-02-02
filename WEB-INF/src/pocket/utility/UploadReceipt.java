package pocket.utility;

import java.io.*;
import java.util.*;
import pocket.beans.*; 
import pocket.dao.*;
import javax.servlet.*;
import javax.servlet.http.*;
import org.json.JSONObject;
import org.json.JSONArray;
import com.google.gson.Gson;
 
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.output.*;

public class UploadReceipt extends HttpServlet {
   
   private boolean isMultipart;
   private String filePath;
   private int maxFileSize = 50 * 1024 *1024;
   private int maxMemSize = 4 * 1024;
   private File file ;

  
   public void doPost(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, java.io.IOException {
   
      // Check that we have a file upload request
	  String filePath = System.getenv("CATALINA_HOME")+"\\webapps\\Pocket\\images\\";
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
			
         //out.println("<html>");
         //out.println("<head>");
         //out.println("<title>Servlet upload</title>");  
         //out.println("</head>");
         //out.println("<body>");
		 
		 Random rand = new Random();
		 int i1=rand.nextInt(1000);
		 String fileName="image"+i1+".png";
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
               //out.println("Uploaded Filename: " + fileName + "<br>");
			   
				Gson gson=new Gson();
				response.setContentType("application/json");
				String jsonString=gson.toJson(fileName);
				response.getWriter().println(jsonString);
				//session.setAttribute("errorMsg", "Profile Picture Uploaded Successfully!");
				//response.sendRedirect("jsp/profile.jsp");
            }
			
         }
         //out.println("</body>");
         //out.println("</html>");
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
